package ;

import flixel.FlxObject;
import flixel.FlxG;
import flixel.input.gamepad.FlxGamepad;
import flixel.input.gamepad.XboxButtonID;
/**
 * ...
 * @author ho
 */
class InputManager extends FlxObject
{
	private var player:Player;
	private var deadZone:Float = 0.3;
	var lA:Float = 0;
	var rA:Float = 0;
	var _up:Bool = false;
	var _down:Bool = false;
	var _left:Bool = false;
	var _right:Bool = false;
		
	var _LaxisX:Float;
	var _LaxisY:Float;
		
	var _RaxisX:Float;
	var _RaxisY:Float;
	
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
		
		_RaxisX = player._gamePad.getAxis(XboxButtonID.RIGHT_ANALOGUE_X);
		_RaxisY = player._gamePad.getAxis(XboxButtonID.RIGHT_ANALOGUE_Y);
		
		if (_LaxisX > -deadZone && _LaxisX < deadZone)
		_LaxisX = 0;
		if (_LaxisY > -deadZone && _LaxisY < deadZone)
		_LaxisY = 0;
		
		rA = Math.atan2(_RaxisY, _RaxisX);
		rA = rA * (180 / Math.PI);
		
		lA = Math.atan2(_LaxisY, _LaxisX);
		lA = lA * (180 / Math.PI);
		
		if (_LaxisX != 0 || _LaxisY != 0)
		{
			if ((lA <= 45 && lA >= 0)|| (lA > -45 && lA <= 0))
			{
				_right = true;
				_up = false;
				_down = false;
				_left = false;
			}
			
			if (lA > 45 && lA <= 135)
			{
				_down = true;
				_left = false;
				_right = false;
				_up = false;
			}
			if (lA >= -180 && lA <= -135 || lA <= 180 && lA > 135)
			{
				_left = true;
				_up = false;
				_down = false;
				_right = false;
			}
			if (lA <= -45 && lA > -135)
			{
				trace("up is true");
				_up = true;
				_down = false;
				_left = false;
				_right = false;
			}
			if (_up || _down || _left || _right)
			{
				if (_up)
				{
					player.facing = FlxObject.UP;
					//lA = 270;	
				}
				else if (_down)
				{
					player.facing = FlxObject.DOWN;
					//lA = 90;
				}
				else if (_left)
				{
					player.facing = FlxObject.LEFT;
					//lA = 180;
				}
				else if (_right)
				{
					player.facing = FlxObject.RIGHT;
					//lA = 0;
				}
				if (player.myAnimationController != null)
				{
					player.myMovementController.Move(player.speed, lA);
					player.myAnimationController.Animate();
				}
			}
		}
		if (_RaxisX != 0 || _RaxisY != 0)
		{
				
				rA = Math.atan2(_RaxisY, _RaxisX);
				rA = rA * (180 / Math.PI);
				trace(rA);
				shoot();
		}
	}
	
	private function shoot():Void
	{
		var tempBullet:Bullet = new Bullet(0,0,rA);
		tempBullet.x = player.x;
		tempBullet.y = player.y;
		Reg.currentState.add(tempBullet);
		player.bulletGroup.add(tempBullet);
	}
}