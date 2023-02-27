/**
 * calculates what tile should be used when autoling a 16-tile, marching square tile set.
 * @param {id.TileMapElement} map the tilemap source
 * @param {real} x the x coordinate of the cell to evaluate
 * @param {real} y the y coordinate of the cell to evaluate
 * @returns {real}
 */
function runtile_fetch_corner(map, x, y) {
	static table = [ -1, 15, 13, 14, 12, 11, 9, 10, 8, 7, 5, 6, 4, 3, 1, 2, 0 ];
	static corners = [ -1,
		0b1111, 0b1011, 0b0111, 0b0011, 
		0b1101, 0b1001, 0b0101, 0b0001,
		0b1110, 0b1010, 0b0110, 0b0010, 
		0b1100, 0b1000, 0b0100, 0b0000
	];
	var width = tilemap_get_width(map) - 1;
	var height = tilemap_get_height(map) - 1;
	
	var e = clamp(x + 1, 0, width);
	var n = clamp(y - 1, 0, height);
	var w = clamp(x - 1, 0, width);
	var s = clamp(y + 1, 0, height);
	var ne = tilemap_get(map, e, n) % 16;
	ne = (corners[(ne == 0 ? 16 : ne)] & 0b0010) != 0;
	var nw = tilemap_get(map, w, n) % 16;
	nw = (corners[(nw == 0 ? 16 : nw)] & 0b0001) != 0;	
	var sw = tilemap_get(map, w, s) % 16;
	sw = (corners[(sw == 0 ? 16 : sw)] & 0b1000) != 0;	
	var se = tilemap_get(map, e, s) % 16;
	se = (corners[(se == 0 ? 16 : se)] & 0b0100) != 0;	
	return array_get_index(table, (ne * 1) + (nw * 2) + (sw * 4) + (se * 8));
}

/**
 * autotiles a 3x3 square of tiles using the marching square method
 * @param {id.TileMapElement} map the tilemap source
 * @param {real} x center x cell coordinate of the 3x3 square
 * @param {real} y center y cell coordinate of the 3x3 square
 * @param {bool} [mutate] whether or not to randomise the result
 * @param {real} [varieties] the number of varieties of tiles
 */
function runtile_autotile_corner(map, x, y, mutate = false, varieties = 2) {
	static neighborhood = [ [0,0], [1,0], [1,-1], [0,-1], [-1,-1], [-1,0], [-1,1], [0,1], [1,1] ];
	for (var i = 1; i < 9; i++) {
		var tx = x + neighborhood[i][0];
		var ty = y + neighborhood[i][1];
		tilemap_set(map, runtile_fetch_corner(map, tx, ty) + (mutate * (irandom(varieties - 1) * 16)), tx, ty);
	}
}

/**
 * wrapper for marching square autotiling
 * @param {id.TileMapElement} map the tilemap source
 * @param {real} x the x coordinate of the cell to evaluate
 * @param {real} y the y coordinate of the cell to evaluate
 * @param {bool} [clear] whether or not to clear the cell or set the cell
 * @param {bool} [mutate] whether or not to randomise the result
 * @param {real} [varieties] the number of varieties of tiles
 */
function runtile_update_corner(map, x, y, clear = false, mutate = false, varieties = 2) {
	static neighborhood = [ [0,0], [1,0], [1,-1], [0,-1], [-1,-1], [-1,0], [-1,1], [0,1], [1,1] ];
	for (var i = 0; i < 9; i++) {
		tilemap_set(map, clear ? 16 : 1, x + neighborhood[i][0], y + neighborhood[i][1]);
	}
	runtile_autotile_corner(map, x, y, mutate, varieties);
}

/**
 * calculates what tile should be used when autotiling a 16-tile, wang tileset.
 * if you would like the tilemap to be unbound by the tilemap size, change each > comparison to !=
 * @param {id.TileMapElement} map the tilemap source
 * @param {real} x the x coordinate of the cell to evaluate
 * @param {real} y the y coordinate of the cell to evaluate
 * @returns {real}
 */ 
function runtile_fetch_edge(map, x, y) {
	static table = [ -1, 0, 15, 1, 2, 4, 8, 5, 10, 11, 13, 14, 7, 9, 3, 6, 12 ];
	var e = tilemap_get(map, x + 1, y) > 0;
	var n = tilemap_get(map, x, y - 1) > 0;
	var w = tilemap_get(map, x - 1, y) > 0;
	var s = tilemap_get(map, x, y + 1) > 0;
	return array_get_index(table, (e * 1) + (n * 2) + (w * 4) + (s * 8));
}

/**
 * autotiles a 3x3 square of tiles using the wang method
 * @param {id.TileMapElement} map the tilemap source
 * @param {real} x center x cell coordinate of the 3x3 square
 * @param {real} y center y cell coordinate of the 3x3 square
 * @param {bool} [mutate] whether or not to randomise the result
 * @param {real} [varieties] the number of varieties of tiles
 */
function runtile_autotile_edge(map, x, y, mutate = false, varieties = 2) {
	static neighborhood = [ [0,0], [1,0], [1,-1], [0,-1], [-1,-1], [-1,0], [-1,1], [0,1], [1,1] ];
	for (var i = 0; i < 9; i++) {
		var tx = x + neighborhood[i][0];
		var ty = y + neighborhood[i][1];
		if (tilemap_get(map, tx, ty) > 0) {
			tilemap_set(map, runtile_fetch_edge(map, tx, ty) + (mutate * (irandom(varieties - 1) * 16)), tx, ty);
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
function runtile_update_edge(map, x, y, clear = false, mutate = false, varieties = 2) {
	tilemap_set(map, clear ? 0 : 1, x, y);
	runtile_autotile_edge(map, x, y, mutate, varieties);
};

/**
 * calculates which tile index should be used to blob autotile a given cell based on the status of its neighbors.
 * if you would like the tilemap to be unbound by the tilemap size, change each > comparison to !=
 * @param {id.TileMapElement} map tilemap
 * @param {real} x the x coordinate of the cell to evaluate
 * @param {real} y the y coordinate of the cell to evaluate
 */
function runtile_fetch_blob(map, x, y) {
	static table = [ -1,
		 255, 247, 253, 245, 127, 119, 125,
		 117, 223, 215, 221, 213,  95,  87,  93,  
		  85, 199, 197,  71,  69, 241, 113, 209,
		  81, 124,  92, 116,  84,  31,  23,  29,
		  21,  68,  17, 193,  65, 112,  80,  28,
		  20,   7,   5,  64,   1,   4,  16,   0,
	];
	var r = x + 1;
	var u = y - 1;
	var l = x - 1;
	var d = y + 1;
	var e = tilemap_get(map, r, y) > 0;
	var ne = tilemap_get(map, r, u) > 0;
	var n = tilemap_get(map, x, u) > 0;
	var nw = tilemap_get(map, l, u) > 0;
	var w = tilemap_get(map, l, y) > 0;
	var sw = tilemap_get(map, l, d) > 0;
	var s = tilemap_get(map, x, d) > 0;
	var se = tilemap_get(map, r, d) > 0;
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
function runtile_autotile_blob(map, x, y, mutate = false, varieties = 2) {
	static neighborhood = [ [0,0], [1,0], [1,-1], [0,-1], [-1,-1], [-1,0], [-1,1], [0,1], [1,1] ];
	for (var i = 0; i < 9; ++i) {
		var tx = x + neighborhood[i][0];
		var ty = y + neighborhood[i][1];
		if (tilemap_get(map, tx, ty) > 0) {
			tilemap_set(map, runtile_fetch_blob(map, tx, ty) + (mutate * (irandom(varieties - 1) * 48)), tx, ty);
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
function runtile_update_blob(map, x, y, clear = false, mutate = false, varieties = 2) {
	tilemap_set(map, clear ? 0 : 46 + (mutate * (irandom(varieties - 1) * 48)), x, y);
	runtile_autotile_blob(map, x, y, mutate, varieties);
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