// Some commonly shared variables amongst GameWorld constructors
function GameWorld() constructor {

	static chunkXlen = 16
	static chunkYlen = 16
	static chunkZlen = 256

	static mapLen = 32
	static mapCacheSize = 5
	
	// For blocks that are untouchable but seeable, we want it to be air
	static airValueForUntouchableLookups = BLOCK.AIR
	
	// For chunks that we have loaded but have never written to
	static nullValueForUnknownLookups = 0
}