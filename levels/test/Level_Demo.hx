//Code generated with DAME and DeVZoO. http://www.dambots.com http://www.dev-zoo.net

package; 

import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.text.FlxText;
import flixel.util.FlxPoint;
import flixel.tile.FlxTilemap;
import openfl.Assets;
import flash.utils.Dictionary;

class Level_Demo extends BaseLevel
{
	//Embedded media...

	//Tilemaps
	public var layerFloor:FlxTilemap;
	public var layerWalls:FlxTilemap;

	//Shapes
	public var ObjectsGroup:FlxGroup;

	//Properties


	public function new(addToStage:Bool = true, onAddCallback:Dynamic = null, parentObject:Dynamic = null)
	{
		super();
		var mapString:String;
		var image:Dynamic;
		//Shapes
		ObjectsGroup= new FlxGroup();

		// Generate maps.
		var properties:Map<String,Dynamic> = new Map<String,Dynamic>();

		mapString = ('assets/levels/mapCSV_Demo_Floor.csv').toString();
		image = ('assets/levels/tiles.png');
		properties = generateProperties( [null] );
		layerFloor = addTilemap(Assets.getText(mapString) ,image, 0.000, 0.000, 32, 32, 1.000, 1.000, false, 128, 1, properties, onAddCallback );

		mapString = ('assets/levels/mapCSV_Demo_Walls.csv').toString();
		image = ('assets/levels/tiles.png');
		properties = generateProperties( [null] );
		layerWalls = addTilemap(Assets.getText(mapString) ,image, 0.000, 0.000, 32, 32, 1.000, 1.000, true, 128, 1, properties, onAddCallback );

		mapString = ('assets/levels/mapCSV_Demo_InteractiveTiles.csv').toString();
		image = ('assets/levels/tiles.png');
		properties = generateProperties( [null] );
		layerInteractiveTiles = addTilemap(Assets.getText(mapString) ,image, 0.000, 0.000, 32, 32, 1.000, 1.000, true, 128, 1, properties, onAddCallback );


		//Add layers to the master group in correct order.
		masterLayer.add(layerFloor);
		masterLayer.add(layerWalls);
		masterLayer.add(layerInteractiveTiles);
		masterLayer.add(ObjectsGroup);

		if ( addToStage )
			createObjects(onAddCallback, parentObject);

		boundsMinX = 0;
		boundsMinY = 0;
		boundsMaxX = 2048;
		boundsMaxY = 1024;
		boundsMin = new FlxPoint(0, 0);
		boundsMax = new FlxPoint(2048, 1024);
		bgColor = 0xff777777;
	}

	override public function createObjects(onAddCallback:Dynamic = null, parentObject:Dynamic = null):Void
	{
		if ( parentObject != null )
			parentObject.add(masterLayer);
		else
			FlxG.state.add(masterLayer);
		addShapesForLayerObjects(onAddCallback);
		generateObjectLinks(onAddCallback);
	}

	public function addShapesForLayerObjects(onAddCallback:Dynamic = null):Void
	{
		var obj:Dynamic;

		obj = new BoxData(1974.040, 411.930, 0.000, 28.310, 31.830, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"button" }, { name:"setTiles", value:"47,12,0|47,13,0|47,14,0" }, { name:"resetTime", value:90 }, { name:"repeatable", value:true }, null] ), 1, 1 );
		obj = new BoxData(1694.980, 672.000, 0.000, 66.320, 21.700, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"trigger" }, { name:"text", value:"This doesn't seem right at all..." }, { name:"textsource", value:"Soldier" }, null] ), 1, 1 );
		obj = new BoxData(1664.000, 781.000, 0.000, 96.424, 41.880, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"warpexit" }, { name:"id", value:0 }, null] ), 1, 1 );
		obj = new BoxData(1919.000, 394.000, 0.000, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(1648.000, 389.000, 0.210, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(1008.000, 469.000, 273.110, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(1028.000, 687.000, 312.610, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(1155.000, 686.000, 177.710, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(1164.000, 333.000, 90.860, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(982.000, 282.000, 0.000, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(1192.000, 595.000, 324.200, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(1085.000, 556.120, 24.500, 19.040, 19.040, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(1172.000, 403.000, 245.510, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(1082.000, 934.000, 0.000, 19.700, 31.830, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"button" }, { name:"setTiles", value:"42,6,0|43,6,0|44,6,0|45,6,0" }, { name:"repeatable", value:false }, null] ), 1, 1 );
		obj = new BoxData(280.000, 392.000, 320.100, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(438.000, 454.000, 0.210, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(540.000, 689.000, 85.790, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(471.000, 486.000, 0.210, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(820.000, 435.000, 90.970, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(232.000, 621.000, 345.970, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(481.000, 824.000, 268.380, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(691.000, 252.000, 0.210, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(1266.000, 669.000, 0.000, 28.310, 31.830, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"button" }, { name:"setTiles", value:"42,9,0|43,9,0|44,9,0|45,9,0" }, { name:"repeatable", value:false }, null] ), 1, 1 );
		obj = new BoxData(1787.000, 697.000, 0.000, 29.410, 18.030, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"button" }, { name:"repeatable", value:false }, { name:"resetTime", value:90 }, { name:"setTiles", value:"52,20,0|53,20,0|54,20,0|55,20,0|56,21,172" }, null] ), 1, 1 );
		obj = new BoxData(1461.000, 475.000, 0.000, 28.310, 31.830, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"button" }, { name:"setTiles", value:"47,12,0|47,13,0|47,14,0" }, { name:"resetTime", value:90 }, { name:"repeatable", value:true }, null] ), 1, 1 );
		obj = new BoxData(138.140, 578.000, 0.000, 50.500, 58.640, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"warp" }, { name:"target", value:"Demo2" }, { name:"repeatable", value:true }, { name:"resetTime", value:1 }, null] ), 1, 1 );
		obj = new BoxData(111.000, 576.000, 0.000, 32.350, 62.240, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"collisionbox" }, null] ), 1, 1 );
		obj = new BoxData(1325.000, 800.000, 0.000, 36.270, 62.000, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"collisionbox" }, null] ), 1, 1 );
		obj = new BoxData(617.000, 415.000, 0.000, 45.140, 62.000, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"collisionbox" }, null] ), 1, 1 );
		obj = new BoxData(1506.000, 962.000, 0.000, 27.450, 27.450, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"trigger" }, { name:"setTiles", value:"45,27,255|45,29,6|47,30,4" }, { name:"repeatable", value:true }, { name:"resetTime", value:2 }, null] ), 1, 1 );
		obj = new BoxData(1314.000, 898.000, 0.000, 27.450, 27.450, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"trigger" }, { name:"setTiles", value:"43,28,255|43,27,6|41,28,4" }, { name:"repeatable", value:true }, { name:"resetTime", value:2 }, null] ), 1, 1 );
		obj = new BoxData(1378.000, 962.000, 0.000, 27.450, 27.450, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"trigger" }, { name:"setTiles", value:"45,29,255|43,28,6|43,30,4" }, { name:"repeatable", value:true }, { name:"resetTime", value:2 }, null] ), 1, 1 );
		obj = new BoxData(1410.000, 802.000, 0.000, 27.420, 27.420, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"trigger" }, { name:"setTiles", value:"45,27,6|43,27,255|44,25,4" }, { name:"repeatable", value:true }, { name:"resetTime", value:2 }, null] ), 1, 1 );
		obj = new BoxData(1729.235, 833.000, 0.000, 61.765, 61.000, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"collisionbox" }, null] ), 1, 1 );
		obj = new BoxData(1705.093, 874.313, 0.000, 22.376, 18.217, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"collisionbox" }, null] ), 1, 1 );
		obj = new BoxData(1720.000, 855.738, 0.000, 8.000, 9.421, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"collisionbox" }, null] ), 1, 1 );
		obj = new BoxData(1714.000, 865.000, 0.000, 13.394, 8.338, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"collisionbox" }, null] ), 1, 1 );
		obj = new BoxData(1725.000, 846.000, 0.000, 8.000, 12.507, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"collisionbox" }, null] ), 1, 1 );
	}

	public function generateObjectLinks(onAddCallback:Dynamic = null):Void
	{
	}

}
