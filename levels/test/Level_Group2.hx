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
	class Level_Group2 extends BaseLevel
	{
		//Embedded media...

		//Properties


		public function new(addToStage:Bool = true, onAddCallback:Dynamic = null, parentObject:Dynamic = null)
		{
		super();
		var mapString:String;
		var image:Dynamic;
			// Generate maps.
		var properties:Array<Dynamic> = new Array<Dynamic>();


			//Add layers to the master group in correct order.

			if ( addToStage )
				createObjects(onAddCallback, parentObject);

			boundsMinX = 9999999;
			boundsMinY = 9999999;
			boundsMaxX = -9999999;
			boundsMaxY = -9999999;
			boundsMin = new FlxPoint(9999999, 9999999);
			boundsMax = new FlxPoint(-9999999, -9999999);
			bgColor = 0xff777777;
		}

		override public function createObjects(onAddCallback:Dynamic = null, parentObject:Dynamic = null):Void
		{
			generateObjectLinks(onAddCallback);
			if ( parentObject != null )
				parentObject.add(masterLayer);
			else
				FlxG.state.add(masterLayer);
		}

		public function generateObjectLinks(onAddCallback:Dynamic = null):Void
		{
		}

	}
