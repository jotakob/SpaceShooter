package ;
import flixel.FlxSprite;
import flixel.FlxState;
using flixel.util.FlxSpriteUtil;

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
		endingScreen.centerOrigin();
		endingScreen.screenCenter();
		add(endingScreen); 
		super.create();
	}
	
}