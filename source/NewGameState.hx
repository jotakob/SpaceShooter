package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxSpriteUtil;
import flixel.input.gamepad.FlxGamepad;
import flixel.input.gamepad.XboxButtonID;

/**
 * Screen to be used for character selection in the future.
 * Currently not used.
 * @author Rutger
*/
class NewGameState extends FlxState
{
	private var _gamePads:Array<FlxGamepad> = new Array();
	
	override public function create():Void
	{
		for (i in 0...FlxG.gamepads.getActiveGamepads().length)
		{
			if (_gamePads.indexOf(FlxG.gamepads.getActiveGamepads()[i]) >= 0)
			{
				break;
			}
			_gamePads.push(FlxG.gamepads.getActiveGamepads()[i]);
			add(new Player(240, 160, i, FlxG.gamepads.getActiveGamepads()[i]));
			trace("added");
		}
		
		add(new DrawSprite(FlxG.width / 3, FlxG.height /3,"player"));
		add(new DrawSprite((FlxG.width / 3) * 2, FlxG.height /3,"player"));
		add(new DrawSprite(FlxG.width / 3, (FlxG.height /3)*2,"player"));
		add(new DrawSprite((FlxG.width / 3) * 2, (FlxG.height / 3) * 2, "player"));
		
		add(new DrawSprite(FlxG.width / 3, FlxG.height /3 - 50,"xboxButtons/a_button"));
		add(new DrawSprite((FlxG.width / 3) * 2, FlxG.height /3 - 50,"xboxButtons/b_button"));
		add(new DrawSprite(FlxG.width / 3, (FlxG.height /3)*2 - 50,"xboxButtons/x_button"));
		add(new DrawSprite((FlxG.width / 3) * 2, (FlxG.height / 3) * 2 - 50, "xboxButtons/y_button"));
		
		super.create();
	}
	override public function destroy():Void
	{
		super.destroy();
	}
	override public function update():Void
	{
		super.update();
	}	
}
/*
			var tempCursor:Cursor = new Cursor((i + 1) * 150, 50);
			add(tempCursor);
			
					add(new Player(240, 160, i, FlxG.gamepads.getActiveGamepads()[i], tempCursor));
					
					
					
					
					
					
					
					*/