// Originally implemented this cache for the MMM
function Cache(_size) constructor {
	
	size = _size
	cache = ds_list_create()

	static get = function(_key) {
		for (var i = 0; i < size; i++) {
			var item = ds_list_find_value(self.cache, i)
			if item != undefined and item.key == _key {
				if i != 0 {
					__reset(item, i)
				}
				return item.value
			} 
		}
		return pointer_null
	}
	
	static set = function(_key, _value) {
		ds_list_insert(cache, 0, {
			key : _key,
			value : _value
		}) 
		ds_list_delete(cache, size)
	}
	
	static __reset = function(__kvStruct, __indexToDelete) {
		ds_list_delete(cache, __indexToDelete)
		ds_list_insert(cache, 0, __kvStruct)
	}
	
	static toString = function() {
		items = "["
		for (var i = 0; i < size; i++) {
			items += string(ds_list_find_value(cache, i)) + ", "
		}
		return items + "]"
	}
}