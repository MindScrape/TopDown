// A 1D array implementation
function Array1(_size, _callback_function = noone) constructor {
	size = _size
	array = (_callback_function == noone ? array_create(_size) : array_create_ext(_size, _callback_function))
	
	get = function(_index) {
		return array[_index]
	}
	
	set = function(_index, _value) {
		array[_index] = _value
	}
	
	toString = function() {
		return string(array)
	}
}