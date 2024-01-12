// THIS IS TEMPORARY. DO NOT ACTUALLY USE THIS IN PRODUCTION
function ChunkArray(_rows, _columns, _breadth, _callback_function = noone) : Array3(_rows, _columns, _breadth, _callback_function) constructor {
	// @override
	static get = function(_row, _column, _breadth) {
		if (_row <= 0 or _row >= rows) return 0
		if (_column <= 0 or _column >= columns) return 0
		if (_breadth <= 0 or _breadth >= breadth) return 0
		return array[((_row * columns) * breadth) + (_column * breadth) + _breadth]
	}
	
}