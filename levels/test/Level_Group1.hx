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

class Level_Group1 extends BaseLevel
{
	//Embedded media...

	//Tilemaps
	public var layerMap3:FlxTilemap;
	public var layerMap1:FlxTilemap;

	//Shapes
	public var Layer2Group:FlxGroup;

	//Paths
	public var Layer1Group:FlxGroup;

	//Properties


	public function new(addToStage:Bool = true, onAddCallback:Dynamic = null, parentObject:Dynamic = null)
	{
		super();
		var mapString:String;
		var image:Dynamic;
		//Shapes
		Layer2Group= new FlxGroup();

		//Paths
		Layer1Group = new FlxGroup();

		// Generate maps.
		var properties:Array<Dynamic> = new Array<Dynamic>();

		mapString = AssetPaths.mapCSV_Group1_Map3__csv;
		image = AssetPaths.terrain__png;
		properties = generateProperties( [null] );
		layerMap3 = addTilemap(Assets.getText(mapString) ,image, 0.000, 0.000, 32, 32, 1.000, 1.000, false, 20, 1, properties, onAddCallback );

		mapString = AssetPaths.mapCSV_Group1_Map1__csv;
		image = AssetPaths.terrain__png;
		properties = generateProperties( [null] );
		layerMap1 = addTilemap(Assets.getText(mapString) ,image, 0.000, 0.000, 32, 32, 1.000, 1.000, true, 1, 1, properties, onAddCallback );


		//Add layers to the master group in correct order.
		masterLayer.add(layerMap3);
		masterLayer.add(Layer1Group);
		masterLayer.add(Layer2Group);
		masterLayer.add(layerMap1);

		if ( addToStage )
			createObjects(onAddCallback, parentObject);

		boundsMinX = 0;
		boundsMinY = 0;
		boundsMaxX = 512;
		boundsMaxY = 512;
		boundsMin = new FlxPoint(0, 0);
		boundsMax = new FlxPoint(512, 512);
		bgColor = 0xff777777;
	}

	override public function createObjects(onAddCallback:Dynamic = null, parentObject:Dynamic = null):Void
	{
		addPathsForLayerLayer1(onAddCallback);
		addShapesForLayerLayer2(onAddCallback);
		generateObjectLinks(onAddCallback);
		if ( parentObject != null )
			parentObject.add(masterLayer);
		else
			FlxG.state.add(masterLayer);
	}

	public function addPathsForLayerLayer1(onAddCallback:Dynamic = null):Void
	{
		var pathobj:PathData;

		pathobj = new PathData( [ new FlxPoint(516.000, 517.000),
			new FlxPoint(518.000, -5.000),
			new FlxPoint(450.000, -4.000),
			new FlxPoint(452.000, 128.000),
			new FlxPoint(386.000, 351.000),
			new FlxPoint(356.000, 415.000),
			new FlxPoint(256.000, 516.000) 
		], true, false, Layer1Group );
		paths.push(pathobj);
		callbackNewData( pathobj, onAddCallback, Layer1Group, generateProperties( [null] ), 1, 1 );

		pathobj = new PathData( [ { pos:new FlxPoint(59.000, 101.010), tan1:new FlxPoint(-73.450, 243.700), tan2:new FlxPoint(-(22.000), -(-73.000)) },
			{ pos:new FlxPoint(129.000, 181.000), tan1:new FlxPoint(27.000, -61.000), tan2:new FlxPoint(-(-12.140), -(27.430)) } 
		], true, false, Layer1Group );
		paths.push(pathobj);
		callbackNewData( pathobj, onAddCallback, Layer1Group, generateProperties( [null] ), 1, 1 );

	}

	public function addShapesForLayerLayer2(onAddCallback:Dynamic = null):Void
	{
		var obj:Dynamic;

	}

	public function generateObjectLinks(onAddCallback:Dynamic = null):Void
	{
		
	}

}
