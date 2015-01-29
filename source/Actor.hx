package ;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxSound;

/**
 * ...
 * @author Rutger Scholma
 * The base class of all characters in our game
 */
class Actor extends FlxObject
{
	public var speed:Int = 200;
	public var hp:Int;
	private var isAI:Bool;
	private var hitSound:FlxSound;
	
	public var myMovementController:MovementController;
	public var myAnimationController:AnimationController;
	public var myStateManager:AiStateController;
	public var moving = false;
	
	
	/**
	 * 
	 * Constructor class
	 */
	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		this.width = this.height = 24;
		myStateManager = new AiStateController(this);
		myMovementController = new MovementController(x, y, this);
	}
	
	public override function update():Void
	{
		myAnimationController.update();
		if (hp < 1)
		{
			die();
		}
		
		super.update();
	}
	/**
	 * 
	 * @param	damage  The integer that determins how much damage the actor receives
	 */
	public function receiveDamage(damage:Int)
	{
		this.myAnimationController.DamageColoring(30);
		hitSound.play();
		hp -= damage;
	}
	
	/**
	 * the functionality that kills an actor and remove it from the game
	 */
	function die():Void 
	{
		this.set_alive(false);
		this.exists = false;
		this.myAnimationController.topSprite.kill();
		this.myAnimationController.botSprite.kill();
		this.myAnimationController = null;
		if (Type.getClass(this) == Player)
		{
			cast(this, Player).inputmanager.kill();
			if (Type.getClass(cast(this, Player).activeWeapon) == ParticleWeapon)
			{
				cast(cast(this, Player).activeWeapon, ParticleWeapon).stopEmitter();
			}
			cast(this, Player).myMovementController.kill();
			cast(this, Player).activeWeapon = null;
			cast(this, Player).weapons = null;
		}
	}
	
}