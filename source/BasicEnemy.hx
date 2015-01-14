package ;
import haxe.Timer;
/**
 * ...
 * @author Luuk
 */
class BasicEnemy extends State
{
	private var timer:Int = 120;
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
			if (angle == 0)
			angle = 180;
			else if (angle == 180)
			angle = 0;
			
			timer = 120;
		}
		
		
		owner.myMovementController.Move(owner.speed, angle);
		owner.myAnimationController.rotate(angle, true);
		owner.myAnimationController.rotate(angle, false);
	}
	public override function Exit(owner:Actor)
	{
		
	}


	
	
}