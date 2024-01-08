// Vector2 stores a 2D vector
function Vector2(_posX, _posY) constructor {
	posX = _posX
	posY = _posY
	
	add = function(_vec2) {
		if instanceof(_vec2) != "Vector2" {
			show_error("Error: _vec2 is not a Vector2 in the 'add' function. Aborting.", true)
		}
		return new Vector2(posX + _vec2.posX, posY + _vec2.posY)
	}
	
	toString = function() {
		return string("Vector2 has the coordinates ({0}, {1})", posX, posY)
	}
}