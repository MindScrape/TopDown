/// @description This is not ideal. Just do it for testing.

function __get_nearest_object(object) {
	var closest_npc = noone
	var closest_npc_distance = -1
	for (var i = 0; i < instance_number(object); i++) {
		var npc = instance_find(object, i)
		var distance = point_distance(self.x,self.y,npc.x,npc.y)
	
		if closest_npc_distance == -1 {
			closest_npc = npc
			closest_npc_distance = distance
			continue
		}
	
		if distance < closest_npc_distance {
			closest_npc = npc 
			closest_npc_distance = distance
			continue
		}
	}
	
	if closest_npc == noone {
		return noone
	} else {
		var closest_npc_array = array_create(2)
		closest_npc_array[0] = closest_npc
		closest_npc_array[1] = closest_npc_distance
		return closest_npc_array
	}
}

var nearest_player = __get_nearest_object(obj_player)
var nearest_player_distance = nearest_player[1]

if created_dialog = false and nearest_player_distance <= 50 {
	instance_create_layer(x,y,"Instances",obj_dialog)
	created_dialog = true
}
