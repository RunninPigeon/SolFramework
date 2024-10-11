{
  "resourceType": "GMObject",
  "resourceVersion": "1.0",
  "name": "obj_path_swapper_h",
  "spriteId": {
    "name": "spr_path_swapper_h",
    "path": "sprites/spr_path_swapper_h/spr_path_swapper_h.yy",
  },
  "solid": false,
  "visible": false,
  "managed": true,
  "spriteMaskId": null,
  "persistent": false,
  "parentObjectId": null,
  "physicsObject": false,
  "physicsSensor": false,
  "physicsShape": 1,
  "physicsGroup": 1,
  "physicsDensity": 0.5,
  "physicsRestitution": 0.1,
  "physicsLinearDamping": 0.1,
  "physicsAngularDamping": 0.1,
  "physicsFriction": 0.2,
  "physicsStartAwake": true,
  "physicsKinematic": false,
  "physicsShapePoints": [],
  "eventList": [
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","isDnD":false,"eventNum":0,"eventType":3,"collisionObjectId":null,},
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","isDnD":false,"eventNum":0,"eventType":0,"collisionObjectId":null,},
  ],
  "properties": [
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"vd_ground_only","varType":3,"value":"0","rangeEnabled":false,"rangeMin":0.0,"rangeMax":10.0,"listItems":[],"multiselect":false,"filters":[],},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"vd_layer_left","varType":6,"value":"TILELAYER.SECONDARY","rangeEnabled":false,"rangeMin":0.0,"rangeMax":10.0,"listItems":[
        "TILELAYER.SECONDARY",
        "TILELAYER.MAIN",
      ],"multiselect":false,"filters":[],},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"vd_layer_right","varType":6,"value":"TILELAYER.MAIN","rangeEnabled":false,"rangeMin":0.0,"rangeMax":10.0,"listItems":[
        "TILELAYER.MAIN",
        "TILELAYER.SECONDARY",
      ],"multiselect":false,"filters":[],},
  ],
  "overriddenProperties": [],
  "parent": {
    "name": "Triggers",
    "path": "folders/Objects/Triggers.yy",
  },
}