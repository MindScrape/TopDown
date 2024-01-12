// Block object for drawing
function Block(_xPos, _yPos, _zPos, _blockId = 1) constructor {
	
	static blockEdgeLength = 32
	
	// Try to keep these at a minimum... let's not eat up too much RAM.
	xPos = _xPos * blockEdgeLength
	yPos = _yPos * blockEdgeLength
	zPos = _zPos * blockEdgeLength
	blockId = _blockId
	
	// DO NOT PUT IN DRAW EVENT
	// This will PLACE it in the game world. That's all it takes
	static render = function() {
		var block = instance_create_depth(xPos, yPos, 0, obj_gameObject)
		block.z = zPos
		block.model = new LoadObject().loadBlock(global.UV_BLOCK_TEXTURES.get(blockId))
	}
}

// I think the only approach to get this to work properly is to initialize this
// function as a global variable.... ugly... I know.... 
function InitializeBlockTextureActivity() constructor {
	
	static uvBlockTextures = pointer_null
	static uvMagicNumber = 0.0625
	
	static get = function(_blockId) {
		return uvBlockTextures.get(_blockId, 1)
	}
	
	static initUvBlockTextures = function() { 
		if uvBlockTextures != pointer_null {
			show_message("uvBlockTextures has already been initialized. Doing this more than once is a fatal bug and will cause slowdowns.")
		}
		uvBlockTextures = new Array2(10, 2)
		uvBlockTextures.set(1, 1, __initUvBlockTextureItem(1, 0, 0))		// grass
		uvBlockTextures.set(2, 1, __initUvBlockTextureItem(2, 0, 0))		// dirt
		uvBlockTextures.set(3, 1, __initUvBlockTextureItem(2, 0, 1))		// stone
		uvBlockTextures.set(4, 1, __initUvBlockTextureItem(2, 1, 1))		// bedrock
	}
	
	// Returns an item that will populate 
	static __initUvBlockTextureItem = function(_blockType = 1, _uOffset = 0, _vOffset = 0) {
		var blockTypeName;
		switch (_blockType) {
			case 1:
				blockTypeName = "normalBlock1"
				break
			case 2:
				blockTypeName = "normalBlock2"
				break
			default:
				blockTypeName = "normalBlock1"
				break
		}
		
		return {
			blockType : blockTypeName,
			uOffset   : _uOffset * uvMagicNumber,
			vOffset   : _vOffset * uvMagicNumber
		}
	}
}
