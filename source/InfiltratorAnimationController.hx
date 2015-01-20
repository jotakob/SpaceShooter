package ;
import flixel.FlxSprite;
import flixel.FlxObject;
/**
 * ...
 * @author Luuk
 */
class InfiltratorAnimationController extends AnimationController

{
	public function new(X:Float=0, Y:Float=0,animationComponent:Actor) 
	{
		super(X, Y, animationComponent);
		spriteSheet = AssetPaths.infiltrator_spritesheet__png;
		
		trace(spriteSheet);
	
		_owner.drag.x = _owner.drag.y = 1600;
		
		botSprite.loadGraphic(spriteSheet, true, 32, 32);
		botSprite.drag.x = _owner.drag.y = 1600;
		botSprite.animation.add("lr",[1,2,1,0,3,4,3,0], 5, true);
		Reg.currentState.add(botSprite);
		
		topSprite.loadGraphic(spriteSheet, true, 32, 32);
		topSprite.drag.x = topSprite.drag.y = 1600;
		topSprite.animation.add("lr", [4,5], 12, false);
		Reg.currentState.add(topSprite);
			
		
	}
	
}
