// Removes a game block from the world and memory
// @param _mmm (MapMemManager). When some entity places a block, we must know
//		  where to write the block, and we need to read the blocks around it
// @param _blockDrawer will redraw and draw a block into the gameworld,
//        which is managed by the MMM
function RemoveBlock(_mmm, _blockDrawer) : Action(_mmm, _blockDrawer) constructor {
	
	// The block will remove itself from the gameworld,
	// while at the same time redrawing its neighbors.
	static removeBlock = function(_x, _y, _z) {
		
		var block = mmm.readBlock(_x, _y, _z)
		
		if (block == BLOCK.AIR) return; // Player cannot remove air 
		
		var top	   = mmm.readBlock(_x, _y, _z + 1)
		var bottom = mmm.readBlock(_x, _y, _z - 1)
		var a      = mmm.readBlock(_x + 1, _y, _z)
		var b	   = mmm.readBlock(_x, _y - 1, _z)
		var c	   = mmm.readBlock(_x - 1, _y, _z)
		var d      = mmm.readBlock(_x, _y + 1, _z)
		
		blockDrawer.eraseBlock(block)
		mmm.writeBlock(_x, _y, _z, BLOCK.AIR)
		if (top != 0 and top.blockId != BLOCK.AIR)       { blockDrawer.redrawBlock(top,    top.faces    & 0b010000) } // TOP
		if (bottom != 0 and bottom.blockId != BLOCK.AIR) { blockDrawer.redrawBlock(bottom, bottom.faces & 0b100000) } // BOTTOM
		if (a != 0 and a.blockId != BLOCK.AIR)			 { blockDrawer.redrawBlock(a,      a.faces      & 0b000010) } // A
		if (b != 0 and b.blockId != BLOCK.AIR)			 { blockDrawer.redrawBlock(b,      b.faces      & 0b000001) } // B
		if (c != 0 and c.blockId != BLOCK.AIR)			 { blockDrawer.redrawBlock(c,      c.faces      & 0b001000) } // C
		if (d != 0 and d.blockId != BLOCK.AIR)			 { blockDrawer.redrawBlock(d,      d.faces      & 0b000100) } // D
	}
}