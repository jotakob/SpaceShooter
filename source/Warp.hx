package ;
import flixel.FlxG;
/**
 * This is the class for warps, which are essentially triggers that load a new level
 * @author JJM
 */
class Warp extends GameObject
{
	var target:String;

	public function new(X:Float=0, Y:Float=0, Width:Float=0, Height:Float=0, Level:BaseLevel) 
	{
		super(X, Y, Width, Height, Level);
	}
	
	/**
	 * FadeOut into the next level
	 */
	public override function activate()
	{
		if (cast(Reg.currentState, PlayState).Enemies.members.length < 10)
			FlxG.camera.fade( 0xFF000000, 2, false, nextLevel);
	}
	
	/**
	 * Called by activate()
	 * Calls the changeLevel in the PlayState
	 */
	private function nextLevel():Void
	{
		cast(Reg.currentState, PlayState).changeLevel(target, 0);
	}
}