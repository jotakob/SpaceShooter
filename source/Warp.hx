package ;
import flixel.FlxG;
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
		trace("warping");
		FlxG.camera.fade( 0xFF000000, 2, false, nextLevel);
	}
	private function nextLevel():Void
	{
		cast(Reg.currentState, PlayState).changeLevel(target, 0);
	}
}