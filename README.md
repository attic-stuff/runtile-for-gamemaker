<p align="center"><img src="https://github.com/attic-stuff/runtile-for-gamemaker/blob/main/runtilelogo.gif"/></p>

# runtile

### runtime autotiling for gamemaker that comes in blob, edge, and marching square flavors

how cool are tiles, right? you can use them for absolutely everything: cool city pathways, generating noise, storing data and pretty much every possible game development thing you could ever think of. they are just the best. in gamemaker, we usually use them for level making reasons in the room editor and the tile asset in gamemaker makes it easy by allowing you to create autotile brushes. the problem with these brushes is twofold, however: a) they only come in marching square and blob flavors and 2) there is no built-in way to use those tools at runtime.

so if your game is about farming and you need hella dirt plots wherever your guy hits it with a shovel, then you have to make your own autotiling. the problem with having to make your own autotiling is also twofold: a) all of the tutorials online use confusing terms like bitmasking (tf?) and b) there is literally no tutorial on the internet to create an autotiling function that works the same way as gm's marching square set.

so that's what runtile is for: its runtime autotiling. it can also mutate tiles as they are placed, which means it will choose a random variation of a tile to place if you want it to.

### the rules

**one**: there are some rules for this libary. the biggest rule is that it is immutable. it is built for speed, very very fast speeds, so it relies heavily on incomprehensible code. the first rule is that the system is hardcoded. it expects your tiles to be in in a specific order to work. this doesnt mean your tilesets can only have the autotiling tiles on them, it just means that your autotile tiles have to be the first tiles on the tileset and they have to be in a specific order. and if you are using the mutate functionality, they need to follow the initial tiles. so if your tileset is a dirt path and a bunch of cool castle stuff then the cool castle stuff needs to comes _after_ the dirt path tiles.

**two**: runtile supports three different autotiling layouts. all three of them are types of wang tiles, but in the interest of being able to tell the difference between them lets call them **blob**, **marching square**, and **edge** layouts.

| eample                                                       | info                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| ![](https://github.com/attic-stuff/runtile-for-gamemaker/blob/main/blob47template.png) | this is the 47-tile, **blob** style layout. it has 47 tiles that are contained, meaning that a single tile by itself is closed to itself on the corners. this is the layout i suggest for pretty much everything as it accounts for pretty much every possible situation. |
| ![](https://github.com/attic-stuff/runtile-for-gamemaker/blob/main/corner16template.png) | this is the 16-tile, **marching square** style layout. this layout is open, in that a single tile by itself is not closed, but needs a tile on each side and corner to be closed. these tiles work corner to corner, unlike the other two that work face-to-face. like a good fist fight. |
| ![](https://github.com/attic-stuff/runtile-for-gamemaker/blob/main/edge16template.png) | this is the 16-tile, **edge** style layout. its similar to the blob layout in that a single tile on its own is closed on all sides. it has less tiles though, and works in far fewer situations. its great for things like roads and tracks, rather than landscapes. |

<p align="center"><img src="https://github.com/attic-stuff/runtile-for-gamemaker/blob/main/setcomparison.png"/></p>

check out this comparison of the three types and make some observations: the edge layout does not have a solid interior tile so it creates columns at every corner, and the marching square layout does not extend to the edge of a tile. the edge layout really does best for paths and lines instead of shapes. blob style is just there, doing its job. the edge layout is great for roads and bad for parking lots, the blob layout can do roads and parking lots really well, and the marching square layout is great for like islands on an ocean or something. the marching square layout can sorta do what blob can with less tiles, at the cost of tilemap real estate