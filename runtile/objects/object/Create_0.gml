window_set_size(1024, 1024);
surface_resize(application_surface, 256, 256);
display_set_gui_size(256, 256);
alarm[0] = 1;


blob = layer_tilemap_get_id("blob");
edge = layer_tilemap_get_id("edge");
corner = layer_tilemap_get_id("corner");
grid = layer_tilemap_get_id("grid");
mutate = layer_tilemap_get_id("mutate");
takefive = layer_tilemap_get_id("takefive");

tfoffset = runtile_takefive_setup_tilemap_mask(takefive)

stack = [ corner, edge, blob, mutate, takefive ];

mode = 0;

randomise();
draw_set_font(font);

ui = -1;