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
	public var topSprite:FlxSprite = new FlxSprite();
	public function new(X:Float=0, Y:Float=0,animationComponent:Actor,SpriteSheet:String) 
	{
		super(X, Y);
		
		if (animationComponent != null)		
		{
			_owner = animationComponent;
		}
		else
		trace("animationComponent is null");
		trace(AssetPaths.robot_sheet__png);
		topSprite.loadGraphic(AssetPaths.robot_sheet__png, true, 32, 32);
		topSprite.angle = 100;
		topSprite.drag.x = topSprite.drag.y = 1600;
		topSprite.animation.add("lr", [4, 5], 12, false);
		Reg.currentState.add(topSprite);
		spriteSheet = SpriteSheet;
		topSprite.x = this.x;
		topSprite.y = this.y;
		_owner.facing = FlxObject.LEFT;
		_owner.drag.x = _owner.drag.y = 1600;
		_owner.loadGraphic(spriteSheet, true, 16, 16);
		_owner.setFacingFlip(FlxObject.LEFT, false, false);
		_owner.setFacingFlip(FlxObject.RIGHT, true, false);
		_owner.animation.add("lr", [3, 4, 3, 5], 6, false);
		_owner.animation.add("u", [6, 7, 6, 8], 6, false);
		_owner.animation.add("d", [0, 1, 0, 2], 6, false);
		
	}
	override public function update():Void
	{
		topSprite.y = _owner.y;
		topSprite.x = _owner.x;
		trace("idhgfldfjofk");
		super.update();
		
	}
	public function setAnimations(animationName:String,animationFrames:Array<Int>)
	{
	_owner.animation.add(animationName, animationFrames, 12);
	}
	public function Animate()
	{
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
		}
	}
	
}