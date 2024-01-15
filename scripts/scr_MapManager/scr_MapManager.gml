// Map Manager controls access to many different maps in game
function MapManager() constructor {
	
	static maps = pointer_null
	
	// Creates a brand new allocated piece of memory for the player at 0,0
	static initGameWorld = function() {
		if (maps != pointer_null) {
			show_message("FATAL ERROR: MapManager initialized a new world while there is world data loaded. Aborting.")
			saveGame()
			game_end()
		}
		maps = ds_map_create()
		map = new Map(0, 0)
		ds_map_add(maps, getKey(0, 0).key, map)
		return map
	}
	
	static getKey = function(xPos, yPos) {
		var _iPos = xPos / (mapLen * chunkXlen)
		var _jPos = yPos / (mapLen * chunkYlen)
		var _key = (int64(iPos) << 32) & int64(jPos)
		return {
			key : _key,
			iPos : _iPos,
			jPos : _jPos
		}
	}

	static getMap = function(xPos, yPos) {
		return ds_map_find_value(maps, getKey(xPos, yPos).key)
	}
	
	static addMap = function(xPos, yPos) {
		var keyStruct = getKey(xPos, yPos)
		var map = new Map(keyStruct.iPos, keyStruct.jPos)
		ds_map_add(maps, keyStruct.key, map)
		return map
	}
	
	static writeBlock = function(xPos, yPos, zPos, blockId) {
		var map = getMap(xPos, yPos)
		if map == undefined {
			map = addMap(xPos, yPos)
		}
		map.writeBlock(xPos, yPos, zPos, blockId)
	}
	
	static readBlock = function(xPos, yPos, zPos) {
		var map = getMap(xPos, yPos)
		if map == undefined {
			map = addMap(xPos, yPos)
		}
		return map.readBlock(xPos, yPos, zPos)
	}
	
	
	static saveGame = function() {
		game_end()
	}
}