package ;

import flixel.FlxObject;

/**
 * ...
 * @author JJM
 */
class GameObject extends FlxObject
{
	public var triggerOnce:Bool = true;
	public var wasTriggered:Bool = false;
	public var tilesToSet:String;
	private var level:BaseLevel;

	public function new(X:Float=0, Y:Float=0, Width:Float=0, Height:Float=0, Level:BaseLevel) 
	{
		super(X, Y, Width, Height);
		level = Level;
		
	}
	
	public function onTrigger(trigger:Actor)
	{
		
	}
	
	private function setTiles(tilesToSet:String)
	{
		var rows = tilesToSet.split("|");
		for (row in rows)
		{
			var newTile = row.split(",");
			level.layerWalls2.setTile(Std.parseInt(newTile[0]), Std.parseInt(newTile[1]), Std.parseInt(newTile[2]));
		}
	}
	
}