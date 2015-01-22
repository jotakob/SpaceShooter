package ;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxAngle;
/**
 * ...
 * @author ...
 */
class MovementController extends FlxObject
{
	private var _owner:Actor;

	public function new(X:Float=0, Y:Float=0, owner:Actor) 
	{
		if (owner != null)
		{
			_owner = owner;
		}
		else
		trace("owner is null");
		
		super(X, Y);
		
	}
	override function update()
	{
		super.update();
	}
	public function Move(speed:Float,Angle:Float)
	{
		FlxAngle.rotatePoint(speed, 0, 0, 0, Angle, _owner.velocity);
		_owner.moving = true;
	}
	
}