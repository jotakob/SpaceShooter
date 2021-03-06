package ;

import flixel.FlxObject;
import flixel.FlxG;
import flixel.input.gamepad.FlxGamepad;
import flixel.input.gamepad.XboxButtonID;
import haxe.Timer;

/**
 * This class manages the gamepad input for a player, executing the appropriate actions
 * @author Rutger
 */
class InputManager extends FlxObject
{
	//Set Weird Controller Mapping HERE
	private var weirdmapping:Bool = true;
	//IT'S IMPORTANT
	
	
	private var player:Player;
	
	private var deadZone:Float = 0.3;
	var leftAngle:Float = 0;
	public var rightAngle:Float = 0;
	var lastLeftAngle:Float = 0;
	public var lastRightAngle:Float = 0;
	var timer:Int = 100;
	
	private var fixedXboxButtonIDs:Map<String,Int> = new Map<String,Int>();
	
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
		{
			trace("player is null");
		}
		if (weirdmapping)
		{
			fixedXboxButtonIDs.set("A", 0);
			fixedXboxButtonIDs.set("B", 1);
			fixedXboxButtonIDs.set("X", 2);
			fixedXboxButtonIDs.set("Y", 3);
			fixedXboxButtonIDs.set("DPAD_UP", XboxButtonID.DPAD_UP);
			fixedXboxButtonIDs.set("DPAD_DOWN", XboxButtonID.DPAD_DOWN);
			fixedXboxButtonIDs.set("DPAD_LEFT", XboxButtonID.DPAD_LEFT);
			fixedXboxButtonIDs.set("DPAD_RIGHT", XboxButtonID.DPAD_RIGHT);
			fixedXboxButtonIDs.set("START", 7);
			fixedXboxButtonIDs.set("BACK", 6);
			fixedXboxButtonIDs.set("LB", 4);
			fixedXboxButtonIDs.set("RB", 5);
			fixedXboxButtonIDs.set("LEFT_ANALOGUE_X", 0);
			fixedXboxButtonIDs.set("LEFT_ANALOGUE_Y", 1);
			fixedXboxButtonIDs.set("RIGHT_ANALOGUE_X", 3);
			fixedXboxButtonIDs.set("RIGHT_ANALOGUE_Y", 4);
			fixedXboxButtonIDs.set("LEFT_TRIGGER", 2);
			fixedXboxButtonIDs.set("RIGHT_TRIGGER", 5);
		}
		else
		{
			fixedXboxButtonIDs.set("A", XboxButtonID.A);
			fixedXboxButtonIDs.set("B", XboxButtonID.B);
			fixedXboxButtonIDs.set("X", XboxButtonID.X);
			fixedXboxButtonIDs.set("Y", XboxButtonID.Y);
			fixedXboxButtonIDs.set("DPAD_UP", XboxButtonID.DPAD_UP);
			fixedXboxButtonIDs.set("DPAD_DOWN", XboxButtonID.DPAD_DOWN);
			fixedXboxButtonIDs.set("DPAD_LEFT", XboxButtonID.DPAD_LEFT);
			fixedXboxButtonIDs.set("DPAD_RIGHT", XboxButtonID.DPAD_RIGHT);
			fixedXboxButtonIDs.set("START", XboxButtonID.START);
			fixedXboxButtonIDs.set("BACK", XboxButtonID.BACK);
			fixedXboxButtonIDs.set("LB", XboxButtonID.LB);
			fixedXboxButtonIDs.set("RB", XboxButtonID.RB);
			fixedXboxButtonIDs.set("LEFT_ANALOGUE_X", XboxButtonID.LEFT_ANALOGUE_X);
			fixedXboxButtonIDs.set("LEFT_ANALOGUE_Y", XboxButtonID.LEFT_ANALOGUE_Y);
			fixedXboxButtonIDs.set("RIGHT_ANALOGUE_X", XboxButtonID.RIGHT_ANALOGUE_X);
			fixedXboxButtonIDs.set("RIGHT_ANALOGUE_Y", XboxButtonID.RIGHT_ANALOGUE_Y);
			fixedXboxButtonIDs.set("LEFT_TRIGGER", XboxButtonID.LEFT_TRIGGER);
			fixedXboxButtonIDs.set("RIGHT_TRIGGER", XboxButtonID.RIGHT_TRIGGER);
		}
		
	}
	
	override public function update():Void 
	{
		ManagePlayerInput();
		super.update();
	}
	
	public function ManagePlayerInput():Void
	{
		
		_LaxisX = player._gamePad.getXAxis(fixedXboxButtonIDs["LEFT_ANALOGUE_X"]);
		_LaxisY = player._gamePad.getYAxis(fixedXboxButtonIDs["LEFT_ANALOGUE_Y"]);
		
		_RTrigger = player._gamePad.getAxis(fixedXboxButtonIDs["RIGHT_TRIGGER"]);

		_RaxisX = player._gamePad.getXAxis(fixedXboxButtonIDs["RIGHT_ANALOGUE_X"]);
		_RaxisY = player._gamePad.getYAxis(fixedXboxButtonIDs["RIGHT_ANALOGUE_Y"]);
		
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
		
		//Buttons
		if (player._gamePad.pressed(fixedXboxButtonIDs["A"]))
		{
			FlxG.overlap(player, Reg.currentLevel.buttons, interact);
		}
	}
	
	/**
	 * Callback function for player interactions with gameobjects
	 * @author Jakob
	 */
	private function interact(obj1:FlxObject, obj2:FlxObject)
	{
		cast(obj2, Button).trigger(cast(obj1, Player));
	}
}
