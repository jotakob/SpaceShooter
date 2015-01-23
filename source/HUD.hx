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
        add(sprBack);
		for (i in 0...(cast(Reg.currentState, PlayState).Players.length))
		{
			healthbars[i] = new FlxSprite().makeGraphic(1, 12, FlxColor.RED);
			healthbars[i].origin.x = healthbars[0].origin.y = 0;
			healthbars[i].scale.x = 48;
			healthbars[i].scrollFactor.set();
			healthbars[i].x = FlxG.width / 20 + i * 150;
			healthbars[i].y = FlxG.height - healthbars[0].height / 2 - sprBack.height / 2;
			add(healthbars[i]);
		}
    }

    public override function update():Void
    {
		for (i in 0...(cast(Reg.currentState, PlayState).Players.length))
		{
			healthbars[i].scale.x = (cast(Reg.currentState, PlayState).Players.members[i].hp / 200) * 48;
		}
		super.update();
    }
}