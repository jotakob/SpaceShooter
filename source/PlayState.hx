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
import flixel.util.FlxCollision;
import flixel.util.FlxColor;

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
	public var Enemies:FlxTypedGroup<Actor>;
	public var PlayerStuff:FlxGroup = new FlxGroup();
	
	private var index:Int;
	
	private var currentLevel:BaseLevel;
	
	private var camera:FlxCamera;
	private var cameraObj:FlxObject = new FlxObject();
	
	private var _sprBack:FlxSprite;
	
	private var hud:HUD;
	
	//private var music:Array<FlxSound> = new Array();
	
	
	override public function create():Void
	{
		FlxG.camera.fade(FlxColor.BLACK, 2, true);
		Reg.currentState = this;
		
		Reg.levels.set("Demo", new Level_Demo(false, null, this));
		Reg.levels.set("Demo2", new Level_Demo2(false, null, this));
		Reg.levels.set("MCTest", new Level_MCTest(false, null, this));
		
		camera = new FlxCamera(0, 0, 0, 0, 3);
		FlxG.camera.bounds = FlxG.worldBounds;
		FlxG.camera.follow(cameraObj, FlxCamera.STYLE_LOCKON, null, 1);
		
		changeLevel("Demo", 0);
		
		var tempPlayer:Player;
		for (i in 0...FlxG.gamepads.getActiveGamepads().length)
		{
			if (_gamePads.indexOf(FlxG.gamepads.getActiveGamepads()[i]) >= 0)
			{
				trace("break");
				break;
			}
			trace("adding Player");
			_gamePads.push(FlxG.gamepads.getActiveGamepads()[i]);
			tempPlayer = (new Player(0, 0, i, FlxG.gamepads.getActiveGamepads()[i]));
			Players.add(tempPlayer);
		}
		
		for (tempPlayer in Players.iterator())
		{
			tempPlayer.x = Std.random(Math.floor(currentLevel.spawnPoints[0].width - tempPlayer.width)) + currentLevel.spawnPoints[0].x;
			tempPlayer.y = Std.random(Math.floor(currentLevel.spawnPoints[0].height - tempPlayer.height)) + currentLevel.spawnPoints[0].y;
		}
		
		add(cameraObj);
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
		
		
		super.create();
	}
	
	public function changeLevel(name:String, spawnPointID:Int)
	{
		if (currentLevel != null)
			this.remove(currentLevel.masterLayer);
		this.remove(Players);
		this.remove(PlayerStuff);
		this.remove(cameraObj);
		this.remove(hud);
		
		this.forEach(killstuff);
		
		Enemies = new FlxTypedGroup<Actor>();
		Reg.currentLevel = currentLevel = Reg.levels[name];
		currentLevel.createObjects(null, this);
		currentLevel.addTileAnimations(currentLevel.layerInteractiveTiles);
		add(Enemies);
		
		for (tempPlayer in Players.iterator())
		{
			tempPlayer.skipFrames = 2;
			tempPlayer.x = Std.random(Math.floor(currentLevel.spawnPoints[spawnPointID].width - tempPlayer.width)) + currentLevel.spawnPoints[spawnPointID].x;
			tempPlayer.y = Std.random(Math.floor(currentLevel.spawnPoints[spawnPointID].height - tempPlayer.height)) + currentLevel.spawnPoints[spawnPointID].y;
		}
		
		add(cameraObj);
		var tempX:Float = 0;
		var tempY:Float = 0;
		for (tempPlayer in Players.iterator())
		{
			tempX += tempPlayer.x;
			tempY += tempPlayer.y;
		}
		cameraObj.x = tempX / Players.length;
		cameraObj.y = tempY / Players.length;
		
		add(PlayerStuff);
		add(Players);
		add(hud);
		FlxG.camera.fade( 0xFF000000, 2, true,null,true);
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
		FlxG.collide(Reg.bulletGroup, currentLevel.collisionBoxes, collideWall);
		FlxG.overlap(currentLevel.triggers, Players, callTrigger);
		FlxG.collide(Players, Enemies, enemyCollision);
		
		//Collision only
		FlxG.collide(Enemies, currentLevel.hitTilemaps);
		FlxG.collide(Enemies, currentLevel.collisionBoxes);
		//FlxG.collide(Enemies, Enemies);
		if (!FlxG.keys.checkStatus(FlxG.keys.getKeyCode("N"), FlxKey.PRESSED))
		{
			FlxG.collide(Players, currentLevel.hitTilemaps);
		FlxG.collide(Players, currentLevel.collisionBoxes);
		}
		
		
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
		
		if (Enemies.members.length < 17)
		{
			//FlxG.camera.fade(0xff000000, 1);
		}
			
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
		cast(obj1, Player).myAnimationController.DamageColoring();
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
	
	private function killstuff(obj:FlxBasic)
	{
		obj.destroy();
	}
	
}

