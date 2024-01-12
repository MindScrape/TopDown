// A 3D array implementation
function Array3(_rows, _columns, _breadth, _callback_function = noone) : Array1(_rows * _columns * _breadth, _callback_function) constructor {
	rows = _rows
	columns = _columns
	breadth = _breadth
	
	// @override
	static get = function(_row, _column, _breadth) {
		return array[((_row * columns) * breadth) + (_column * breadth) + _breadth]
	}
	
	// @override
	static set = function(_row, _column, _breadth, _value) {
		array[((_row * columns) * breadth) + (_column * breadth) + _breadth] = _value
	}
	
	// @override
	static toString = function() {
		var stringToReturn = ""
		for (var j = 0; j < columns; j++) {
			var stringLayer = ""
			for (var i = 0; i < rows; i++) {
				var stringRow = ""
				for (var k = 0; k < breadth; k++) {
					stringRow += string(get(i, j, k)) + " "
				}
				stringLayer += stringRow + "\n"
			}
			stringToReturn += stringLayer + "\n"
		}
		return stringToReturn
	}
}