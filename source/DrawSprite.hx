package ;

import flixel.FlxSprite;

/**
 * ...
 * @author ...
 */
class DrawSprite extends FlxSprite
{

	public function new(X:Float=0, Y:Float=0,path:String) 
	{
		super(X, Y);
		loadGraphic("assets/images/" + path + ".png");
	}
	
}