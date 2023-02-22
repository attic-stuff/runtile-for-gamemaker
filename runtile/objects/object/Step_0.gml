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
		runtile_marchingsquare_update(marchingsquare, tx, ty, mwidth, mheight);
	}
	if (mode == 1) {
		runtile_wang_update(wang, tx, ty)	
	}
	if (mode == 2) {
		runtile_blob_update(blob, tx, ty);
	}
}

if (mouse_check_button(mb_right)) {
	if (mode == 0) {
		runtile_marchingsquare_update(marchingsquare, tx, ty, mwidth, mheight, true);
	}
	if (mode == 1) {
		runtile_wang_update(wang, tx, ty, true)	
	}
	if (mode == 2) {
		runtile_blob_update(blob, tx, ty, true);
	}	
}