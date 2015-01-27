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

class Level_Demo2 extends BaseLevel
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

		mapString = ('assets/levels/mapCSV_Demo2_Floor.csv').toString();
		image = ('assets/levels/tiles.png');
		properties = generateProperties( [null] );
		layerFloor = addTilemap(Assets.getText(mapString) ,image, 0.000, 0.000, 32, 32, 1.000, 1.000, false, 128, 1, properties, onAddCallback );

		mapString = ('assets/levels/mapCSV_Demo2_Walls.csv').toString();
		image = ('assets/levels/tiles.png');
		properties = generateProperties( [null] );
		layerWalls = addTilemap(Assets.getText(mapString) ,image, 0.000, 0.000, 32, 32, 1.000, 1.000, true, 128, 1, properties, onAddCallback );

		mapString = ('assets/levels/mapCSV_Demo2_InteractiveTiles.csv').toString();
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
		boundsMaxX = 2176;
		boundsMaxY = 1152;
		boundsMin = new FlxPoint(0, 0);
		boundsMax = new FlxPoint(2176, 1152);
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

		obj = new BoxData(286.000, 1067.000, 0.000, 124.600, 73.000, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"warpexit" }, { name:"id", value:0 }, null] ), 1, 1 );
		obj = new BoxData(527.000, 160.000, 0.000, 28.028, 26.580, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"button" }, { name:"setTiles", value:"17,6,0|17,7,0|17,80|17,9,0|17,10,0" }, null] ), 1, 1 );
		obj = new BoxData(640.000, 829.000, 0.000, 28.000, 28.000, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"pickup" }, { name:"class", value:"lore" }, null] ), 1, 1 );
		obj = new BoxData(2071.000, 1051.000, 0.000, 28.000, 28.000, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"pickup" }, { name:"class", value:"lore" }, null] ), 1, 1 );
		obj = new BoxData(1996.000, 115.000, 0.000, 28.000, 28.000, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"pickup" }, { name:"class", value:"lore" }, null] ), 1, 1 );
		obj = new BoxData(165.000, 484.000, 0.000, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(645.000, 231.000, 0.000, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(720.000, 414.000, 0.000, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(876.000, 340.000, 0.000, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(1133.000, 240.000, 0.000, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(1270.000, 395.000, 0.000, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(1156.000, 509.000, 0.000, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(1133.000, 731.000, 0.000, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(1033.000, 900.000, 0.000, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(1215.000, 968.000, 0.000, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(1358.000, 723.000, 0.000, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(1475.000, 556.000, 0.000, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(1578.000, 420.000, 0.000, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(814.000, 514.000, 0.000, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(1845.000, 80.000, 0.000, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(1872.000, 109.000, 0.000, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(1946.000, 92.000, 0.000, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(1939.000, 143.000, 0.000, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(2020.000, 97.000, 0.000, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(1575.000, 231.000, 0.000, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(1810.000, 422.000, 0.000, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(2023.000, 537.000, 0.000, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(1758.000, 601.000, 0.000, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(1733.000, 820.000, 0.000, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(1908.000, 827.000, 0.000, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(2048.000, 859.000, 0.000, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(1804.000, 891.000, 0.000, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(1980.000, 929.000, 0.000, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(1802.000, 992.000, 0.000, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(1972.000, 1024.000, 0.000, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(1799.000, 1060.000, 0.000, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(1822.000, 790.000, 0.000, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(1515.000, 1040.000, 0.000, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(1054.000, 1056.000, 0.000, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
		obj = new BoxData(577.000, 548.000, 0.000, 21.150, 21.150, ObjectsGroup );
		shapes.push(obj);
		callbackNewData( obj, onAddCallback, ObjectsGroup, generateProperties( [{ name:"type", value:"enemy" }, null] ), 1, 1 );
	}

	public function generateObjectLinks(onAddCallback:Dynamic = null):Void
	{
	}

}
