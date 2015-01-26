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
	var endingScreen:FlxSprite = new FlxSprite();
	override public function create():Void
	{
		endingScreen.loadGraphic(AssetPaths.EndScreen__png);
		add(endingScreen); 
		super.create();
	}
	
}