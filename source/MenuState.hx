package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxDestroyUtil;
import flixel.input.gamepad.XboxButtonID;
using flixel.util.FlxSpriteUtil;
import openfl.Assets;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	private var background:FlxSprite = new FlxSprite();
	private var background2:FlxSprite = new FlxSprite();
	private var _btnPlay:FlxButton;
	private var cursor:Cursor;
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		background.loadGraphic(AssetPaths.spaceBackground__png);
		background2.loadGraphic(AssetPaths.spaceBackground__png);
		background2.x = background2.width;
		add(background);
		add(background2);
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
		
		Reg.sounds[3] = new FlxSound();
		Reg.sounds[3].loadStream("assets/sounds/click.ogg", false, false);
		Reg.sounds[3].volume = 1;
		
		Reg.sounds[4] = new FlxSound();
		Reg.sounds[4].loadStream("assets/sounds/missile_shoot.ogg", false, false);
		Reg.sounds[4].volume = 1;
		
		Reg.sounds[5] = new FlxSound();
		Reg.sounds[5].loadStream("assets/sounds/missile_explode.ogg", false, false);
		Reg.sounds[5].volume = 1;
		
		Reg.sounds[6] = new FlxSound();
		Reg.sounds[6].loadStream(AssetPaths.man1__ogg, false, false);
		Reg.sounds[6].volume = 1;
		
		Reg.sounds[7] = new FlxSound();
		Reg.sounds[7].loadStream(AssetPaths.man2__ogg, false, false);
		Reg.sounds[7].volume = 1;
		
		Reg.sounds[8] = new FlxSound();
		Reg.sounds[8].loadStream(AssetPaths.man3__ogg, false, false);
		Reg.sounds[8].volume = 1;
		
		Reg.sounds[9] = new FlxSound();
		Reg.sounds[9].loadStream(AssetPaths.man4__ogg, false, false);
		Reg.sounds[9].volume = 1;
		
		Reg.sounds[10] = new FlxSound();
		Reg.sounds[10].loadStream(AssetPaths.man5__ogg, false, false);
		Reg.sounds[10].volume = 1;
		
		Reg.sounds[11] = new FlxSound();
		Reg.sounds[11].loadStream(AssetPaths.woman1__ogg, false, false);
		Reg.sounds[11].volume = 1;
		
		Reg.sounds[12] = new FlxSound();
		Reg.sounds[12].loadStream(AssetPaths.woman2__ogg, false, false);
		Reg.sounds[12].volume = 1;
		
		Reg.sounds[13] = new FlxSound();
		Reg.sounds[13].loadStream(AssetPaths.robot_hit__ogg, false, false);
		Reg.sounds[13].volume = 1;
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
		background.x = background.x - 1;
		background2.x = background2.x -1;
		if (background.x < -background.width)
			background.x = background.width;
		if (background2.x < -background2.width)
			background2.x = background2.width;
		for (i in 0...FlxG.gamepads.getActiveGamepads().length)
		{
			if (FlxG.gamepads.getActiveGamepads()[i].pressed(XboxButtonID.A))
			{
				Reg.sounds[3].play();
				clickPlay();
			}
		}
		super.update();
	}	
	
	private function clickPlay():Void
	{
		FlxG.switchState(new PlayState());
	}
	
}