package ;
import flixel.FlxObject;
import flixel.FlxSprite;

/**
 * ...
 * @author ho
 */
class Actor extends FlxSprite
{
	public var speed:Int = 200;
	public var hp:Int;
	private var isAI:Bool;
	public var myMovementController:MovementController;
	public var myAnimationController:AnimationController;
	public var myStateManager:AiStateController;
	

	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		myStateManager = new AiStateController(this);
		myMovementController = new MovementController(x, y, this);
	}
	
}