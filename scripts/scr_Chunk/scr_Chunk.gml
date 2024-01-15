// A constructor that holds 3D info on a world chunk
function Chunk() : GameWorld() constructor {
	
	blocks = new Array3(chunkXlen, chunkYlen, chunkZlen)
	
	static set = function(xPos, yPos, zPos, blockId) {
		blocks.set(xPos, yPos, zPos, blockId)
	}
	
	static get = function(xPos, yPos, zPos) {
		blocks.get(xPos, yPos, zPos)
	}
}