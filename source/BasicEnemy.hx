package ;
import haxe.Timer;
/**
 * ...
 * @author Luuk
 */
class BasicEnemy extends State
{
	private var timer:Int = 80;
	private var angle:Float = 0;
	public function new() { }
	public override function Enter(owner:Actor)
	
	{
		
	}
	public override function Execute(owner:Actor)
	{
		timer--;
		if (timer <= 0)
		
		{
			angle += 90;
			timer = 80;
		}
		
		
		owner.myMovementController.Move(owner.speed, angle);
		owner.myAnimationController.rotate(angle, true);
		owner.myAnimationController.rotate(angle, false);
	}
	public override function Exit(owner:Actor)
	{
		
	}


	
	
}