// The player can place a block at a specified location
// @param _mmm (MapMemManager). When some entity places a block, we must know
//		  where to write the block, and we need to read the blocks around it
// @param _blockDrawer will redraw and draw a block into the gameworld,
//        which is managed by the MMM
function PlaceBlock(_mmm, _blockDrawer) : Action(_mmm, _blockDrawer) constructor {
	
	/*
	#   Faces, in order, are: [TOP, BOTTOM, A, B, C, D]
	# 
	#                         +-------+ 
	#                        /.  TOP /|  B
	#                       / .     / |
	#                  C   +-------+ A|
	#     +z               |  . . .|. +
	#     | /-y            | . D   | /
	#     |/               |.      |/
	#     +---- +x         +-------+
	#                          BOTTOM
	*/
	// The block will draw itself into the world with the appropriate faces,
	// while at the same time redrawing its neighbors at the same time.
	static placeBlock = function(_x, _y, _z, _blockId) {
		
		if (_blockId == 0) return; // Player cannot place air for now
		
		var top	   = mmm.readBlock(_x, _y, _z + 1)
		var bottom = mmm.readBlock(_x, _y, _z - 1)
		var a      = mmm.readBlock(_x + 1, _y, _z)
		var b	   = mmm.readBlock(_x, _y - 1, _z)
		var c	   = mmm.readBlock(_x - 1, _y, _z)
		var d      = mmm.readBlock(_x, _y + 1, _z)
		
		var faces = 0b111111
		if (top != 0 and top.blockId != 0)		 {  faces = faces & 0b011111; blockDrawer.redrawBlock(top,    top.faces    ^ 0b010000) } // TOP
		if (bottom != 0 and bottom.blockId != 0) {  faces = faces & 0b101111; blockDrawer.redrawBlock(bottom, bottom.faces ^ 0b100000) } // BOTTOM
		if (a != 0 and a.blockId != 0)			 {  faces = faces & 0b110111; blockDrawer.redrawBlock(a,      a.faces      ^ 0b000010) } // A
		if (b != 0 and b.blockId != 0)			 {  faces = faces & 0b111011; blockDrawer.redrawBlock(b,      b.faces      ^ 0b000001) } // B
		if (c != 0 and c.blockId != 0)			 {  faces = faces & 0b111101; blockDrawer.redrawBlock(c,      c.faces      ^ 0b001000) } // C
		if (d != 0 and d.blockId != 0)			 {  faces = faces & 0b111110; blockDrawer.redrawBlock(d,      d.faces      ^ 0b000100) } // D
		var block = blockDrawer.drawBlock(_x, _y, _z, _blockId, faces)
		mmm.writeBlock(_x, _y, _z, block)
		
		// TODO: I need to not load in blocks that are on the edges of unloaded chunks. These are just wasted resources the player should never see....
		/*
		if (top != 0 and (top == -1 or top.blockId != 0))		   {  faces = faces & 0b011111; if (top != -1)    blockDrawer.redrawBlock(top,    top.faces    ^ 0b010000) } // TOP
		if (bottom != 0 and (bottom == -1 or bottom.blockId != 0)) {  faces = faces & 0b101111; if (bottom != -1) blockDrawer.redrawBlock(bottom, bottom.faces ^ 0b100000) } // BOTTOM
		if (a != 0 and (a == -1 or a.blockId != 0))			       {  faces = faces & 0b110111; if (a != -1)      blockDrawer.redrawBlock(a,      a.faces      ^ 0b000010) } // A
		if (b != 0 and (b == -1 or b.blockId != 0))		           {  faces = faces & 0b111011; if (b != -1)      blockDrawer.redrawBlock(b,      b.faces      ^ 0b000001) } // B
		if (c != 0 and (c == -1 or c.blockId != 0))			       {  faces = faces & 0b111101; if (c != -1)      blockDrawer.redrawBlock(c,      c.faces      ^ 0b001000) } // C
		if (d != 0 and (d == -1 or d.blockId != 0))		           {  faces = faces & 0b111110; if (d != -1)      blockDrawer.redrawBlock(d,      d.faces      ^ 0b000100) } // D
		*/
	}
}