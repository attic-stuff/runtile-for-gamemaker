var tx = mouse_x div 16;
var ty = mouse_y div 16;


for (var i = 1; i < 4; i++) {
	if (keyboard_check_pressed(ord(string(i)))) {
		mode = i - 1;
		break;
	}
}

if (mouse_check_button(mb_left)) {
	if (mode == 0) {
		runtile_update_corner(corner, tx, ty, false, mutate, 2);
	}
	if (mode == 1) {
		runtile_update_edge(edge, tx, ty)	
	}
	if (mode == 2) {
		runtile_update_blob(blob, tx, ty);
	}
}

if (mouse_check_button(mb_right)) {
	if (mode == 0) {
		runtile_update_corner(corner, tx, ty, true, mutate, 2);
	}
	if (mode == 1) {
		runtile_update_edge(edge, tx, ty, true)	
	}
	if (mode == 2) {
		runtile_update_blob(blob, tx, ty, true);
	}	
}