/**
 * calculates what tile should be used when autoling a 16-tile, marching square tile set.
 * @param {id.TileMapElement} map the tilemap source
 * @param {real} x the x coordinate of the cell to evaluate
 * @param {real} y the y coordinate of the cell to evaluate
 * @param {real} width the width of the tilemap source
 * @param {real} height the height of the tilemap source
 * @returns {real}
 */
function runtile_fetch_marchingsquare(map, x, y, width, height) {
	static table = [ 0b0000, 0b1111, 0b1101, 0b1110,
					 0b1100, 0b1011, 0b1001, 0b1010,
					 0b1000, 0b0111, 0b0101, 0b0110,
					 0b0100, 0b0011, 0b0001, 0b0010
					];
	static corners = [ 0b0000, 0b1111, 0b1011, 0b0111,
				       0b0011, 0b1101, 0b1001, 0b0101,
					   0b0001, 0b1110, 0b1010, 0b0110,
					   0b0010, 0b1100, 0b1000, 0b0100
					 ];	 
	var e = clamp(x + 1, 0, width);
	var n = clamp(y - 1, 0, height);
	var w = clamp(x - 1, 0, width);
	var s = clamp(y + 1, 0, height);
	return array_get_index(table, (((corners[tilemap_get(map, e, n) % 16] & 0b0010) != 0b0) << 0) +
								  (((corners[tilemap_get(map, w, n) % 16] & 0b0001) != 0b0) << 1) + 
								  (((corners[tilemap_get(map, w, s) % 16] & 0b1000) != 0b0) << 2) +
								  (((corners[tilemap_get(map, e, s) % 16] & 0b0100) != 0b0) << 3));
}

/**
 * autotiles a 3x3 square of tiles using the marching square method
 * @param {id.TileMapElement} map the tilemap source
 * @param {real} x center x cell coordinate of the 3x3 square
 * @param {real} y center y cell coordinate of the 3x3 square
 * @param {real} width the width of the tilemap source
 * @param {real} height the height of the tilemap source
 * @param {bool} [mutate] whether or not to randomise the result
 * @param {real} [varieties] the number of varieties of tiles
 */
function runtile_autotile_marchingsquare(map, x, y, width, height, mutate = false, varieties = 2) {
	static neighborhood = [ [0,0], [1,0], [1,-1], [0,-1], [-1,-1], [-1,0], [-1,1], [0,1], [1,1] ];
	for (var i = 1; i < 9; i++) {
		var tx = x + neighborhood[i][0];
		var ty = y + neighborhood[i][1];
		tilemap_set(map, runtile_fetch_marchingsquare(map, tx, ty, width, height) + (mutate * (irandom(varieties - 1) * 16)), tx, ty);
	}
}

/**
 * wrapper for marching square autotiling
 * @param {id.TileMapElement} map the tilemap source
 * @param {real} x the x coordinate of the cell to evaluate
 * @param {real} y the y coordinate of the cell to evaluate
 * @param {real} width the width of the tilemap source
 * @param {real} height the height of the tilemap source
 * @param {bool} [clear] whether or not to clear the cell or set the cell
 * @param {bool} [mutate] whether or not to randomise the result
 * @param {real} [varieties] the number of varieties of tiles
 */
function runtile_marchingsquare_update(map, x, y, width, height, clear = false, mutate = false, varieties = 2) {
	static neighborhood = [ [0,0], [1,0], [1,-1], [0,-1], [-1,-1], [-1,0], [-1,1], [0,1], [1,1] ];
	if (clear = false) {
		for (var i = 0; i < 9; i++) {
			tilemap_set(map, 1 + (mutate * (irandom(varieties - 1) * 16)), x + neighborhood[i][0], y + neighborhood[i][1]);
		}
	} else {
		for (var i = 0; i < 9; i++) {
			tilemap_set(map, 0, x + neighborhood[i][0], y + neighborhood[i][1]);
		}
	}
	runtile_autotile_marchingsquare(map, x, y, width, height, mutate, varieties);
}

/**
 * calculates what tile should be used when autotiling a 16-tile, wang tileset.
 * if you would like the tilemap to be unbound by the tilemap size, change each > comparison to !=
 * @param {id.TileMapElement} map the tilemap source
 * @param {real} x the x coordinate of the cell to evaluate
 * @param {real} y the y coordinate of the cell to evaluate
 * @returns {real}
 */ 
function runtile_fetch_wang(map, x, y) {
	//decimal
	//static table = [ -1, 0, 15, 1, 2, 4, 8, 5, 10, 11, 13, 14, 7, 9, 3, 6, 12];
	//binary
	static table = [ -1, 
		0b0000, 0b1111, 0b0001, 0b0010,
		0b0100, 0b1000, 0b0101, 0b1010,
		0b1011, 0b1101, 0b1110, 0b0111,
		0b1001, 0b0011, 0b0110, 0b1100
	];
	
	var e = tilemap_get(map, x + 1, y) > 0;
	var n = tilemap_get(map, x, y - 1) > 0;
	var w = tilemap_get(map, x - 1, y) > 0;
	var s = tilemap_get(map, x, y + 1) > 0;
	return array_get_index(table, (e << 0) + (n << 1) + (w << 2) + (s << 3));
}

/**
 * autotiles a 3x3 square of tiles using the wang method
 * @param {id.TileMapElement} map the tilemap source
 * @param {real} x center x cell coordinate of the 3x3 square
 * @param {real} y center y cell coordinate of the 3x3 square
 * @param {bool} [mutate] whether or not to randomise the result
 * @param {real} [varieties] the number of varieties of tiles
 */
function runtile_autotile_wang(map, x, y, mutate = false, varieties = 2) {
	static neighborhood = [ [0,0], [1,0], [1,-1], [0,-1], [-1,-1], [-1,0], [-1,1], [0,1], [1,1] ];
	for (var i = 0; i < 9; i++) {
		var tx = x + neighborhood[i][0];
		var ty = y + neighborhood[i][1];
		if (tilemap_get(map, tx, ty) > 0) {
			tilemap_set(map, runtile_fetch_wang(map, tx, ty) + (mutate * (irandom(varieties - 1) * 16)), tx, ty);
		}
	}
}

/**
 * wrapper for wang autotiling
 * @param {id.TileMapElement} map the tilemap source
 * @param {real} x the x coordinate of the cell to evaluate
 * @param {real} y the y coordinate of the cell to evaluate
 * @param {bool} [clear] whether or not to clear the cell or set the cell
 * @param {bool} [mutate] whether or not to randomise the result
 * @param {real} [varieties] the number of varieties of tiles
 */
function runtile_wang_update(map, x, y, clear = false, mutate = false, varieties = 2) {
	static offset = 16;
	var set = clear ? 0 : 1 + (mutate * (irandom(varieties - 1) * offset));
	tilemap_set(map, set, x, y);
	runtile_autotile_wang(map, x, y, mutate, varieties);
};

/**
 * calculates which tile index should be used to blob autotile a given cell based on the status of its neighbors.
 * if you would like the tilemap to be unbound by the tilemap size, change each > comparison to !=
 * @param {id.TileMapElement} map tilemap
 * @param {real} x the x coordinate of the cell to evaluate
 * @param {real} y the y coordinate of the cell to evaluate
 */
function runtile_fetch_blob_tile(map, x, y) {
	static table = [ -1,
		0b11110111, 0b11111101, 0b11110101, 0b01111111,
		0b01110111, 0b01111101, 0b01110101, 0b11011111,
		0b11010111, 0b11011101, 0b11010101, 0b01011111,
		0b01010111, 0b01011101, 0b01010101, 0b11000111,
		0b11000101, 0b01000111, 0b01000101, 0b11110001,
		0b01110001, 0b11010001, 0b01010001, 0b01111100,
		0b01011100, 0b01110100, 0b01010100, 0b00011111,
		0b00010111, 0b00011101, 0b00010101, 0b01000100,
		0b00010001, 0b11000001, 0b01000001, 0b01110000,
		0b01010000, 0b00011100, 0b00010100, 0b00000111,
		0b00000101, 0b01000000, 0b00000001, 0b00000100,
		0b00010000, 0b00000000, 0b11111111
	];
	var e = tilemap_get(map, x + 1, y) > 0;
	var ne = tilemap_get(map, x + 1, y - 1) > 0;
	var n = tilemap_get(map, x, y - 1) > 0;
	var nw = tilemap_get(map, x - 1, y - 1) > 0;
	var w = tilemap_get(map, x - 1, y) > 0;
	var sw = tilemap_get(map, x - 1, y + 1) > 0;
	var s = tilemap_get(map, x, y + 1) > 0;
	var se = tilemap_get(map, x + 1, y + 1) > 0;
	return array_get_index(table, (e * 1) + ((ne & e & n) * 2) + (n * 4) + ((nw & w & n) * 8) + (w * 16) + ((sw & s & w) * 32) + (s * 64) + ((se & e & s) * 128));
}

/**
 * autotiles a 3x3 square using the 47 tile, wang blob tile layout
 * @param {id.TileMapElement} map the tilemap to update
 * @param {real} x center x cell coordinate of the 3x3 square
 * @param {real} y center y cell coordinate of the 3x3 square
 * @param {bool} [mutate] whether or not to randomise the result
 * @param {real} [varieties] the number of varieties of tiles
 */
function runtile_autotile_blob_tile(map, x, y, mutate = false, varieties = 2) {
	static neighborhood = [ [0,0], [1,0], [1,-1], [0,-1], [-1,-1], [-1,0], [-1,1], [0,1], [1,1] ];
	for (var i = 0; i < 9; ++i) {
		var tx = x + neighborhood[i][0];
		var ty = y + neighborhood[i][1];
		if (tilemap_get(map, tx, ty) > 0) {
			tilemap_set(map, runtile_fetch_blob_tile(map, tx, ty) + (mutate * (irandom(varieties - 1) * 48)), tx, ty);
		}
	}
}

/**
 * autotiling wrapper for 47-tile, blob autotiling
 * @param {id.TileMapElement} map the tilemap source
 * @param {real} x the x coordinate of the cell to evaluate
 * @param {real} y the y coordinate of the cell to evaluate
 * @param {bool} [clear] whether or not to clear the cell or set the cell
 * @param {bool} [mutate] whether or not to randomise the result
 * @param {real} [varieties] the number of varieties of tiles
 */
function runtile_blob_update(map, x, y, clear = false, mutate = false, varieties = 2) {
	if (clear) {
		tilemap_set(map, 0b00000000, x, y);
	} else {
		tilemap_set(map, 0b00101110 + (mutate * (irandom(varieties - 1) * 48)), x, y);
	}
	runtile_autotile_blob_tile(map, x, y, mutate, varieties);
}

/**
 * copies a region of a tilemap to a 2d array
 * @param {id.TileMapElement} map the tilemap source
 * @param {real} x x position of the corner to begin the copy
 * @param {real} y y position of the corner to begin the copy
 * @param {real} width width of the copied region
 * @param {real} height height of the copied region
 */
 function runtile_capture_region(map, x, y, width, height) {
	var array = array_create(width);
	for (var i = 0; i < width; i++) {
		array[i] = array_create(height);
		for (var j = 0; j < height; j++) {
			array[i][j] = tilemap_get(map, x + i, y + j);
		}
	}
	return array;
 }
	 
/**
 * mirrors a rectangular region of a tilemap along the x axis. for edge/blob tiles only.
 * @param {id.TileMapElement} map the tilemap source
 * @param {real} x x position of the corner to begin the mirror
 * @param {real} y y position of the corner to begin the mirror
 * @param {real} width width of the region
 * @param {real} height height of the region
 */
function runtile_mirror_region(map, x, y, width, height) {
	var region = runtile_capture_region(map, x, y, width, height);
	array_reverse_ext(region)
	for (var i = 0; i < width; ++i) {
		for (var j = 0; j < height; ++j) {
			tilemap_set(map, region[i][j], x + i, y + j);
		}
	}
}

/**
 * flips a rectangular region of a tilemap along the y axis. for edge/blob tiles only.
 * @param {id.TileMapElement} map the tilemap source
 * @param {real} x x position of the corner to begin the flip
 * @param {real} y y position of the corner to begin the flip
 * @param {real} width width of the region
 * @param {real} height height of the region
 */
function runtile_flip_region(map, x, y, width, height) {
	var region = runtile_capture_region(map, x, y, width, height);
	for (var i = 0; i < width; ++i) {
		array_reverse_ext(region[i]);
		for (var j = 0; j < height; ++j) {
			tilemap_set(map, region[i][j], x + i, y + j);
		}
	}
}

/**
 * rotates a rectangular region of a tilemap counter-clockwise. for edge/blob tiles only.
 * @param {id.TileMapElement} map the tilemap source
 * @param {real} x x position of the corner to begin the flip
 * @param {real} y y position of the corner to begin the flip
 * @param {real} width width of the region
 * @param {real} height height of the region
 */
function runtile_rotate_region(map, x, y, width, height) {
	var region = runtile_capture_region(map, x, y, width, height);
	for (var i = 0; i < width; i++) {
		for (var j = 0; j < height; j++) {
			tilemap_set(map, region[width - j - 1][i], x + i, y + j);
		}
	}
}

/**
 * mutates all tiles in a given region so that theyre a random version of their index
 * @param {id.TileMapElement} map the tilemap source
 * @param {real} x x position of the corner to begin the randomization
 * @param {real} y y position of the corner to begin the randomization
 * @param {real} width width of the region
 * @param {real} height height of the region
 */
function runtile_mutate_region(map, x, y, width, height, varities, offset) {
	for (var i = 0; i < width; i++) {
		for (var j = 0; j < height; j++) {
			tilemap_set(map, (tilemap_get(map, x + i, y + j) % offset) + (irandom(varities - 1) * offset), x + i, x +j);
		}
	}
}