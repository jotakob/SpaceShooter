package ;
import flixel.FlxSprite;
import flixel.FlxState;
import openfl.Assets;
/**
 * ...
 * @author fgnbmghfsfghghjgffdsas
 */
class EndState extends FlxState
{
	var endingScreen:FlxSprite;
	override public function create():Void
	{
		endingScreen.loadGraphic(AssetPaths.EndScreen__png, false, 1280, 720);
		add(endingScreen); 
		super.create();
	}
	
}