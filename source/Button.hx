package ;

import flixel.FlxObject;
import haxe.Timer;

/**
 * ...
 * @author JJM
 */
class Button extends GameObject
{
	

	public function new(X:Float=0, Y:Float=0, Width:Float=0, Height:Float=0, Level:BaseLevel)
	{
		super(X, Y, Width, Height, Level);
		
	}
	
	public function onPress(player:Player)
	{
		if (!pressed)
			Reg.sounds[3].play();
		pressed = true;
		setTiles(tilesToSet);
		if (repeatable)
		{
			Timer.delay(deactivate, resetTime);
		}
	}
}