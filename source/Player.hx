package ;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxObject;
import flixel.util.FlxAngle;
import flixel.FlxG;
import flixel.input.gamepad.FlxGamepad;
import flixel.input.gamepad.XboxButtonID;
import flixel.group.FlxGroup;
import haxe.io.Input;


/**
 * ...
 * @author ho
 */
class Player extends Actor
{
	public var _gamePad:FlxGamepad;
	private var playerNumber:Int;
	public var inputmanager:InputManager;
	public var isShooting = false;
	public var activeWeapon:Weapon;
	public var weapons:Array<Weapon> = new Array<Weapon>();
	
	//private var Input:InputManager;
	public function new(X:Float=0, Y:Float=0,?PlayerNumber:Int,?GamePad:FlxGamepad) 
	{
		super(X, Y);
		hp = 50;
		speed = 200;
		_gamePad = GamePad;
		myMovementController = (PlayerNumber == null)? null : new MovementController(this.x, this.y, this);
		myAnimationController = new AnimationController(x, y, this,AssetPaths.robot_sheet__png);
		playerNumber = PlayerNumber;
		inputmanager = new InputManager(this);
		trace(playerNumber);
		myAnimationController.setAnimations("bot", [0,1,2,3]);
	}
	
	override public function update():Void 
	{
		super.update();
		inputmanager.update();
		if (hp < 1)
		{
			
			this.kill();
		}
		try
		{
			activeWeapon.update();
		}
		catch (exception:Dynamic)
		{
			
		}
	}
	
	public function addWeapon(newWeapon:Weapon)
	{
		weapons.push(newWeapon);
		activeWeapon = newWeapon;
	}
}