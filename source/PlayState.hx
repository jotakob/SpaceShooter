package;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxObject;
import flixel.group.FlxTypedGroup;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxSpriteUtil;
import flixel.input.gamepad.FlxGamepad;
import flixel.input.gamepad.XboxButtonID;
import flixel.group.FlxGroup;
import openfl.utils.Object;
import flixel.FlxCamera;

import openfl.Assets;
import flixel.tile.FlxTilemap;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	private var _btnPlay:FlxButton;
	private var _gamePads:Array<FlxGamepad> = new Array();
	private var Players:FlxGroup = new FlxGroup();
	private var Enemies:FlxGroup = new FlxGroup();
	
	private var shootDirX:Float = 0;
	private var shootDirY:Float = 0;
	
	
	private var index:Int;
	
	private var level1:Level_Group1;
	private var currentLevel:BaseLevel;
	private var map:FlxTilemap;
	
	private var camera:FlxCamera;
	private var ScreenCollision:FlxSprite  = new FlxSprite();
	private var cameraObj:FlxObject;
	
	//private var music:Array<FlxSound> = new Array();
	
	
	override public function create():Void
	{
		Reg.currentState = this;		
		
		level1 = new Level_Group1(true, null, this);
		currentLevel = level1;
		ScreenCollision.loadGraphic(AssetPaths.ScreenCollision__png);
		add(ScreenCollision);
		var tempPlayer;
		var tempEnemy;
		for (i in 0...FlxG.gamepads.getActiveGamepads().length)
		{
			if (_gamePads.indexOf(FlxG.gamepads.getActiveGamepads()[i]) >= 0)
			{
				trace("break");
				break;
			}
			trace("add");
			_gamePads.push(FlxG.gamepads.getActiveGamepads()[i]);
			tempPlayer = (new Player(240, 160, i, FlxG.gamepads.getActiveGamepads()[i]));
			tempEnemy = (new Enemy(300, 200));
			add(tempEnemy);
			Enemies.add(tempEnemy);
			tempPlayer.addWeapon(new ParticleWeapon(tempPlayer, 0.25, 500, AssetPaths.cursor__png , AssetPaths.fire_particle__png, 1));
			add(tempPlayer);
			//add(tempPlayer2);
			//Players.push(tempPlayer2);
			Players.add(tempPlayer);
		}
		cameraObj = new FlxObject();
		add(cameraObj);
		camera = new FlxCamera(0, 0, 0, 0, 3);
		FlxG.camera.follow(cameraObj, FlxCamera.STYLE_TOPDOWN, null, 1);
		
		
		trace("Music here");
		
		//Reg.music[0].play();
		Reg.music[1].play();
		
		super.create();
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		var tempX:Float = 0;
		var tempY:Float = 0;
		
		for (i in Players.iterator())
		{
			var tmp:Player = cast(i, Player);
			tempX += tmp.x;
			tempY += tmp.y;
		}
		tempX = tempX / Players.length;
		tempY = tempY / Players.length;
		cameraObj.x = tempX;
		cameraObj.y = tempY;
		ScreenCollision.x = FlxG.camera.x;
		ScreenCollision.y = FlxG.camera.y;
		
		FlxG.overlap(Reg.bulletGroup, Enemies, receiveDamage);	
		FlxG.overlap(Reg.bulletGroup, currentLevel.hitTilemaps, collideWall);
		
		//Code for level collision
		FlxG.collide(Players, level1.hitTilemaps);
		FlxG.collide(Players, ScreenCollision);
		
		super.update();
		
		
	}
	public function receiveDamage(obj1:FlxObject,obj2:FlxObject)
	{
		var enemy:Enemy = cast(obj2, Enemy);
		if (Type.getClass(obj1) == Bullet)
		{
			var bullet:Bullet  = cast(obj1, Bullet);
			enemy.receiveDamage(bullet.damage);
		}
		else if (Type.getClass(obj1) == ParticleBullet)
		{
			var bullet:ParticleBullet = cast(obj1, ParticleBullet);
			enemy.receiveDamage(bullet.damage);
		}
		
		obj1.kill();
	}
	public function collideWall(obj1:FlxObject, obj2:FlxObject)
	{
		obj1.kill();
	}
	
}

