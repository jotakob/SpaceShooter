package ;

import flixel.FlxObject;
import haxe.Timer;

/**
 * ...
 * @author JJM
 */
class Button extends GameObject
{
	public var pressed:Bool = false;
	

	public function new(X:Float=0, Y:Float=0, Width:Float=0, Height:Float=0, Level:BaseLevel)
	{
		super(X, Y, Width, Height, Level);
		
	}
	
	public function onPress(player:Player)
	{
		setTiles(tilesToSet);
		if (repeatable)
		{
			trace("calling resetter");
			Timer.delay(deactivate, resetTime);
		}
	}
}