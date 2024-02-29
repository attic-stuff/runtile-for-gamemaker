for (var i = 0; i < 6; i++) {
	if (keyboard_check_pressed(ord(string(i + 1)))) {
		mode = i;
		var list = [ corner, edge, blob, mutate, takefive ];
		var index = array_get_index(stack, list[i]);
		array_delete(stack, index, 1);
		array_insert(stack, 0, list[i]);
		break;
	}
}

if (keyboard_check_pressed(vk_backspace) == true) {
	for (var i = 0; i < 5; i++) {
		tilemap_clear(stack[i], 0);	
	}
}

if (mouse_check_button(mb_left)) {
	var tx = mouse_x div 16;
	var ty = mouse_y div 16;
	if (mode == 0) {
		runtile_update_corner(corner, tx, ty, false);
	} else if (mode == 1) {
		runtile_update_edge(edge, tx, ty)	
	} else if (mode == 2) {
		runtile_update_blob(blob, tx, ty);
	} else if (mode == 3) {
		runtile_update_corner(mutate, tx, ty, false, true, 4);
	} else {
		runtile_takefive_autotile(takefive, tx, ty, tfoffset, 3, false, false);
	}
}

if (mouse_check_button(mb_right)) {
	var tx = mouse_x div 16;
	var ty = mouse_y div 16;
	if (mode == 0) {
		runtile_update_corner(corner, tx, ty, true);
	} else if (mode == 1) {
		runtile_update_edge(edge, tx, ty, true)	
	} else if (mode == 2) {
		runtile_update_blob(blob, tx, ty, true);
	} else if (mode == 3) {
		runtile_update_corner(mutate, tx, ty, true, true, 4);
	} else {
		runtile_takefive_autotile(takefive, tx, ty, tfoffset, 3, true, false);
	}
}