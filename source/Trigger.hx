package ;

/**
 * ...
 * @author JJM
 */
class Trigger extends GameObject
{

	public function new(X:Float=0, Y:Float=0, Width:Float=0, Height:Float=0, Level:BaseLevel) 
	{
		super(X, Y, Width, Height, Level);
		
	}
	
	public override function onTrigger(actor:Actor)
	{
		
	}
	
}