package ;

/**
 * ...
 * @author JJM
 */
class Warp extends GameObject
{
	var target:String;

	public function new(X:Float=0, Y:Float=0, Width:Float=0, Height:Float=0, Level:BaseLevel) 
	{
		super(X, Y, Width, Height, Level);
	}
	
	public override function activate()
	{
		//if (cast(Reg.currentState, PlayState).Enemies.members.length < 4)
			cast(Reg.currentState, PlayState).changeLevel(target, 0);
	}
	
}