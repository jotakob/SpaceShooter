package ;

import flixel.FlxObject;

/**
 * ...
 * @author JJM
 */
class GameObject extends FlxObject
{
	public var repeatable:Bool = false;
	public var wasTriggered:Bool = false;
	public var resetTime = 1;
	public var tilesToSet:Array<Array<Int>>;
	private var level:BaseLevel;

	public function new(X:Float=0, Y:Float=0, Width:Float=0, Height:Float=0, Level:BaseLevel) 
	{
		super(X, Y, Width, Height);
		level = Level;
		
	}
	
	public function onTrigger(trigger:Actor)
	{
		
	}
	
	private function setTiles(tilesToSet:Array<Array<Int>>)
	{
		for (i in 0...tilesToSet.length)
		{
			level.layerWalls2.setTile(tilesToSet[i][0], tilesToSet[i][1], tilesToSet[i][2]);
		}
	}
	
	private function deactivate()
	{
		for (i in 0...tilesToSet.length)
		{
			level.layerWalls2.setTile(tilesToSet[i][0], tilesToSet[i][1], tilesToSet[i][3]);
		}
	}
}