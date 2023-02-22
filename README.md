<p align="center"><img src="https://github.com/attic-stuff/runtile-for-gamemaker/blob/main/runtilelogo.gif"/></p>

# runtile

### runtime autotiling for gamemaker that comes in blob, edge, and marching square flavors

how cool are tiles, right? you can use them for absolutely everything: cool city pathways, generating noise, storing data and pretty much every possible game development thing you could ever think of. they are just the best. in gamemaker, we usually use them for level making reasons in the room editor and the tile asset in gamemaker makes it easy by allowing you to create autotile brushes. the problem with these brushes is twofold, however: a) they only come in marching square and blob flavors and 2) there is no built-in way to use those tools at runtime.

so if your game is about farming and you need hella dirt plots wherever your guy hits it with a shovel, then you have to make your own autotiling. the problem with having to make your own autotiling is also twofold: a) all of the tutorials online use confusing terms like bitmasking (tf?) and b) there is literally no tutorial on the internet to create an autotiling function that works the same way as gm's marching square set.

so that's what runtile is for: its runtime autotiling. it can also mutate tiles as they are placed, which means it will choose a random variation of a tile to place if you want it to.

### the rules

**one**: there are some rules for this libary. the biggest rule is that it is immutable. it is built for speed, very very fast speeds, so it relies heavily on incomprehensible code. the first rule is that the system is hardcoded. it expects your tiles to be in in a specific order to work. this doesnt mean your tilesets can only have the autotiling tiles on them, it just means that your autotile tiles have to be the first tiles on the tileset and they have to be in a specific order. and if you are using the mutate functionality, they need to follow the initial tiles. so if your tileset is a dirt path and a bunch of cool castle stuff then the cool castle stuff needs to comes _after_ the dirt path tiles.

**two**: runtile supports three different autotiling layouts called edge, blob, and marching square. blob and marching square are the types of tile layouts that gm provides via the tileset asset, and edge tilesets are simpler versions of the blob style tileset.

| eample                                                       | info                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| <img src="C:\Users\cecil\Desktop\work\GM REPOs\runtile-for-gamemaker\blob47template.png" /> | this is the 47-tile, blob style layout. its one of the more commonly used tilesets in all types of games because it connects all corners and is useful in pretty much all types of games. generally the way this one works, is all the tiles match in the corners, inwards and outwards. |
| ![](C:\Users\cecil\Desktop\work\GM REPOs\runtile-for-gamemaker\corner16template.png) | this is the 16-tile, marching square style layout. this one is very commonly the thing used for stuff like tufts of grass, dirt patches and whatnot. |

