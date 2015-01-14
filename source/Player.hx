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
	public var bulletGroup:FlxGroup = new FlxGroup();
	private var inputmanager:InputManager;
	
	public function new(X:Float=0, Y:Float=0,?PlayerNumber:Int,?GamePad:FlxGamepad) 
	{
		super(X, Y);
		hp = 50;
		speed = 200;
		_gamePad = GamePad;
		myMovementController = (PlayerNumber == null)? null : new MovementController(this.x, this.y, this);
		myAnimationController = new AnimationController(x, y, this, AssetPaths.player__png);
		playerNumber = PlayerNumber;
		inputmanager = new InputManager(this);
		trace(playerNumber);
		
		
		
	}
	
	override public function update():Void 
	{
		super.update();
		inputmanager.update();
		if (hp < 1)
		{
			
			this.kill();
		}
	}
	
	
}