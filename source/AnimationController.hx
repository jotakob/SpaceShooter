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
	private var animationData:Array<String>;
	private var hitboxOffset:Int;
	private var isDamaged:Bool = false;
	private var damageTimer:Int = 90;
	
	public function new(X:Float=0, Y:Float=0,animationComponent:Actor,AnimationID:String) 
	{
		super(X, Y);
		animationData = Reg.characterAnimations[AnimationID];
		
		if (animationComponent != null)		
		{
			_owner = animationComponent;
		}
		else
		trace("animationComponent is null");
		
		_owner.drag.x = _owner.drag.y = 1600;
		
		botSprite.loadGraphic("assets/images/sprites/" + animationData[0], true, 32, 32);
		botSprite.drag.x = botSprite.drag.y = 1600;
		
		var botanimation:Array<Int> = new Array<Int>();
		for (i in 0...animationData[1].length)
		{
			botanimation.push(Std.parseInt(animationData[1].charAt(i)));
		}
		Reg.currentState.add(botSprite);
		trace(botanimation);
		botSprite.animation.add("lr",botanimation, 9, true);
		
		topSprite.loadGraphic("assets/images/sprites/" + animationData[0], true, 32, 32);
		topSprite.drag.x = topSprite.drag.y = 1600;
		
		var topanimation:Array<Int> = new Array<Int>();
		for (i in 0...animationData[2].length)
		{
			topanimation.push(Std.parseInt(animationData[2].charAt(i)));
		}
		
		topSprite.animation.add("lr", topanimation, 6, false);
		
		Reg.currentState.add(topSprite);
		
		hitboxOffset = Math.floor((32 - _owner.width) /2);
	}
	override public function update():Void
	{

		topSprite.y = _owner.y - hitboxOffset;
		topSprite.x = _owner.x - hitboxOffset;
		botSprite.y = _owner.y - hitboxOffset;
		botSprite.x = _owner.x - hitboxOffset;
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
			topSprite.animation.play("lr");
			if (move)
			{
				botSprite.animation.play("lr");
			}
	}
	public function DamageAnimation()
	{
		
		trace("doing damage animation");
		topSprite.setColorTransform(.5, .2, .8, 1, -200, 0, 0);
		botSprite.setColorTransform(.5, .2, .8, 1, -200, 0, 0);
	}
}
