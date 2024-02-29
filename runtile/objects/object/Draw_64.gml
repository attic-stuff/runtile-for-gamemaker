if (surface_exists(ui) == false) {
	ui = surface_create(256, 256);
}

surface_set_target(ui) {
	draw_clear_alpha(c_black, 0);
	draw_set_color(#dbd2b8);
	draw_text_ext(2, -3, "press the [number] to change tile mode. left click to place, right click to yeet.\n[backspace] to clear.\n[1]corner\n[2]edge\n[3]blob\n[4]mutating corner\n[5]take five", 9, 128);
	draw_set_color(#ffffff);
	surface_reset_target();
}

shader_set(outline) {
	draw_surface(ui, 0, 0);
	shader_reset();
}