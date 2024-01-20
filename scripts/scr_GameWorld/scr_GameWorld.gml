// Some commonly shared variables amongst GameWorld constructors
function GameWorld() constructor {

	static chunkXlen = 16
	static chunkYlen = 16
	static chunkZlen = 256
	
	static mapLen = 32
	static mapCacheSize = 5
	
	static defaultValueForUnknownLookups = pointer_null
}