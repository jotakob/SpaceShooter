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
	//public var layerWalls2:FlxTilemap;
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
		var properties:Map<String,String> = new Map<String,String>();

		mapString = ('assets/levels/mapCSV_Demo_Floor.csv').toString();
		image = ('assets/levels/tiles.png');
		properties = generateProperties( [null] );
		layerFloor = addTilemap(Assets.getText(mapString) ,image, 0.000, 0.000, 32, 32, 1.000, 1.000, false, 128, 1, properties, onAddCallback );

		mapString = ('assets/levels/mapCSV_Demo_Walls2.csv').toString();
		image = ('assets/levels/tiles.png');
		properties = generateProperties( [null] );
		layerWalls2 = addTilemap(Assets.getText(mapString) ,image, 0.000, 0.000, 32, 32, 1.000, 1.000, true, 128, 1, properties, onAddCallback );

		mapString = ('assets/levels/mapCSV_Demo_Walls.csv').toString();
		image = ('assets/levels/tiles.png');
		properties = generateProperties( [null] );
		layerWalls = addTilemap(Assets.getText(mapString) ,image, 0.000, 0.000, 32, 32, 1.000, 1.000, true, 128, 1, properties, onAddCallback );


		//Add layers to the master group in correct order.
	masterLayer.add(layerFloor);
	masterLayer.add(layerWalls2);
	masterLayer.add(layerWalls);
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
		addShapesForLayerObjects(onAddCallback);
		generateObjectLinks(onAddCallback);
		if ( parentObject != null )
			parentObject.add(masterLayer);
		else
			FlxG.state.add(masterLayer);
	}

	public function addShapesForLayerObjects(onAddCallback:Dynamic = null):Void
	{
		var obj:Dynamic;

		obj = new BoxData(1974.040, 411.930, 0.000, 28.310, 31.830, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"button" }, { name:"settiles", value:"47,13,0|45,17,130" }, { name:"triggeronce", value:false }, { name:"resettimer", value:1000 }, null] ), 1, 1 );
		obj = new BoxData(1694.980, 672.000, 0.000, 66.320, 21.700, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"trigger" }, { name:"text", value:"This doesn't seem right at all..." }, { name:"textsource", value:"Soldier" }, null] ), 1, 1 );
		obj = new BoxData(1702.000, 788.000, 0.000, 52.040, 39.880, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"warpexit" }, { name:"id", value:0 }, null] ), 1, 1 );
		obj = new BoxData(1460.000, 474.000, 0.000, 23.580, 31.830, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"button" }, { name:"settiles", value:"47,13,0|45,17,130" }, { name:"triggeronce", value:false }, { name:"resettimer", value:1000 }, null] ), 1, 1 );
		obj = new BoxData(1793.000, 865.000, 0.000, 19.000, 19.000, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"button" }, null] ), 1, 1 );
	}

	public function generateObjectLinks(onAddCallback:Dynamic = null):Void
	{
	}

}
