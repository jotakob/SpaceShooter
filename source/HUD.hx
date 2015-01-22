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
class HUD extends FlxGroup
{
	private var sprBack:FlxSprite;
	private var healthbars:Array<FlxSprite> = new Array<FlxSprite>();
	
	public function new() 
	{
		super();
		Reg.currentState.add(this);
		sprBack = new FlxSprite().makeGraphic(FlxG.width, 50, FlxColor.BLACK);
		sprBack.y = FlxG.height - sprBack.height;
		sprBack.scrollFactor.set();
		healthbars[0] = new FlxSprite().makeGraphic(cast(Reg.currentState, PlayState).Players.members[0].hp, 20, FlxColor.RED);
		healthbars[0].scrollFactor.set();
        add(sprBack);
		add(healthbars[0]);
    }

    public function updateHUD():Void
    {
		
    }
}