package ;

import flixel.FlxObject;
import flixel.FlxG;
import flixel.input.gamepad.FlxGamepad;
import flixel.input.gamepad.XboxButtonID;
import haxe.Timer;

/**
 * ...
 * @author ho
 */
class InputManager extends FlxObject
{
	private var player:Player;
	
	private var deadZone:Float = 0.3;
	var leftAngle:Float = 0;
	public var rightAngle:Float = 0;
	var lastLeftAngle:Float = 0;
	public var lastRightAngle:Float = 0;
	var timer:Int = 100;
	
	var _LaxisX:Float;
	var _LaxisY:Float;
		
	var _RaxisX:Float;
	var _RaxisY:Float;
	
	var _RTrigger:Float;
	
	
	public function new(TempPlayer:Player) 
	{
		super();
		
		if (TempPlayer != null)
		{
			player = TempPlayer;
		}
		else
		trace("animationComponent is null");
		
		
		
	}
	
	override public function update():Void 
	{
		ManagePlayerInput();
		super.update();
	}
	
	public function ManagePlayerInput():Void
	{
		
		_LaxisX = player._gamePad.getXAxis(XboxButtonID.LEFT_ANALOGUE_X);
		_LaxisY = player._gamePad.getYAxis(XboxButtonID.LEFT_ANALOGUE_Y);
		
		_RTrigger = player._gamePad.getAxis(XboxButtonID.RIGHT_TRIGGER);
		
		// XXXX Currently broken! see fix below
		//_RaxisX = player._gamePad.getXAxis(XboxButtonID.RIGHT_ANALOGUE_X);
		//_RaxisY = player._gamePad.getYAxis(XboxButtonID.RIGHT_ANALOGUE_Y);
		
		_RaxisX = player._gamePad.getXAxis(3);
		_RaxisY = player._gamePad.getYAxis(4);
		
		
		if (Math.sqrt(Math.pow(_LaxisX, 2) + Math.pow(_LaxisY, 2)) < deadZone)
		{
			_LaxisX = 0;
			_LaxisY = 0;
		}
		if (Math.sqrt(Math.pow(_RaxisX, 2) + Math.pow(_RaxisY, 2)) < deadZone)
		{
			_RaxisX = 0;
			_RaxisY = 0;
		}
		rightAngle = Math.atan2(_RaxisY, _RaxisX);
		rightAngle = rightAngle * (180 / Math.PI);
		if (_RaxisX == 0 && _RaxisY == 0)
		rightAngle = -4000;
		
		leftAngle = Math.atan2(_LaxisY, _LaxisX);
		leftAngle = leftAngle * (180 / Math.PI);
		if (_LaxisX == 0 && _LaxisY == 0)
		leftAngle = -4000;
		
		if (_LaxisX != 0 || _LaxisY != 0)
		{
			lastLeftAngle = leftAngle;
			player.myMovementController.Move(player.speed, leftAngle);
			player.myAnimationController.rotate(lastLeftAngle, false);
		}
		else
		{
			player.moving = false;
		}
		if (_RTrigger > 0.1)
		{
			player.isAiming = true;
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
		if (rightAngle != -4000)
		{	
			player.isAiming = true;
			lastRightAngle = rightAngle;
			timer = 100;
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
	}
}
