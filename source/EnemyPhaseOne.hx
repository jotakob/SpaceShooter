package ;

/**
 * Enemy AI, currently not used
 * @author Rutger
 */
class EnemyPhaseOne extends State
{
	private var timer:Int = Std.random(20) + 60;
	private var angle:Float;
	private var distance:Float;
	
	public function new (){}
	public override function Enter(owner:Actor) 
	{
		
	}
	
	public override function Execute(owner:Actor) 
	{
		angle = owner.angle;
		timer--;
		if (timer <= 0)
		
		{
			angle += Std.random(20) * 5 + 45;
			timer = Std.random(50)+40;
		}
		
		owner.angle = angle;
		owner.myMovementController.Move(owner.speed, angle);
		owner.myAnimationController.rotate(angle, true);
		owner.myAnimationController.rotate(angle, false);
		for (i in 0...cast(Reg.currentState, PlayState).Players.members.length)
		{
			distance = Math.sqrt(
			Math.pow(cast(Reg.currentState, PlayState).Players.members[i].x - owner.x, 2) + 
			Math.pow(cast(Reg.currentState, PlayState).Players.members[i].y - owner.y, 2)
			);
			if (distance < 200)
			{
				owner.myStateManager.ChangeState(new ChaseBehaviour(cast(Reg.currentState, PlayState).Players.members[i]));
			}
		}
	}
	
	public override function Exit(owner:Actor) 
	{
		
	}
	
}