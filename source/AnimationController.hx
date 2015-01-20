package ;

import flixel.FlxSprite;
import flixel.FlxObject;

/**
 * ...
 * @author ho
 */
class AnimationController extends FlxSprite
{
	private var _owner:Actor;
	public var spriteSheet:String;
	public var botSprite:FlxSprite = new FlxSprite();
	public var topSprite:FlxSprite = new FlxSprite();
	public function new(X:Float=0, Y:Float=0,animationComponent:Actor) 
	{
		super(X, Y);
		
		if (animationComponent != null)		
		{
			_owner = animationComponent;
		}
		else
		trace("animationComponent is null");
		trace(AssetPaths.robot_sheet__png);
	
		_owner.drag.x = _owner.drag.y = 1600;
		
		botSprite.loadGraphic(AssetPaths.enemy_spritesheet__png, true, 32, 32);
		botSprite.drag.x = _owner.drag.y = 1600;
		botSprite.animation.add("lr",[1,2,1,0,3,4,3,0], 5, true);
		Reg.currentState.add(botSprite);
		
		topSprite.loadGraphic(AssetPaths.enemy_spritesheet__png, true, 32, 32);
		topSprite.drag.x = topSprite.drag.y = 1600;
		topSprite.animation.add("lr", [4,5], 12, false);
		Reg.currentState.add(topSprite);
		
		//CODEBLOCK FOR INFILTRATOR ANIMATION!
		
		/*trace(AssetPaths.robot_sheet__png);
	
		_owner.drag.x = _owner.drag.y = 1600;
		
		botSprite.loadGraphic(AssetPaths.infiltrator_spritesheet__png, true, 32, 32);
		botSprite.drag.x = _owner.drag.y = 1600;
		botSprite.animation.add("lr",[1,2,1,0,3,4,3,0], 5, true);
		Reg.currentState.add(botSprite);
		
		topSprite.loadGraphic(AssetPaths.infiltrator_spritesheet__png, true, 32, 32);
		topSprite.drag.x = topSprite.drag.y = 1600;
		topSprite.animation.add("lr", [4], 12, false);
		Reg.currentState.add(topSprite);*/
		
		
	}
	override public function update():Void
	{
		topSprite.y = _owner.y;
		topSprite.x = _owner.x;
		botSprite.y = _owner.y;
		botSprite.x = _owner.x;
		Animate(_owner.moving);
		super.update();
		
	}
	public function rotate(angle:Float,top:Bool)
	{
		if (top)
		topSprite.angle = angle - 90;
		else
		botSprite.angle = angle - 90;
	}
	
	public function setAnimations(animationName:String,animationFrames:Array<Int>)
	{
		topSprite.animation.add(animationName, animationFrames, 12);
	}
	public function Animate(move:Bool = false)
	{
		/*
		if ((_owner.velocity.x != 0 || _owner.velocity.y != 0) && _owner.touching == FlxObject.NONE) 
		{
			
			switch(_owner.facing)
			{
			case FlxObject.LEFT, FlxObject.RIGHT:
				//_owner.animation.play("lr");
				topSprite.animation.play("lr");
			case FlxObject.UP:
				_owner.animation.play("u");
			case FlxObject.DOWN:
				_owner.animation.play("d");
			}
			*/
			topSprite.animation.play("lr");
			if (move)
			botSprite.animation.play("bot");
		//}
	}
	
}