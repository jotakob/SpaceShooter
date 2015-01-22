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

class Level_MCTest extends BaseLevel
{
	//Embedded media...

	//Tilemaps
	public var layerLevelBase:FlxTilemap;
	public var layerCollisionMap:FlxTilemap;

	//Shapes
	public var SpritesGroup:FlxGroup;

	//Paths
	public var LevelCollisionGroup:FlxGroup;

	//Properties


	public function new(addToStage:Bool = true, onAddCallback:Dynamic = null, parentObject:Dynamic = null)
	{
		super();
		var mapString:String;
		var image:Dynamic;
		//Shapes
		SpritesGroup= new FlxGroup();

		//Paths
		LevelCollisionGroup = new FlxGroup();

		// Generate maps.
		var properties:Map<String,String> = new Map<String,String>();

		mapString = ('assets/levels/mapCSV_MCTest_LevelBase.csv').toString();
		image = ('assets/levels/terrain.png');
		properties = generateProperties( [null] );
		layerLevelBase = addTilemap(Assets.getText(mapString) ,image, 0.000, 0.000, 32, 32, 1.000, 1.000, false, 128, 1, properties, onAddCallback );

		mapString = ('assets/levels/mapCSV_MCTest_CollisionMap.csv').toString();
		image = ('assets/levels/terrain.png');
		properties = generateProperties( [null] );
		layerCollisionMap = addTilemap(Assets.getText(mapString) ,image, 0.000, 0.000, 32, 32, 1.000, 1.000, false, 1, 1, properties, onAddCallback );


		//Add layers to the master group in correct order.
	masterLayer.add(layerLevelBase);
	masterLayer.add(LevelCollisionGroup);
	masterLayer.add(SpritesGroup);
	masterLayer.add(layerCollisionMap);

		if ( addToStage )
			createObjects(onAddCallback, parentObject);

		boundsMinX = 0;
		boundsMinY = 0;
		boundsMaxX = 1024;
		boundsMaxY = 512;
		boundsMin = new FlxPoint(0, 0);
		boundsMax = new FlxPoint(1024, 512);
		bgColor = 0xff777777;
	}

	override public function createObjects(onAddCallback:Dynamic = null, parentObject:Dynamic = null):Void
	{
		addPathsForLayerLevelCollision(onAddCallback);
		addShapesForLayerSprites(onAddCallback);
		generateObjectLinks(onAddCallback);
		if ( parentObject != null )
			parentObject.add(masterLayer);
		else
			FlxG.state.add(masterLayer);
	}

		public function addPathsForLayerLevelCollision(onAddCallback:Dynamic = null):Void
		{
			var pathobj:PathData;

			pathobj = new PathData( [ new FlxPoint(1028.000, 514.000),
				new FlxPoint(1030.000, 99.000),
				new FlxPoint(450.000, 95.000),
				new FlxPoint(452.000, 128.000),
				new FlxPoint(386.000, 351.000),
				new FlxPoint(356.000, 415.000),
				new FlxPoint(256.000, 516.000) 
			], true, false, LevelCollisionGroup );
			paths.push(pathobj);
			callbackNewData( pathobj, onAddCallback, LevelCollisionGroup, generateProperties( [null] ), 1, 1 );

			pathobj = new PathData( [ { pos:new FlxPoint(59.090, 140.880), tan1:new FlxPoint(-73.450, 243.700), tan2:new FlxPoint(-(22.000), -(-73.000)) },
				{ pos:new FlxPoint(129.090, 220.870), tan1:new FlxPoint(27.000, -61.000), tan2:new FlxPoint(-(-12.140), -(27.430)) } 
			], true, false, LevelCollisionGroup );
			paths.push(pathobj);
			callbackNewData( pathobj, onAddCallback, LevelCollisionGroup, generateProperties( [null] ), 1, 1 );

		}

	public function addShapesForLayerSprites(onAddCallback:Dynamic = null):Void
	{
		var obj:Dynamic;

	}

	public function generateObjectLinks(onAddCallback:Dynamic = null):Void
	{
	}

}
