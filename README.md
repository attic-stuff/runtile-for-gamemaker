# runtile

### runtime autotiling for gamemaker that comes in blob, edge, and corner wang tile flavors

how damn cool are tiles, right? you can use them for pretty much everything in game development. levels, storing big data, procedurally generating yerself a gf. whatever cool thing you want to do, you can and probably use tiles or tileable data to do it.

long story short: gamemaker does not have runtime auto tiling. it has autotiling for 16-tile corner adjacent tiles and 47-tile blob adjacent tiles in the room editor. but not at runtime! and no tile mutation! and no 16-tile edge ajacent autotiling at all! well runtile is to those problems what wu tang is to the children. it includes functions for runtime autotiling and tile mutation.

### the rules

**rule 1**: you must be using gamemaker version 2023.1 and higher. anything older than that does not work with this*.

**rule 2**: pretty much all autotiling methods rely on the tiles being in a specific order, and runtile is no different. you will need to use the reference templates to make sure these are correct.

**rule 3**: mutated tiles also must come in a specific order, ``index + (varieties * tile count)``. that is to say, if you want a random variation on tile 2 in a 16-tile set, then the tiles for that type need to be at index 2, 18, 34, 40, etc etc.

### the tile layouts

| example                                                      | what's up                                                    |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| ![](https://github.com/attic-stuff/runtile-for-gamemaker/blob/main/example-identity.png) | **identity layout**<br />check out this tilemap. it's a simple layout of tiles where the checkered tile solid and everything else is not solid. lets use runtile across the tilemap to see the results we get. |
| ![](https://github.com/attic-stuff/runtile-for-gamemaker/blob/main/example-blob.png) | **47-tile, blob layout**<br />this is the most common layout you will find for tilesets that do autotiling. it is a complete set, and will account for all possible edge and corner connections in any given situation. this layout is autotiled 1 tile at a time, meaning if you place a single tile it will be closed on all sides. the template for this layout assumes a top-down angle for tiles but this type of tiling is common in side view stuff too, like platformers. |
| ![](https://github.com/attic-stuff/runtile-for-gamemaker/blob/main/example-corner.png) | **16-tile, corner layout**<br />this is the second most common layout you will find among tilesets in the wild. unlike the blob layout, this type of tile is open. if you place a single tile, it will be open on all sides thus the auto tiling is done by placing nine tiles at once to close the center tile. |
| ![](https://github.com/attic-stuff/runtile-for-gamemaker/blob/main/example-edge.png) | **16-tile, edge layout**<br />this is the best tile layout for things like roads or train tracks or paths in general. this layout is closed, like the blob style, in that a single tile places is closed on all sides. this type of layout sucks if you need a large, filled in area. notice how the enclosed spaces appear to have columns? this is because the open tile for this set is used to connect corners. |