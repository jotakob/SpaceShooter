package ;

import flixel.FlxObject;
import flixel.system.FlxSound;
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
		
		sound = Reg.sounds[3];
	}
	
}