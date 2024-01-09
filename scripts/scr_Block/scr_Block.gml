// Block object for drawing
function Block(_xPos, _yPos, _zPos) : Shape() constructor {
	
	xPos = _xPos
	yPos = _yPos
	zPos = _zPos
	
	draw = function() {
		var block = instance_create_depth(xPos, yPos, zPos, obj_gameObject)
		block.model = new LoadObject().loadObjFile("cube32.obj")
	}
}