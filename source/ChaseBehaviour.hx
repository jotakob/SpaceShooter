package ;

import flixel.util.FlxPoint;
import flixel.util.FlxVelocity;
import flixel.FlxSprite;
/**
 * ...
 * @author fgnbmghfsfghghjgffdsas
 */
class ChaseBehaviour extends State
{
	private var DeltaY:Float;
	private var DeltaX:Float;
	private var Angle:Float;
	private var distance:Float;
	
	private var _player:Player;
	public function new (player:Player)
	{
		_player = player;
	}

	public override function Enter(owner:Actor) 
	{
		
	}
	
	public override function Execute(owner:Actor) 
	{
		DeltaY = _player.y - owner.y;
		DeltaX = _player.x - owner.x;
		Angle = Math.atan2(DeltaY, DeltaX) * 180 / Math.PI;
		distance = Math.sqrt(Math.pow(_player.x - owner.x, 2) + Math.pow(_player.y - owner.y, 2));
		if (distance > 220)
		{
			owner.myStateManager.ChangeState(new BasicEnemy());
		}
		
		owner.myAnimationController.rotate(Angle, true);
		owner.myAnimationController.rotate(Angle, false);	
		owner.myMovementController.Move(owner.speed / 4 * 3, Angle);
	}
	
	public override function Exit(owner:Actor) 
	{
		
	}
}