package ;

import flixel.FlxObject;
import flixel.system.FlxSound;
import haxe.Timer;

/**
 * Buttons differ from triggers only by having a default activation sound and being put in a different group upon creation,
 * making them not trigger based on collision, but only when the 'A' button is also pressed.
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