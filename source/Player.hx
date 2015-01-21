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
		playerNumber = PlayerNumber;
		hp = 50;
		speed = 200;
		_gamePad = GamePad;
		myMovementController = (PlayerNumber == null)? null : new MovementController(this.x, this.y, this);
		
		switch(playerNumber)
		{
			case 0:
				myAnimationController = new RobotAnimationController (x, y, this);
			case 1:
				//myAnimationController = new InfiltratorAnimationController(x, y, this);
			//case 3:
				//myAnimationController = new EngineerAnimationController(x, y, this);
			//case 4:
				//myAnimationController = new SoldierAnimationController(x, y, this);
			default:
				myAnimationController = new AnimationController(x, y, this);
				trace("using default animations");
		}
		
		inputmanager = new InputManager(this);
		trace(playerNumber);
		myAnimationController.setAnimations("bot", [0,1,2,3]);
	}
	
	override public function update():Void 
	{
		super.update();
		inputmanager.update();
		
		try
		{
			activeWeapon.update();
		}
		catch (exception:Dynamic)
		{
			
		}
		if (this.x < FlxG.camera.scroll.x)
			this.x = FlxG.camera.scroll.x;
		if (this.x + this.width > FlxG.camera.scroll.x + FlxG.camera.width)
		{
			this.x  = FlxG.camera.scroll.x + FlxG.camera.width - this.width;
		}
		if (this.y < FlxG.camera.scroll.y)
			this.y = FlxG.camera.scroll.y;
		if (this.y + this.height > FlxG.camera.scroll.y + FlxG.camera.height)
		{
			this.y  = FlxG.camera.scroll.y + FlxG.camera.height - this.height;
		}
	}
	
	public function addWeapon(newWeapon:Weapon)
	{
		weapons.push(newWeapon);
		activeWeapon = newWeapon;
	}
}