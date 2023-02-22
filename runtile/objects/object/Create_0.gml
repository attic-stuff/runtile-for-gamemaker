window_set_size(1024, 1024);
surface_resize(application_surface, 256, 256);
display_set_gui_size(256, 256);
alarm[0] = 1;

blob = layer_tilemap_get_id("blob");
wang = layer_tilemap_get_id("wang");
marchingsquare = layer_tilemap_get_id("marchingsquare");

mwidth = tilemap_get_width(marchingsquare) - 1;
mheight = tilemap_get_height(marchingsquare) - 1;
mode = 0;

randomise();
draw_set_font(font);