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
	private var charachterIcons:Array<FlxSprite> = new Array<FlxSprite>();
	
	public function new() 
	{
		super();
		Reg.currentState.add(this);
		sprBack = new FlxSprite().makeGraphic(FlxG.width, 70, 0x88000000);
		sprBack.y = FlxG.height - sprBack.height;
		sprBack.scrollFactor.set();
        add(sprBack);
		for (i in 0...(cast(Reg.currentState, PlayState).Players.length))
		{
			var healthBarOutlines = new FlxSprite().loadGraphic(AssetPaths.healthBarOutline__png,false, 126, 18);
			healthBarOutlines.scrollFactor.set();
			healthBarOutlines.origin.x = healthBarOutlines.origin.y = 0;
			healthBarOutlines.x = (FlxG.width / 20 - 3) + i * 150;
			healthBarOutlines.y = FlxG.height - healthBarOutlines.height / 2 - sprBack.height + 100 / 2;
			
			healthbars[i] = new FlxSprite().makeGraphic(1, 12, FlxColor.RED);
			healthbars[i].origin.x = healthbars[0].origin.y = 0;
			healthbars[i].scale.x = 48;
			healthbars[i].scrollFactor.set();
			healthbars[i].x = FlxG.width / 20 + i * 150;
			healthbars[i].y = FlxG.height - healthbars[i].height / 2 - sprBack.height + 100 / 2;
			
			if (i == 0)
			charachterIcons[i] = new FlxSprite().loadGraphic(AssetPaths.robot_Icon__png, 32, 32);
			if (i == 1)
			charachterIcons[i] = new FlxSprite().loadGraphic(AssetPaths.infiltrator_Icon__png, 32, 32);
			if (i == 2)
			charachterIcons[i] = new FlxSprite().loadGraphic(AssetPaths.soldier_Icon__png, 32, 32);
			if (i == 3)
			charachterIcons[i] = new FlxSprite().loadGraphic(AssetPaths.engineer_icon__png, 32, 32);
			
			charachterIcons[i].origin.x = charachterIcons[i].origin.y = 0;
			charachterIcons[i].scrollFactor.set();
			charachterIcons[i].x = FlxG.width / 20 + i * 150;
			charachterIcons[i].y = FlxG.height - charachterIcons[i].height / 2 - sprBack.height / 2 - 15;
			
			
			add(charachterIcons[i]);
			add(healthBarOutlines);
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