# runtile

### runtime autotiling for gamemaker that comes in blob, edge, and corner wang tile flavors

how damn cool are tiles, right? you can use them for pretty much everything in game development. levels, storing big data, procedurally generating yerself a gf. whatever cool thing you want to do, you can and probably use tiles or tileable data to do it.

long story short: gamemaker does not have runtime auto tiling. it has autotiling for 16-tile corner adjacent tiles and 47-tile blob adjacent tiles in the room editor. but not at runtime! and no tile mutation! and no 16-tile edge ajacent autotiling at all! well runtile is to those problems what wu tang is to the children.

### the rules

**rule 1**: you must be using gamemaker version 2023.1 or higher. anything older than that does not work with this*.

**rule 2**: pretty much all autotiling methods rely on the tiles being in a specific order, and runtile is no different. you will need to use the reference templates to make sure these are correct.

**rule 3**: mutated tiles also must come in a specific order, ``index + (varieties * tile count)``. that is to say, if you want a random variation on tile 2 in a 16-tile set, then the tiles for that type need to be at index 2, 18, 34, 40, etc etc.

**rule 4**: to see an example on how it works, download and check out the yyz.

### the tile layouts

| example                                                      | what's up                                                    |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| ![](https://github.com/attic-stuff/runtile-for-gamemaker/blob/main/examples/example-identity.png) | **identity layout**<br />check out this tilemap. it's a simple layout of tiles where the checkered tiles are solid and everything else is not solid. lets use runtile across the tilemap to see the results we get. |
| ![](https://github.com/attic-stuff/runtile-for-gamemaker/blob/main/examples/example-blob.png) | **47-tile, blob layout**<br />this is the most common layout you will find for tilesets that do autotiling. it is a complete set, and will account for all possible edge and corner connections in any given situation. this layout is autotiled 1 tile at a time, meaning if you place a single tile it will be closed on all sides. the template for this layout assumes a top-down angle for tiles but this type of tiling is common in side view stuff too, like platformers. |
| ![](https://github.com/attic-stuff/runtile-for-gamemaker/blob/main/examples/example-corner.png) | **16-tile, corner layout**<br />this is the second most common layout you will find among tilesets in the wild. unlike the blob layout, this type of tile is open. if you place a single tile, it will be open on all sides thus the auto tiling is done by placing nine tiles at once to close the center tile. |
| ![](https://github.com/attic-stuff/runtile-for-gamemaker/blob/main/examples/example-edge.png) | **16-tile, edge layout**<br />this is the best tile layout for things like roads or train tracks or paths in general. this layout is closed, like the blob style, in that a single tile places is closed on all sides. this type of layout sucks if you need a large, filled in area. notice how the enclosed spaces appear to have columns? this is because the open tile for this set is used to connect corners. |
| ![](https://github.com/attic-stuff/runtile-for-gamemaker/blob/main/examples/example-takefive.png) | **16-tile, take five layout**<br />this layout produces the exact same tilemap as the 16-tile, corner layout. except: this one only uses 5 tiles! |

### how to use this sucker

**step one**: make a tilemap layer in the room editor (or via gml at runtime) and assign it the proper tileset you wanna use autotiling with.

**step two**: at runtime, pick a cell, call the update function on it. each layout type as its own update function, which you can use to clear it or set it, and then the autotiling is magically finished for you.

#### core functions:

| runtile_update_blob(map, x, y, [clear], [mutate], [varieties]) |
| :----------------------------------------------------------- |
| places a solid tile and autotiles it based on its neighbors using the blob layout. this mimics gamemaker's built in 47-tile functionality. |
| **map**: the tilemap we're autotiling. this must be a tilemap layer id, not just a layer id.<br />**x**: the x _cell_ coordinate to place a tile at. that means not a pixel coordinate.<br />**y**: the y _cell_ coordinate to place a tile at. again: cell, not pixel.<br />**clear**: true/false option to clear a tile instead of place a tile.<br />**mutate**: true/false option to place a random variation of the tile.<br />**varieties**: the number of varieties of tiles in the tileset. |

| runtile_update_corner(map, x, y, [clear], [mutate], [varieties]) |
| :----------------------------------------------------------- |
| places nine solid tiles then autotiles them based on neighbors using the corner layout. this mimics gamemaker's built in 16-tile autotile functionality. |
| **map**: the tilemap we're autotiling. this must be a tilemap layer id, not just a layer id.<br />**x**: the x _cell_ coordinate to place a tile at. that means not a pixel coordinate.<br />**y**: the y _cell_ coordinate to place a tile at. again: cell, not pixel.<br />**clear**: true/false option to clear a tile instead of place a tile.<br />**mutate**: true/false option to place a random variation of the tile.<br />**varieties**: the number of varieties of tiles in the tileset. |

| runtile_update_edge(map, x, y, [clear], [mutate], [varieties]) |
| :----------------------------------------------------------- |
| places a solid tile and autotiles it based on its neighbors using the corner layout. this layout is not present in gamemaker so do whatever you want idgaf. |
| **map**: the tilemap we're autotiling. this must be a tilemap layer id, not just a layer id.<br />**x**: the x _cell_ coordinate to place a tile at. that means not a pixel coordinate.<br />**y**: the y _cell_ coordinate to place a tile at. again: cell, not pixel.<br />**clear**: true/false option to clear a tile instead of place a tile.<br />**mutate**: true/false option to place a random variation of the tile.<br />**varieties**: the number of varieties of tiles in the tileset. |

| runtile_capture_region(map, x, y, width, height)             |
| :----------------------------------------------------------- |
| converts a region of a tilemap to a two-dimensional array. the is useful if you've mutated your tilemap and want it to be the same upon re-entering a room or something like that. |
| **map**: the tilemap we're capturing from. this must be a tilemap layer id, not just a layer id.<br />**x**: the cell coordinate along the x axis to start the capture.<br />**y**: the cell coordinate along the y axis to start the capture.<br />**width**: width of the region.<br />**height**: height of the region. |
| returns an array!                                            |

| runtile_takefive_setup_tilemap_mask(map)                     |
| :----------------------------------------------------------- |
| sets the tilemap's mask so that its ready to be messed with by the autotiling function, and returns and offset value that must be passed to the matching autotile function |
| **map**: the tilemap we're autotiling. this must be a tilemap layer id, not just a layer id. |
| returns an offset value                                      |

| runtile_takefive_autotile(map, x, y, offset, [variations], [clear], [perturb]) |
| :----------------------------------------------------------- |
| places a solid tile and autotiles it based on its neighbors using marching squares. uses a special tileset that only has 5 tiles. |
| **map**: the tilemap we're autotiling. this must be a tilemap layer id, not just a layer id.<br />**x**: the x _cell_ coordinate to place a tile at. that means not a pixel coordinate.<br />**y**: the y _cell_ coordinate to place a tile at. again: cell, not pixel.<br />**offset**: the offset returned by the setup function, which is used for the bitmask.<br />**variations**: the number of variations on the tileset included on the tileset<br />**clear**: whether or not the tile is being set, or cleared.<br />**perturb**: whether or not the center tile should be rotated or flipped or mirrored, randomly. |

### tileset templates

you can find the templates in their respective folders. the aseprite templates have 3 layers each, the tile artwork layer, a layer with the gm tile indices, and a layer with the values used for the autotiling (which you can ignore unless you're dissecting this repo to learn how to do this yourself). the corner and blob templates are laid out to work in the same order as the built-in autotile templates. checking out this cool image below, you can see that the order you add each tile to the gamemaker template is the same order that they appear in the runtile templates.

<p align="center"><img src="https://github.com/attic-stuff/runtile-for-gamemaker/blob/main/examples/layoutshowoff.png"/></p>

### mutating tilesets

here is an example of a mutating tileset. it uses the corner layout with 4 variations to get a vibrant and varied tilemap! notice how the tileset, to the left of the animation, just repeats itself in order, but with variation.

<p align="center"><img src="https://github.com/attic-stuff/runtile-for-gamemaker/blob/main/examples/animatedmutation.gif"/></p>

### take five

new flavor! now included is what i'm calling the "take five" autotile method: its marching squares but instead of having a tileset that uses 16 tiles, this one only uses 5. the repo includes templates and examples for using it but there is some important stuff to know about taking five. this method of autotiling takes advantage of gamemaker's tilemap data blob layout; it appends marching square information to each tile and then tests for it as the autotiling happens. this means you need to run the setup function before any autotiling happens, to ensure that the tilemap's mask is properly setup.

### faq

**can i add tiles to my tileset, like besides the auto tiling ones?**
yes! just make sure they come _after_ the autotiling tiles. for example, if you're using the corner layout make sure indices 0 through 16 are the autotiling tiles and then put whatever skulls or decorations you want after that.

**how come this doesn't work with older versions of gm?**
because it uses array_get_index, which is new to gm. if you're using the LTS version of gm, or an older monthly release, you can still use this with some work. work that i already did bro, there is a LTS yyz you can download and use the runtile stuff from it. a word of caution: the LTS version uses global ds lists. these lists do not clean themselves up, and shouldnt have to. however if use game_restart() or call the script asset those globals are defined in, you will need to clean them lists up. the take five functionality is not included in the lts build.

**license?**
you are free to use the runtile functions in whatever project you see fit. you can also redistribute the templates if u wanna. you cannot use the font or the mutated tiles for anything though.
