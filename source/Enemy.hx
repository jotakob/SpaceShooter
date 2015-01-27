package ;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxObject;
import flixel.util.FlxAngle;
import flixel.FlxG;
/**
 * ...
 * @author ho
 */
class Enemy extends Actor
{

	public function new(X:Float=0, Y:Float=0) 
	{ 
		super(X, Y);
		isAI = true;
		hitSound = Reg.sounds[1];
		SetGameState();
		hp = 200;
		myAnimationController = new AnimationController(x, y, this, "enemy1");
		
		
	}
	override public function update():Void 
	{
		myStateManager.Execute();
		super.update();
	}
	
	public function SetGameState()
	{
		myStateManager.ChangeState(new BasicEnemy()); 
	}
}