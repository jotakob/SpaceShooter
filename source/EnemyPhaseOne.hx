package ;

/**
 * ...
 * @author fgnbmghfsfghghjgffdsas
 */
class EnemyPhaseOne extends State
{
	public function new (){}
	public override function Enter(owner:Actor) 
	{
		
	}
	
	public override function Execute(owner:Actor) 
	{
		owner.myMovementController.Move(owner.speed, 90);
	}
	
	public override function Exit(owner:Actor) 
	{
		
	}
	
}