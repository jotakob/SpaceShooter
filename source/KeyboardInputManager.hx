package ;
import flixel.FlxG;

/**
 * Class that uses keyboard input instead of gamepad input
 * @author Jakob
 */
class KeyboardInputManager extends InputManager
{

	public function new(TempPlayer:Player) 
	{
		super(TempPlayer);
		
		player.isAiming = true;
	}
	
	public override function ManagePlayerInput():Void
	{
		//Moving
		var upDown:Int = 0;
		var leftRight:Int = 0;
		
		if (FlxG.keys.anyPressed(["W"]))
		{
			upDown--;
		}
		if (FlxG.keys.anyPressed(["S"]))
		{
			upDown++;
		}
		if (FlxG.keys.anyPressed(["A"]))
		{
			leftRight--;
		}
		if (FlxG.keys.anyPressed(["D"]))
		{
			leftRight++;
		}
		
		if (leftRight == 0)
		{
			if (upDown == 0)
			{
				leftAngle = -4000;
				player.moving = false;
			}
			else
			{
				leftAngle = upDown * 90;
			}
		}
		else
		{
			leftAngle = (leftRight - 1) * -90;
			
			if (upDown != 0)
			{	
				leftAngle = (leftAngle + 90) / 2 * upDown;
			}
		}
		
		if (leftRight != 0 || upDown != 0)
		{
			lastLeftAngle = leftAngle;
			player.myMovementController.Move(player.speed, leftAngle);
			player.myAnimationController.rotate(lastLeftAngle, false);
		}
		else
		{
			player.moving = false;
		}
		
		
		//Shooting
		upDown = 0;
		leftRight = 0;
		
		if (FlxG.keys.anyPressed(["UP", "I"]))
		{
			upDown--;
		}
		if (FlxG.keys.anyPressed(["DOWN", "K"]))
		{
			upDown++;
		}
		if (FlxG.keys.anyPressed(["LEFT", "J"]))
		{
			leftRight--;
		}
		if (FlxG.keys.anyPressed(["RIGHT", "L"]))
		{
			leftRight++;
		}
		
		if (leftRight == 0)
		{
			if (upDown == 0)
			{
				rightAngle = -4000;
			}
			else
			{
				rightAngle = upDown * 90;
			}
		}
		else
		{
			rightAngle = (leftRight - 1) * -90;
			
			if (upDown != 0)
			{	
				rightAngle = (rightAngle + 90) / 2 * upDown;
			}
		}
		
		if (rightAngle != -4000)
		{
			player.isAiming = true;
			lastRightAngle = rightAngle;
			timer = 100;
			player.activeWeapon.tryShooting();
		}
		else
		{
			timer--;
			
			if (Type.getClass(player.activeWeapon) == ParticleWeapon)
			{
				if (cast(player.activeWeapon, ParticleWeapon).emitter.on)
				{
					cast(player.activeWeapon, ParticleWeapon).stopEmitter();
				}
			}
		}
		
		if (timer <= 0)
		{
			player.isAiming = false;
		}
		if (player.isAiming || rightAngle != -4000)
		{
			player.myAnimationController.rotate(lastRightAngle, true);
		}
		else
		{
			player.myAnimationController.rotate(lastLeftAngle, true);
			lastRightAngle = leftAngle;
		}
		
		if (FlxG.keys.anyPressed(["E"]))
		{
			FlxG.overlap(player, Reg.currentLevel.buttons, interact);
		}
	}
}