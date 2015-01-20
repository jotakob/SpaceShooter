package ;
import flixel.FlxObject;
import flixel.FlxSprite;

/**
 * ...
 * @author ho
 */
class Actor extends FlxObject
{
	public var speed:Int = 200;
	public var hp:Int;
	private var isAI:Bool;
	public var myMovementController:MovementController;
	public var myAnimationController:AnimationController;
	public var myStateManager:AiStateController;
	public var moving = false;
	

	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		this.width = this.height = 32;
		myStateManager = new AiStateController(this);
		myMovementController = new MovementController(x, y, this);
	}
	public override function update():Void
	{
		myAnimationController.update();
		if (hp < 1)
		{
			this.kill();
		}
		
		super.update();
	}
	public function receiveDamage(damage:Int)
	{
		hp -= damage;
		trace(hp);
	}
	
}