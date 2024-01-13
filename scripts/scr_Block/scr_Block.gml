function InitializeBlockModelsActivity() constructor {
	// Will be initialized as a 1D array storing all the block models
	static blockModels = noone
	static blockLength = 32
	
	static initBlockModels = function() {
		if blockModels != noone {
			show_message("blockModels has already been initialized. Doing this more than once is a fatal bug and will cause slow downs. Skipping...")
			return
		}
		var uvBlockTextures = new InitializeBlockTextureActivity()
		uvBlockTextures.initUvBlockTextures()
		blockModels = new Array1(uvBlockTextures.numBlockTypes)
		for (var blockId = 0; blockId < uvBlockTextures.numBlockTypes; blockId++) {
			var uvBlockTextureItem = uvBlockTextures.get(blockId)
			if typeof(uvBlockTextureItem) == "struct" {
				blockModels.set(blockId, new LoadObject().loadBlock(uvBlockTextureItem))
			} 
		}
	}
	
	static drawBlock = function(_xPos, _yPos, _zPos, _blockId = 1) {
		var block = instance_create_depth(_xPos * blockLength, _yPos * blockLength, 0, obj_gameObject)
		block.z = _zPos * blockLength
		block.model = blockModels.get(_blockId)
	}
}

// I think the only approach to get this to work properly is to initialize this
// constructor as a global variable.... ugly... I know.... 
function InitializeBlockTextureActivity() constructor {
	
	static uvBlockTextures = pointer_null
	static uvMagicNumber = 0.0625
	static numBlockTypes = 10
	
	static get = function(_blockId) {
		return uvBlockTextures.get(_blockId, 1)
	}
	
	static initUvBlockTextures = function() { 
		if uvBlockTextures != pointer_null {
			show_message("uvBlockTextures has already been initialized. Doing this more than once is a fatal bug and will cause slowdowns. Skipping...")
			return
		}
		// I probably should move these hardcoded values to some data file later on...
		uvBlockTextures = new Array2(numBlockTypes, 2)
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
