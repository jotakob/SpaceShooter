package ;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxObject;
import flixel.util.FlxAngle;
import flixel.FlxG;
import flixel.input.gamepad.FlxGamepad;
import flixel.group.FlxGroup;
import haxe.io.Input;


/**
 * The base for a player character. Derived from actor
 * @author Rutger
 */
class Player extends Actor
{
	public var _gamePad:FlxGamepad;
	public var playerNumber:Int;
	public var inputmanager:InputManager;
	public var isAiming = false;
	public var activeWeapon:Weapon;
	public var weapons:Array<Weapon> = new Array<Weapon>();
	
	public var skipFrames:Int = 2;
	
	/**
	 * 
	 * @param	X	Stanard Flixel parameter
	 * @param	Y	Stanard Flixel parameter
	 * @param	PlayerNumber	What playernumber this character has
	 * @param	GamePad		A reference to it's gamepad
	 * 
	 * the constructor of the player class sets the basic variable for the player like hp and speed
	 * furthermore it sets the animationcontroller parameter and adds an appropriate weapon absed on the playernumber
	 * It also sets all standard components like the movement controller and input manager.
	 */
	public function new(X:Float=0, Y:Float=0,?PlayerNumber:Int,?GamePad:FlxGamepad) 
	{
		super(X, Y);
		
		playerNumber = PlayerNumber;
		hp = 500;
		speed = 200;
		_gamePad = GamePad;
		myMovementController = (PlayerNumber == null)? null : new MovementController(this.x, this.y, this);
		
		switch(playerNumber)
		{
			case 0:
				width = height = 24;
				myAnimationController = new AnimationController(x, y, this, "robot");
				addWeapon(new ParticleWeapon(this, 0.25, 500, AssetPaths.bullet__png , AssetPaths.fire_particle__png, 1));
				hitSound = Reg.sounds[13];
			case 1:
				width = height = 16;
				myAnimationController = new AnimationController(x, y, this, "infiltrator");
				addWeapon(new Weapon(this, 0.2, 500, AssetPaths.bullet__png, AssetPaths.bullet__png, 25));
				hitSound = Reg.sounds[8];
			case 2:
				width = height = 24;
				myAnimationController = new AnimationController(x, y, this, "soldier");
				addWeapon(new Weapon(this, 0.03, 400, AssetPaths.bullet__png, AssetPaths.Potatoetile2__png, 20));
				hitSound = Reg.sounds[7];
				this.activeWeapon.explosiveBullet = true;
			case 3:
				width = height = 16;
				myAnimationController = new AnimationController(x, y, this, "engineer");
				addWeapon(new Weapon(this, 0.08, 700, AssetPaths.bullet__png, AssetPaths.bullet__png, 40));
				hitSound = Reg.sounds[11];
			default:
				myAnimationController = new AnimationController(x, y, this, "enemy");
				trace("using default animations");
		}
		
		
		
		inputmanager = new InputManager(this);
		myAnimationController.setAnimations("bot", [0,1,2,3]);
	}
	
	override public function update():Void 
	{
		super.update();
		if (inputmanager != null && myAnimationController != null && myMovementController != null)
		{
			inputmanager.update();
			
			try
			{
				activeWeapon.update();
			}
			catch (exception:Dynamic)
			{
				
			}
			
			//Preventing the player from moving offscreen
			//Skipped for the frst few frames after loading a level to allow the camera to adjust first
			if (!(skipFrames > 0))
			{
				if (this.x < FlxG.camera.scroll.x)
				{
					this.x = FlxG.camera.scroll.x;
				}
				if (this.x + this.width > FlxG.camera.scroll.x + FlxG.camera.width)
				{
					this.x  = FlxG.camera.scroll.x + FlxG.camera.width - this.width;
				}
				if (this.y < FlxG.camera.scroll.y)
				{
					this.y = FlxG.camera.scroll.y;
				}
				if (this.y + this.height > FlxG.camera.scroll.y + FlxG.camera.height)
				{
					this.y  = FlxG.camera.scroll.y + FlxG.camera.height - this.height;
				}
			}
			else
			{
				skipFrames--;
			}
		}
	}
	/**
	 * override functionality of the actor's die function which adds a tombstone on players death
	 */
	public override function die()
	{
		var tomb:FlxSprite = new FlxSprite().loadGraphic(AssetPaths.gravestone__png);
		tomb.x = this.x;
		tomb.y = this.y;
		Reg.currentState.add(tomb);
		super.die();
	}
	/**
	 * 
	 * @param	newWeapon	the weapon to be added
	 * 
	 * adds a weapon to the weapon list of the player and sets the added weapon as it's active weapon.
	 */
	public function addWeapon(newWeapon:Weapon)
	{
		weapons.push(newWeapon);
		activeWeapon = newWeapon;
	}
}