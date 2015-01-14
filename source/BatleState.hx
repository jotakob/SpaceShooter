package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
/**
 * ...
 * @author ...
 */
class BatleState extends FlxState
{
	private var _btnCards:FlxButton;
	private var _card:Card;
	
	override public function create():Void
	{
		_btnCards = new FlxButton(0, 0, "Cards", clickCards);
		add(_btnCards);
		super.create();
	}
	
	private function clickCards():Void
	{
		_card = new Card();
		add(_card);
	}
}