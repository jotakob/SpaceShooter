//Code generated with DAME and DeVZoO. http://www.dambots.com http://www.dev-zoo.net

package  ;

import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.group.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxPoint;
import flixel.tile.FlxTilemap;
import flash.utils.Dictionary;
import openfl.Assets;

class BaseLevel extends FlxGroup
{
	// The masterLayer contains every single object in this group making it easy to empty the level.
	public var masterLayer:FlxGroup;

	// This group contains all the tilemaps specified to use collisions.
	public var hitTilemaps:FlxGroup;
	// This group contains all the tilemaps.
	public var tilemaps:FlxGroup;

	public var boundsMinX:Int;
	public var boundsMinY:Int;
	public var boundsMaxX:Int;
	public var boundsMaxY:Int;

	public var boundsMin:FlxPoint;
	public var boundsMax:FlxPoint;
	public var bgColor:Int;
	public var paths:Array<Dynamic>;	// Array of PathData
	public var shapes:Array<Dynamic>;	//Array of ShapeData.
	
	public var triggers:FlxTypedGroup<Trigger> = new FlxTypedGroup<Trigger>();
	public var buttons:FlxTypedGroup<Button> = new FlxTypedGroup<Button>();
	
	public var layerWalls2:FlxTilemap;
	
	public static var linkedObjectDictionary:Array<Dynamic>;	// Array <Dynamic> instead of Dictionary

	public function new()
	{
		masterLayer = new FlxGroup();
		hitTilemaps = new FlxGroup();
		tilemaps = new FlxGroup();
		paths = new Array<Dynamic>();
		shapes = new Array<Dynamic>();
		linkedObjectDictionary = new Array<Dynamic>();
		
		super();
	}

	// Expects callback function to be callback(newobj:Dynamic,layer:FlxGroup,level:BaseLevel,properties:Array)
	public function createObjects(onAddCallback:Dynamic = null, parentObject:Dynamic = null):Void { }

	public function addTilemap( mapClass:String, imageClass:Class<Dynamic>, xpos:Float, ypos:Float, tileWidth:UInt, tileHeight:UInt, scrollX:Float, scrollY:Float, hits:Bool, collideIdx:UInt, drawIdx:UInt, properties:Map<String,String>, onAddCallback:Dynamic = null ):FlxTilemap
	{
		var map:FlxTilemap = new FlxTilemap();
		
		//converting the csv to an array and setting width and height of the tilemap since loading csv's doesn't work
		var tmpmap:Array<Int> = new Array<Int>();
		var rows:Array<String> = mapClass.split("\n");
		if (rows[rows.length - 1] == "")
		{
			rows.pop();
		}
		var tiles:Array<String> = new Array<String>();
		map.heightInTiles = rows.length;
		map.widthInTiles = rows[0].split(",").length;
		for (row in rows)
		{
			tiles = row.split(",");
			for (tile in tiles)
			{
				tmpmap.push(Std.parseInt(tile));
			}
		}
		
		map.loadMap( tmpmap, imageClass, tileWidth, tileHeight, FlxTilemap.OFF, 0, drawIdx, collideIdx);
		map.x = xpos;
		map.y = ypos;
		map.scrollFactor.x = scrollX;
		map.scrollFactor.y = scrollY;
		map.tileScaleHack = 1.0;
		
		
		if (FlxG.worldBounds.width < map.width)
			FlxG.worldBounds.width = map.width;
		if (FlxG.worldBounds.height < map.height)
			FlxG.worldBounds.height = map.height;
		/*FlxG.worldBounds.left = boundsMinX;
		FlxG.worldBounds.right = boundsMaxX;
		FlxG.worldBounds.top = boundsMinY;
		FlxG.worldBounds.bottom = boundsMaxY;*/
		
		
		if ( hits )
			hitTilemaps.add(map);			
		tilemaps.add(map);
		//if(onAddCallback != null)
			//onAddCallback(map, null, properties);
		add(map);
		return map;
	}

	public function addSpriteToLayer(obj:FlxSprite, type:Dynamic, layer:FlxGroup, xpos:Float, ypos:Float, angle:Float, scrollX:Float, scrollY:Float, flipped:Bool = false, scaleX:Float = 1, scaleY:Float = 1, properties:Map<String,String> = null, onAddCallback:Dynamic = null):FlxSprite
	{
		if ( obj == null )
		{
			obj = Type.createInstance(type, [xpos,ypos]);
		}
		obj.x += obj.offset.x;
		obj.y += obj.offset.y;
		obj.angle = angle;
		if ( scaleX != 1 || scaleY != 1 )
		{
			obj.scale.x = scaleX;
			obj.scale.y = scaleY;
			obj.width *= scaleX;
			obj.height *= scaleY;
			// Adjust the offset, in case it was already set.
			var newFrameWidth:Float = obj.frameWidth * scaleX;
			var newFrameHeight:Float = obj.frameHeight * scaleY;
			var hullOffsetX:Float = obj.offset.x * scaleX;
			var hullOffsetY:Float = obj.offset.y * scaleY;
			obj.offset.x -= (newFrameWidth- obj.frameWidth) / 2;
			obj.offset.y -= (newFrameHeight - obj.frameHeight) / 2;
		}
		if( obj.facing == FlxObject.RIGHT )
			obj.facing = flipped ? FlxObject.LEFT : FlxObject.RIGHT;
		obj.scrollFactor.x = scrollX;
		obj.scrollFactor.y = scrollY;
		layer.add(obj);
		callbackNewData(obj, onAddCallback, layer, properties, scrollX, scrollY, false);
		return obj;
	}

	public function addTextToLayer(textdata:TextData, layer:FlxGroup, scrollX:Float, scrollY:Float, embed:Bool, properties:Map<String,String>, onAddCallback:Dynamic ):FlxText
	{
		var textobj:FlxText = new FlxText(textdata.x, textdata.y, textdata.width, textdata.text, 8, embed);
		textobj.setFormat(textdata.fontName, textdata.size, textdata.color, textdata.alignment);
		addSpriteToLayer(textobj, FlxText, layer , 0, 0, textdata.angle, scrollX, scrollY, false, 1, 1, properties, onAddCallback );
		textobj.height = textdata.height;
		textobj.origin.x = textobj.width * 0.5;
		textobj.origin.y = textobj.height * 0.5;
		return textobj;
	}

	private function callbackNewData(data:Dynamic, onAddCallback:Dynamic, layer:FlxGroup, properties:Map<String,String>, scrollX:Float, scrollY:Float, needsReturnData:Bool = false):Dynamic
	{
		if(onAddCallback != null)
		{
			var newData:Dynamic = onAddCallback(data, layer, this, properties);
			if( newData != null )
				data = newData;
			else if ( needsReturnData )
				trace("Error: callback needs to return either the object passed in or a new object to set up links correctly.");
		}
		
		var newobj:Dynamic;
		switch (properties["type"])
		{
			case "button":
				newobj = new Button(data.x, data.y, data.width, data.height, this);
				buttons.add(newobj);
			case "trigger":
				newobj = new Trigger(data.x, data.y, data.width, data.height, this);
			case "pickup":
				newobj = new Pickup(data.x, data.y, data.width, data.height, this);
			default:
				newobj = new GameObject(data.x, data.y, data.width, data.height, this);
		}
		
		triggers.add(newobj);
		newobj.angle = data.angle;
		if (properties["settiles"] != null)
		{
			var settiles = new Array<Array<Int>>();
			var rows = properties["settiles"].split("|");
			for (row in rows)
			{
				var newTile = row.split(",");
				var newTileInt:Array<Int> = new Array<Int>();
				for (s in newTile)
				{newTileInt.push(Std.parseInt(s));}
				newTileInt.push(this.layerWalls2.getTile(newTileInt[0], newTileInt[1]));
				settiles.push(newTileInt);
			}
			trace(settiles);
			newobj.tilesToSet = settiles;
		}
		if (properties["triggeronce"] == "false")
		{
			newobj.repeatable = true;
			newobj.resetTime = properties["resetTimer"];
		}
		add(newobj);
		
		return data;
	}

	/**
	 * Removes the null value that is at the end of the argument array
	 * @param	args An array of properties	fromatted like { name:'foo', value:'foo'}
	*/
	private function generateProperties( args:Array<Dynamic> ):Map<String,String>
	{
		var properties = new Map<String,String>();
		if (args != null && args.length != 0)
		{
			var i:Int = args.length - 1;
			while(i-- != 0)
			{
				properties.set(Reflect.field(args[i], "name"), Reflect.field(args[i], "value"));
			}
		}
		trace(properties);
		return properties;
	}

	public function createLink( objectFrom:Dynamic, target:Dynamic, onAddCallback:Dynamic, properties:Map<String,String> ):Void
	{
		var link:ObjectLink = new ObjectLink( objectFrom, target );
		callbackNewData(link, onAddCallback, null, properties, objectFrom.scrollFactor.x, objectFrom.scrollFactor.y);
	}

	override public function destroy():Void
	{
		masterLayer.destroy();
		masterLayer = null;
		tilemaps = null;
		hitTilemaps = null;

		var i:UInt;
		for ( i in paths)
		{
			var pathobj:Dynamic = paths[i];
			if ( pathobj )
			{
				pathobj.destroy();
			}
		}
		paths = null;

		for ( i in shapes )
		{
			var shape:Dynamic = shapes[i];
			if ( shape )
			{
				shape.destroy();
			}
		}
		shapes = null;
	}
	
	public override function update()
	{
		super.update();
	}

	// List of null classes allows you to spawn levels dynamically from code using ClassReference.
	private static var level_MCTest:Level_MCTest;
	private static var level_Demo:Level_Demo;
}
