package ;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.group.FlxTypedGroup;
using 	flixel.util.FlxSpriteUtil;

/**
 * ...
 * @author fgnbmghfsfghghjgffdsas
 */
class HUD extends FlxSprite
{
	private var sprBack:FlxSprite;
	private var players:FlxGroup;
	private var playerHealth:Array<Int>;
	private var healthbars:Array<FlxSprite>;
	
	public function new(Players:FlxGroup) 
	{
		super();
		players = Players;
		sprBack = new FlxSprite().makeGraphic(FlxG.width, 50, FlxColor.BLACK);
		sprBack.y = FlxG.height - sprBack.height;
		sprBack.scrollFactor.set();
		//healthbars[0] = new FlxSprite().makeGraphic(players[0].
        Reg.currentState.add(sprBack);
    }

    public function updateHUD():Void
    {
		
    }
}