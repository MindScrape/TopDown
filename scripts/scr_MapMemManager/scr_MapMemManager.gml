// Map Manager controls access to many different maps in game
// These calls are expensive, so minimize them as much as possible.
function MapMemManager() : GameWorld() constructor {
	
	maps = pointer_null
	cache = new Cache(mapCacheSize)

	// Creates a brand new allocated piece of memory for the player at 0,0
	static initMapManager = function() {
		if (maps != pointer_null) {
			show_message("FATAL ERROR: MapManager initialized a new world while there is world data loaded. Aborting.")
			saveGame()
			game_end()
		}
		maps = ds_map_create()
		var map = new Map(0, 0)
		var key = getKey(0, 0).key
		cache.set(key, map)
		var success = ds_map_add(maps, key, map)
		if !success {
			show_message("FATAL ERROR: Duplicate map key " + string(key))
			game_end()
		}
		return self
	}
	
	static getKey = function(xPos, yPos) {
		var _iPos = floor(xPos / (mapLen * chunkXlen))
		var _jPos = floor(yPos / (mapLen * chunkYlen))
		var _key = (int64(_iPos) << 32) | (_jPos & 0xFFFFFFFF)
		return {
			key : _key,
			iPos : _iPos,
			jPos : _jPos
		}
	}

	static getMap = function(xPos, yPos) {
		var key = getKey(xPos, yPos).key
		var cacheResult = cache.get(key)
		if (cacheResult != pointer_null) {
			return cacheResult
		} else {
			var map = ds_map_find_value(maps, key)
			cache.set(key, map)
			return map
		}
	}
	
	static addMap = function(xPos, yPos) {
		var keyStruct = getKey(xPos, yPos)
		var map = new Map(keyStruct.iPos, keyStruct.jPos)
		var success = ds_map_add(maps, keyStruct.key, map)
		if !success {
			show_message("FATAL ERROR: Duplicate map key " + string(keyStruct.key))
			game_end()
		}
		cache.set(keyStruct.key, map)
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
	
	static getChunk = function(xPos, yPos) {
		var map = getMap(xPos, yPos)
		return map.getChunk(xPos, yPos)
	}

	static saveGame = function() {
		// Intentionally left empty for now
	}
	
	static loadGame = function() {
		// Intentionally left empty for now	
	}
}