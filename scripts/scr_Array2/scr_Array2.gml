// A 2D array implementation
function Array2(_rows, _columns, _callback_function = noone) : Array1(_rows * _columns, _callback_function) constructor {
	rows = _rows
	columns = _columns
	
	// @override
	get = function(_row, _column) {
		return array[_column * columns + _row]
	}
	
	// @override
	set = function(_row, _column, _value) {
		array[_column * columns + _row] = _value
	}
	
	// @override
	toString = function() {
		var stringToReturn = ""
		for (var i = 0; i < rows; i++) {
			var stringRow = ""
			for (var j = 0; j < columns; j++) {
				stringRow += string(get(i, j)) + " "
			}
			stringToReturn += stringRow + "\n"
		}
		return stringToReturn
	}
}