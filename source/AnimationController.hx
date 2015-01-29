package ;

import flixel.FlxSprite;
import flixel.FlxObject;

/**
 * Used to load and display the actor's animations.
 * @author Rutger
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
	private var damageTimer:Int = 60;
	
	/**
	 * Creates the animation based on the data from the registry
	 * @param	X
	 * @param	Y
	 * @param	animationComponent The actor to whichthe anmiation belongs
	 * @param	AnimationID		The name of the animation in the animation registry/csv file
	 * @author Rutger	For the basic animation code
	 * @author Jakob	For loading the animation details from the registry
	 */
	public function new(X:Float=0, Y:Float=0, animationComponent:Actor, AnimationID:String) 
	{
		super(X, Y);
		
		//Loads the animation data from the registry. AnimationData contains spritesheet filepath and frame ordering for both sprites
		animationData = Reg.characterAnimations[AnimationID];
		
		if (animationComponent != null)		
		{
			_owner = animationComponent;
		}
		else
		{
			trace("animationComponent is null");
		}
		
		_owner.drag.x = _owner.drag.y = 1600;
		
		//bot sprite
		botSprite.loadGraphic("assets/images/sprites/" + animationData[0], true, 32, 32);
		botSprite.drag.x = botSprite.drag.y = 1600;
		
		var botanimation:Array<Int> = new Array<Int>();
		for (i in 0...animationData[1].length)
		{
			botanimation.push(Std.parseInt(animationData[1].charAt(i)));
		}
		botSprite.animation.add("lr",botanimation, 9, true);
		
		//top sprite
		topSprite.loadGraphic("assets/images/sprites/" + animationData[0], true, 32, 32);
		topSprite.drag.x = topSprite.drag.y = 1600;
		
		var topanimation:Array<Int> = new Array<Int>();
		for (i in 0...animationData[2].length)
		{
			topanimation.push(Std.parseInt(animationData[2].charAt(i)));
		}
		
		topSprite.animation.add("lr", topanimation, 6, false);
		
		//adding to stages
		if (Type.getClass(_owner) == Player)
		{
			cast(Reg.currentState, PlayState).PlayerStuff.add(botSprite);
			cast(Reg.currentState, PlayState).PlayerStuff.add(topSprite);
		}
		else
		{
			Reg.currentState.add(botSprite);
			Reg.currentState.add(topSprite);
		}
		
		hitboxOffset = Math.floor((32 - _owner.width) /2);
	}
	
	override public function update():Void
	{

		topSprite.y = _owner.y - hitboxOffset;
		topSprite.x = _owner.x - hitboxOffset;
		botSprite.y = _owner.y - hitboxOffset;
		botSprite.x = _owner.x - hitboxOffset;
		Animate(_owner.moving);
		if (damageTimer > 0)
		{
			damageTimer --;
		}
		if (damageTimer <= 0)
		{
			DamageColoringReset();
		}
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
	
	public function DamageColoring(timer:Int = 60)
	{
		damageTimer = timer;
		topSprite.setColorTransform(1, .2, .2, 1, 255, 0, 0);
		botSprite.setColorTransform(1, .2, .2, 1, 255, 0, 0);
	}
	
	public function DamageColoringReset()
	{
		topSprite.setColorTransform();
		botSprite.setColorTransform();
	}
}
