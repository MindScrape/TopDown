// Vector3 stores a 3D vector
function Vector3(_posX, _posY, _posZ) : Vector2(_posX, _posY) constructor {
	posZ = _posZ
	
	// @override
	add = function(_vec3) {
		if instanceof(_vec3) != "Vector3" {
			show_error("Error: _vec3 is not a Vector3 in the 'add' function. Aborting.", true)
		}
		return new Vector3(posX + _vec3.posX, posY + _vec3.posY, posZ + _vec3.posZ)
	}
	
	// @override
	toString = function() {
		return string("Vector3 has the coordinates ({0}, {1}, {3})", posX, posY, posZ)
	}
}