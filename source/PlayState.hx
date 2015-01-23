package;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxObject;
import flixel.input.keyboard.FlxKey;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxPoint.FlxCallbackPoint;
import flixel.util.FlxSpriteUtil;
import flixel.input.gamepad.FlxGamepad;
import flixel.input.gamepad.XboxButtonID;
import flixel.group.FlxGroup;
import openfl.utils.Object;
import flixel.FlxCamera;
import flixel.group.FlxTypedGroup;

import openfl.Assets;
import flixel.tile.FlxTilemap;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	private var screenCenterSize:Int = 6;
	
	private var _btnPlay:FlxButton;
	private var _gamePads:Array<FlxGamepad> = new Array();
	
	public var Players:FlxTypedGroup<Player> = new FlxTypedGroup<Player>();
	public var Enemies:FlxTypedGroup<Actor> = new FlxTypedGroup<Actor>();
	
	private var shootDirX:Float = 0;
	private var shootDirY:Float = 0;
	
	
	private var index:Int;
	
	private var currentLevel:BaseLevel;
	
	private var camera:FlxCamera;
	private var cameraObj:FlxObject;
	
	private var _sprBack:FlxSprite;
	
	private var hud:HUD;
	
	//private var music:Array<FlxSound> = new Array();
	
	
	override public function create():Void
	{
		Reg.currentState = this;
		
		Reg.currentLevel = currentLevel = new Level_Demo(true, null, this);
		
		cameraObj = new FlxObject();
		add(cameraObj);
		camera = new FlxCamera(Math.floor(currentLevel.spawnPoint.x), Math.floor(currentLevel.spawnPoint.y), 0, 0, 3);
		FlxG.camera.bounds = FlxG.worldBounds;
		FlxG.camera.follow(cameraObj, FlxCamera.STYLE_LOCKON, null, 1);
		
		var tempPlayer:Player;
		var tempEnemy:Enemy;
		for (i in 0...FlxG.gamepads.getActiveGamepads().length)
		{
			if (_gamePads.indexOf(FlxG.gamepads.getActiveGamepads()[i]) >= 0)
			{
				trace("break");
				break;
			}
			trace("add");
			_gamePads.push(FlxG.gamepads.getActiveGamepads()[i]);
			tempPlayer = (new Player(0, 0, i, FlxG.gamepads.getActiveGamepads()[i]));
			tempPlayer.x = Std.random(Math.floor(currentLevel.spawnPoint.width - tempPlayer.width)) + currentLevel.spawnPoint.x;
			tempPlayer.y = Std.random(Math.floor(currentLevel.spawnPoint.height - tempPlayer.height)) + currentLevel.spawnPoint.y;
			Players.add(tempPlayer);
		}
		add(Players);
		
		//tempEnemy = (new Enemy(300, 200));
		//Enemies.add(tempEnemy);
		add(Enemies);
		
		var tempX:Float = 0;
		var tempY:Float = 0;
		for (tempPlayer in Players.iterator())
		{
			tempX += tempPlayer.x;
			tempY += tempPlayer.y;
		}
		cameraObj.x = tempX / Players.length;
		cameraObj.y = tempY / Players.length;
		
		//Reg.music[0].play();
		Reg.music[1].play();
		hud = new HUD();
		
		add(hud);
		
		
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
		//Custom colliders
		FlxG.overlap(Reg.bulletGroup, Enemies, receiveDamage);
		FlxG.collide(Reg.bulletGroup, currentLevel.hitTilemaps, collideWall);
		FlxG.overlap(currentLevel.triggers, Players, callTrigger);
		FlxG.collide(Players, Enemies, enemyCollision);
		
		//Collision only
		FlxG.collide(Enemies, currentLevel.hitTilemaps);
		FlxG.collide(Enemies, Enemies);
		if (!FlxG.keys.checkStatus(FlxG.keys.getKeyCode("N"), FlxKey.PRESSED))
			FlxG.collide(Players, currentLevel.hitTilemaps);
		
		
		var tempX:Float = 0;
		var tempY:Float = 0;
		var xPlayers = 0;
		var yPlayers = 0;
		
		for (i in Players.iterator())
		{
			var tmpPlayer:Player = cast(i, Player);
			if (tmpPlayer.x - cameraObj.x > (FlxG.camera.width / screenCenterSize))
			{
				tempX += tmpPlayer.x - (FlxG.camera.width / screenCenterSize);
				xPlayers++;
			}
			if (cameraObj.x - tmpPlayer.x > (FlxG.camera.width / screenCenterSize))
			{
				tempX += tmpPlayer.x + (FlxG.camera.width / screenCenterSize);
				xPlayers++;
			}
			if (tmpPlayer.y - cameraObj.y > (FlxG.camera.height / screenCenterSize))
			{
				tempY += tmpPlayer.y - (FlxG.camera.height / screenCenterSize);
				yPlayers++;
			}
			if (cameraObj.y - tmpPlayer.y > (FlxG.camera.height / screenCenterSize))
			{
				tempY += tmpPlayer.y + (FlxG.camera.height / screenCenterSize);
				yPlayers++;
			}
		}
		if (xPlayers > 0)
			cameraObj.x = tempX / xPlayers;
		if (yPlayers > 0)
			cameraObj.y = tempY / yPlayers;
		
		
		currentLevel.repeatables.update();
		super.update();
		
		
	}
	
	private function callTrigger(obj1:FlxObject, obj2:FlxObject)
	{
		var object = cast(obj1, GameObject);
		object.trigger(cast(obj2, Player));
	}
	
	private function enemyCollision(obj1:FlxObject, obj2:FlxObject)
	{
		cast(obj1, Player).receiveDamage(5);
	}
	
	private function receiveDamage(obj1:FlxObject,obj2:FlxObject)
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

