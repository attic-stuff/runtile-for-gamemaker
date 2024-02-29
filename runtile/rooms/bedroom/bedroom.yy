{
  "resourceType": "GMRoom",
  "resourceVersion": "1.0",
  "name": "bedroom",
  "creationCodeFile": "${project_dir}/rooms/bedroom/RoomCreationCode.gml",
  "inheritCode": false,
  "inheritCreationOrder": false,
  "inheritLayers": false,
  "instanceCreationOrder": [
    {"name":"inst_A5D4DA2","path":"rooms/bedroom/bedroom.yy",},
  ],
  "isDnd": false,
  "layers": [
    {"resourceType":"GMRTileLayer","resourceVersion":"1.1","name":"takefive","depth":0,"effectEnabled":true,"effectType":null,"gridX":16,"gridY":16,"hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"layers":[],"properties":[],"tiles":{"SerialiseHeight":16,"SerialiseWidth":16,"TileCompressedData":[
-256,-2147483648,],"TileDataFormat":1,},"tilesetId":{"name":"takefiveset","path":"tilesets/takefiveset/takefiveset.yy",},"userdefinedDepth":false,"visible":false,"x":0,"y":0,},
    {"resourceType":"GMRTileLayer","resourceVersion":"1.1","name":"mutate","depth":100,"effectEnabled":true,"effectType":null,"gridX":16,"gridY":16,"hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"layers":[],"properties":[],"tiles":{"SerialiseHeight":16,"SerialiseWidth":16,"TileCompressedData":[
-256,-2147483648,],"TileDataFormat":1,},"tilesetId":{"name":"mutatingcornerset","path":"tilesets/mutatingcornerset/mutatingcornerset.yy",},"userdefinedDepth":false,"visible":false,"x":0,"y":0,},
    {"resourceType":"GMRTileLayer","resourceVersion":"1.1","name":"corner","depth":200,"effectEnabled":true,"effectType":null,"gridX":16,"gridY":16,"hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"layers":[],"properties":[],"tiles":{"SerialiseHeight":16,"SerialiseWidth":16,"TileCompressedData":[
-256,0,],"TileDataFormat":1,},"tilesetId":{"name":"cornerset","path":"tilesets/cornerset/cornerset.yy",},"userdefinedDepth":false,"visible":false,"x":0,"y":0,},
    {"resourceType":"GMRTileLayer","resourceVersion":"1.1","name":"edge","depth":300,"effectEnabled":true,"effectType":null,"gridX":16,"gridY":16,"hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"layers":[],"properties":[],"tiles":{"SerialiseHeight":16,"SerialiseWidth":16,"TileCompressedData":[
-256,0,],"TileDataFormat":1,},"tilesetId":{"name":"edgeset","path":"tilesets/edgeset/edgeset.yy",},"userdefinedDepth":false,"visible":false,"x":0,"y":0,},
    {"resourceType":"GMRTileLayer","resourceVersion":"1.1","name":"blob","depth":400,"effectEnabled":true,"effectType":null,"gridX":16,"gridY":16,"hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"layers":[],"properties":[],"tiles":{"SerialiseHeight":16,"SerialiseWidth":16,"TileCompressedData":[
-8,0,-8,-2147483648,-8,0,-8,-2147483648,-8,0,-8,-2147483648,-8,0,-8,-2147483648,
-8,0,-8,-2147483648,-8,0,-8,-2147483648,-8,0,-8,-2147483648,-8,0,-136,-2147483648,
],"TileDataFormat":1,},"tilesetId":{"name":"blobset","path":"tilesets/blobset/blobset.yy",},"userdefinedDepth":false,"visible":false,"x":0,"y":0,},
    {"resourceType":"GMRTileLayer","resourceVersion":"1.1","name":"grid","depth":500,"effectEnabled":true,"effectType":null,"gridX":16,"gridY":16,"hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"layers":[],"properties":[],"tiles":{"SerialiseHeight":16,"SerialiseWidth":16,"TileCompressedData":[
-256,1,],"TileDataFormat":1,},"tilesetId":{"name":"gridset","path":"tilesets/gridset/gridset.yy",},"userdefinedDepth":false,"visible":false,"x":0,"y":0,},
    {"resourceType":"GMRInstanceLayer","resourceVersion":"1.0","name":"controller","depth":600,"effectEnabled":true,"effectType":null,"gridX":16,"gridY":16,"hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"instances":[
        {"resourceType":"GMRInstance","resourceVersion":"1.0","name":"inst_A5D4DA2","colour":4294967295,"frozen":false,"hasCreationCode":false,"ignore":false,"imageIndex":0,"imageSpeed":1.0,"inheritCode":false,"inheritedItemId":null,"inheritItemSettings":false,"isDnd":false,"objectId":{"name":"object","path":"objects/object/object.yy",},"properties":[],"rotation":0.0,"scaleX":1.0,"scaleY":1.0,"x":0.0,"y":0.0,},
      ],"layers":[],"properties":[],"userdefinedDepth":false,"visible":true,},
    {"resourceType":"GMRBackgroundLayer","resourceVersion":"1.0","name":"backgroundmusic","animationFPS":15.0,"animationSpeedType":0,"colour":4278716424,"depth":700,"effectEnabled":true,"effectType":null,"gridX":16,"gridY":16,"hierarchyFrozen":false,"hspeed":0.0,"htiled":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"layers":[],"properties":[],"spriteId":null,"stretch":false,"userdefinedAnimFPS":false,"userdefinedDepth":false,"visible":true,"vspeed":0.0,"vtiled":false,"x":0,"y":0,},
  ],
  "parent": {
    "name": "runtile",
    "path": "runtile.yyp",
  },
  "parentRoom": null,
  "physicsSettings": {
    "inheritPhysicsSettings": false,
    "PhysicsWorld": false,
    "PhysicsWorldGravityX": 0.0,
    "PhysicsWorldGravityY": 10.0,
    "PhysicsWorldPixToMetres": 0.1,
  },
  "roomSettings": {
    "Height": 256,
    "inheritRoomSettings": false,
    "persistent": false,
    "Width": 256,
  },
  "sequenceId": null,
  "tags": [
    "mom",
  ],
  "views": [
    {"hborder":32,"hport":1024,"hspeed":-1,"hview":256,"inherit":false,"objectId":null,"vborder":32,"visible":false,"vspeed":-1,"wport":1024,"wview":256,"xport":0,"xview":0,"yport":0,"yview":0,},
    {"hborder":32,"hport":360,"hspeed":-1,"hview":360,"inherit":false,"objectId":null,"vborder":32,"visible":false,"vspeed":-1,"wport":640,"wview":640,"xport":0,"xview":0,"yport":0,"yview":0,},
    {"hborder":32,"hport":360,"hspeed":-1,"hview":360,"inherit":false,"objectId":null,"vborder":32,"visible":false,"vspeed":-1,"wport":640,"wview":640,"xport":0,"xview":0,"yport":0,"yview":0,},
    {"hborder":32,"hport":360,"hspeed":-1,"hview":360,"inherit":false,"objectId":null,"vborder":32,"visible":false,"vspeed":-1,"wport":640,"wview":640,"xport":0,"xview":0,"yport":0,"yview":0,},
    {"hborder":32,"hport":360,"hspeed":-1,"hview":360,"inherit":false,"objectId":null,"vborder":32,"visible":false,"vspeed":-1,"wport":640,"wview":640,"xport":0,"xview":0,"yport":0,"yview":0,},
    {"hborder":32,"hport":360,"hspeed":-1,"hview":360,"inherit":false,"objectId":null,"vborder":32,"visible":false,"vspeed":-1,"wport":640,"wview":640,"xport":0,"xview":0,"yport":0,"yview":0,},
    {"hborder":32,"hport":360,"hspeed":-1,"hview":360,"inherit":false,"objectId":null,"vborder":32,"visible":false,"vspeed":-1,"wport":640,"wview":640,"xport":0,"xview":0,"yport":0,"yview":0,},
    {"hborder":32,"hport":360,"hspeed":-1,"hview":360,"inherit":false,"objectId":null,"vborder":32,"visible":false,"vspeed":-1,"wport":640,"wview":640,"xport":0,"xview":0,"yport":0,"yview":0,},
  ],
  "viewSettings": {
    "clearDisplayBuffer": true,
    "clearViewBackground": false,
    "enableViews": false,
    "inheritViewSettings": false,
  },
  "volume": 1.0,
}