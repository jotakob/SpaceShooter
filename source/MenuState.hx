package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxDestroyUtil;
using flixel.util.FlxSpriteUtil;
import openfl.Assets;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	private var _btnPlay:FlxButton;
	private var cursor:Cursor;
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		_btnPlay = new FlxButton(0, 0, "Play", clickPlay);
		_btnPlay.screenCenter();
		_btnPlay.onDown.sound = FlxG.sound.load("assets/sounds/click.ogg");
		_btnPlay.onUp.sound = FlxG.sound.load("assets/sounds/click.ogg");
		add(_btnPlay);
		
		loadAnimations();
		loadMusic();
		
		super.create();
	}
	
	private function loadAnimations()
	{
		for (row in Assets.getText(AssetPaths.characterAnimations__csv).split("\r\n"))
		{
			var animation:Array<String> = row.split(",");
			animation.reverse();
			var title:String = animation.pop();
			animation.reverse();
			Reg.characterAnimations.set(title, animation);
		}
	}
	
	private function loadMusic() 
	{
		Reg.music[0] = new FlxSound();
		Reg.music[0].loadStream("assets/music/ambient.ogg", true, false);
		Reg.music[0].volume = 1;
		
		Reg.music[1] = new FlxSound();
		Reg.music[1].loadStream("assets/music/drums.ogg", true, false);
		Reg.music[1].volume = 1;
		
		Reg.sounds[0] = new FlxSound();
		Reg.sounds[0].loadStream("assets/sounds/machine gun.ogg", false, false);
		Reg.sounds[0].volume = 1;
		
		Reg.sounds[1] = new FlxSound();
		Reg.sounds[1].loadStream("assets/sounds/laser.ogg", false, false);
		Reg.sounds[1].volume = 1;
		
		Reg.sounds[2] = new FlxSound();
		Reg.sounds[2].loadStream("assets/sounds/flamethrower.ogg", true, false);
		Reg.sounds[2].volume = 1;
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
		_btnPlay = FlxDestroyUtil.destroy(_btnPlay);
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
	}	
	
	private function clickPlay():Void
	{
		FlxG.switchState(new PlayState());
	}
	
}