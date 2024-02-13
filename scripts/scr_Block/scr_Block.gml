enum BLOCK {
	AIR     = 0,
	GRASS   = 1,
	DIRT    = 2,
	STONE   = 3,
	BEDROCK = 4
}

enum BLOCK_TEXTURE_STYLE {
	SUSHI  = 0, 	// Like the grass block
	SINGLE = 1  	// Like the dirt block
}

// Draws and erases blocks from the gameworld.
function BlockDrawer() constructor {
	// Will be initialized as a 1D array storing all the block models
	// TODO: We may need to initialize different model variations for block face culling.
	static blockModels = noone
	static blockLength = 32
	
	static initBlockModels = function() {
		if blockModels != noone {
			show_message("blockModels has already been initialized. Doing this more than once is a fatal bug and will cause slow downs. Skipping...")
			return
		}
		var uvBlockTextures = new InitializeBlockTextureActivity().initUvBlockTextures()
		blockModels = new Array1(uvBlockTextures.numBlockTypes)
		for (var blockId = BLOCK.AIR; blockId < uvBlockTextures.numBlockTypes; blockId++) {
			var uvBlockTextureItem = uvBlockTextures.get(blockId)
			if typeof(uvBlockTextureItem) == "struct" {
				var blockFormats = new LoadObject().loadBlock(uvBlockTextureItem)
				
				blockModels.set(blockId, blockFormats)
			} 
		}
		return self
	}
	
	/*
	# Vertices:                        Faces:
	#      f-------g                          +-------+ 
	#     /.      /|                         /.  TOP /|  B
	#    / .     / |                        / .     / |
	#   e-------h  |                   C   +-------+ A|
	#   |  b . .|. c      +z               |  . . .|. +
	#   | .     | /       | /-y            | . D   | /
	#   |.      |/        |/               |.      |/
	#   a-------d         +---- +x         +-------+
	#                                        BOTTOM
	#                                        
	#
	# 0b111111 is a 6 bit binary number where each bit represents a face of the cube
	# It is represented in this order: TOP, BOTTOM, A, B, C, D, where 1 is drawn and 0 is not drawn.
	*/
	static drawBlock = function(_xPos, _yPos, _zPos, _blockId = 1, _faces = 0b111111) {
		var blockInstance = instance_create_depth(_xPos * blockLength, _yPos * blockLength, 0, obj_gameObject)
		blockInstance.z = _zPos * blockLength
		blockInstance.blockId = _blockId
		blockInstance.faces = _faces
		blockInstance.cullable = true // For now all blocks will be cullable. ONLY SPECIAL BLOCKS WON'T BE
		blockInstance.model = blockModels.get(_blockId).get(_faces)
		return blockInstance
	}

	// Use this function to redraw the block to have more or less faces.
	// We should unload the block if there are no faces showing.
	// Unloaded objects should still be accessible so long as we save the instance ID (See: https://forum.gamemaker.io/index.php?threads/solved-referencing-variables-from-deactivated-instances.65011/)
	static redrawBlock = function(_blockInstance, _faces) {
		_blockInstance.faces = _faces
		_blockInstance.model = blockModels.get(_blockInstance.blockId).get(_faces)
		if _faces == 0b000000 {
			instance_deactivate_object(_blockInstance)
		} else {
			instance_activate_object(_blockInstance)
		}
	}
	
	// Use this function to erase the block from the gameworld.
	// This will DESTROY the instance, and the MMM will reference a STALE block.
	// This means we must be diligent to update the MMM after calling this function.
	static eraseBlock = function(_blockInstance) {
		instance_destroy(_blockInstance)
	}
}

// Gets the UV texture coordinates for every type of block ID. 
// For now, I rely on this function to define the different blocks in the game.
function InitializeBlockTextureActivity() constructor {
	
	static uvBlockTextures = pointer_null
	static uvMagicNumber = 0.0625
	static numBlockTypes = 10
	
	static get = function(_blockId) {
		return uvBlockTextures.get(_blockId)
	}
	
	static initUvBlockTextures = function() { 
		if uvBlockTextures != pointer_null {
			show_message("uvBlockTextures has already been initialized. Doing this more than once is a fatal bug and will cause slowdowns. Skipping...")
			return
		}
		// I probably should move these hardcoded values to some data file later on...
		// Basically this SHOULD be a 1D array where the index is the block ID and the element is the UV texture item.
		uvBlockTextures = new Array1(numBlockTypes)
		uvBlockTextures.set(BLOCK.GRASS,    __initUvBlockTextureItem(BLOCK_TEXTURE_STYLE.SUSHI,  0, 0))
		uvBlockTextures.set(BLOCK.DIRT,     __initUvBlockTextureItem(BLOCK_TEXTURE_STYLE.SINGLE, 0, 0))
		uvBlockTextures.set(BLOCK.STONE,    __initUvBlockTextureItem(BLOCK_TEXTURE_STYLE.SINGLE, 0, 1))
		uvBlockTextures.set(BLOCK.BEDROCK,  __initUvBlockTextureItem(BLOCK_TEXTURE_STYLE.SINGLE, 1, 1))
		return self
	}
	
	// Creates a struct of the data needed to place a texture onto the block.
	static __initUvBlockTextureItem = function(_blockType = BLOCK_TEXTURE_STYLE.SINGLE, _uOffset = 0, _vOffset = 0) {
		return {
			blockType : _blockType,
			uOffset   : _uOffset * uvMagicNumber,
			vOffset   : _vOffset * uvMagicNumber
		}
	}
}
