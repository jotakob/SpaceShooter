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
import flixel.util.FlxColor;
import haxe.Timer;
using flixel.util.FlxSpriteUtil;
import openfl.Assets;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	private var background:FlxSprite = new FlxSprite();
	private var background2:FlxSprite = new FlxSprite();
	private var spaceship:FlxSprite = new FlxSprite();
	private var planet:FlxSprite = new FlxSprite();
	private var explosion:FlxSprite = new FlxSprite();
	private var hover:Float = 0;
	private var goingUP:Bool = false;
	private var pressed = false;
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
		spaceship.loadGraphic(AssetPaths.spaceship__png);
		spaceship.x = FlxG.width / 2 - spaceship.width / 2;
		spaceship.y = FlxG.height / 2 - spaceship.height / 2;
		planet.loadGraphic(AssetPaths.Planet__png);
		planet.x = FlxG.width;
		planet.y = FlxG.height / 2  - 100;
		explosion.loadGraphic(AssetPaths.explosionspaceship__png, true, 32, 32);
		explosion.animation.add("explode", [0, 1, 2, 3, 4], 4, false);
		add(background);
		add(background2);
		add(planet);
		add(spaceship);
		
		_btnPlay = new FlxButton(FlxG.width /2 - 40, FlxG.height /2 + 150, "Play", clickPlay);
		_btnPlay.onDown.sound = FlxG.sound.load("assets/sounds/click.ogg");
		_btnPlay.onUp.sound = FlxG.sound.load("assets/sounds/click.ogg");
		add(_btnPlay);
		
		loadAnimations();
		loadMusic();
		Reg.music[0].play();
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
		Reg.sounds[5].volume = 0.3;
		
		Reg.sounds[6] = new FlxSound();
		Reg.sounds[6].loadStream(AssetPaths.man1__ogg, false, false);
		Reg.sounds[6].volume = 0.7;
		
		Reg.sounds[7] = new FlxSound();
		Reg.sounds[7].loadStream(AssetPaths.man2__ogg, false, false);
		Reg.sounds[7].volume = 0.7;
		
		Reg.sounds[8] = new FlxSound();
		Reg.sounds[8].loadStream(AssetPaths.man3__ogg, false, false);
		Reg.sounds[8].volume = 0.7;
		
		Reg.sounds[9] = new FlxSound();
		Reg.sounds[9].loadStream(AssetPaths.man4__ogg, false, false);
		Reg.sounds[9].volume = 0.7;
		
		Reg.sounds[10] = new FlxSound();
		Reg.sounds[10].loadStream(AssetPaths.man5__ogg, false, false);
		Reg.sounds[10].volume = 0.7;
		
		Reg.sounds[11] = new FlxSound();
		Reg.sounds[11].loadStream(AssetPaths.woman1__ogg, false, false);
		Reg.sounds[11].volume = 0.7;
		
		Reg.sounds[12] = new FlxSound();
		Reg.sounds[12].loadStream(AssetPaths.woman2__ogg, false, false);
		Reg.sounds[12].volume = 0.7;
		
		Reg.sounds[13] = new FlxSound();
		Reg.sounds[13].loadStream(AssetPaths.robot_hit__ogg, false, false);
		Reg.sounds[13].volume = 0.7;
		
		Reg.sounds[14] = new FlxSound();
		Reg.sounds[14].loadStream(AssetPaths.alien_hit__ogg, false, false);
		Reg.sounds[14].volume = 0.7;
		
		Reg.sounds[15] = new FlxSound();
		Reg.sounds[15].loadStream(AssetPaths.space_ship_crash__ogg, false, false);
		Reg.sounds[15].volume = 1;
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
		trace(hover);
		trace(spaceship.y);
		background.x = background.x - 1;
		background2.x = background2.x -1;
		if (background.x < -background.width)
			background.x = background.width;
		if (background2.x < -background2.width)
			background2.x = background2.width;
		
		if (spaceship.scale.x > 0.004)
		{
			spaceship.y = spaceship.y + hover;
			if (goingUP)
				hover = -0.15;
			else
				hover = 0.15;
			if (spaceship.y < 142)
				goingUP = false;
			if (spaceship.y > 153)
				goingUP = true;
		}
		
		if (pressed)
		{
			if (spaceship.scale.x > 0.004)
			{
				spaceship.scale.x = spaceship.scale.y = spaceship.scale.x - 0.004;
				spaceship.x = spaceship.x + 0.9;
				planet.x = planet.x - 1;
			}
			else
			{
				explosion.x = spaceship.x + spaceship.width/2 - 10;
				explosion.y = spaceship.y + spaceship.height/2 - 10;
				add(explosion);
				explosion.animation.play("explosion");
			}
		}
			
		for (i in 0...FlxG.gamepads.getActiveGamepads().length)
		{
			if (FlxG.gamepads.getActiveGamepads()[i].pressed(XboxButtonID.A) && pressed == false)
			{
				Reg.sounds[3].play();
				clickPlay();
			}
		}
		super.update();
	}	
	
	private function clickPlay():Void
	{
		FlxG.camera.shake(0.005, 7);
		FlxG.camera.fade(FlxColor.BLACK, 7, false, nextState);
		Timer.delay(crashSound, 500);
		pressed = true;
		_btnPlay = FlxDestroyUtil.destroy(_btnPlay);
	}
	private function nextState():Void
	{
		FlxG.switchState(new PlayState());
	}
	private function crashSound():Void
	{
		Reg.sounds[15].play();
	}
}