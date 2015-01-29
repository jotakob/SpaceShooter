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
 * A FlxState which is used for the actual gameplay.
 */
class PlayState extends FlxState
{
	private var screenCenterSize:Int = 6; //size of the space in the center of the screen where the player position doesn't affect camera movement
	
	private var _gamePads:Array<FlxGamepad> = new Array();
	
	public var Players:FlxTypedGroup<Player> = new FlxTypedGroup<Player>();
	public var Enemies:FlxTypedGroup<Actor>;
	public var PlayerStuff:FlxGroup = new FlxGroup();//Sprites, Weapons etc. that belongs to the player and thus carries over to 
	
	private var currentLevel:BaseLevel;
	
	private var camera:FlxCamera;
	private var cameraObj:FlxObject = new FlxObject(); //The invisible object that the camera trcks. It's position is calculated based on all players' positions
	
	private var hud:HUD;
	
	override public function create():Void
	{
		FlxG.camera.fade(FlxColor.BLACK, 2, true);
		Reg.currentState = this;
		
		//Levels are created here and written in the Registry for later use. They cannot be loaded earlier since they need the playstate as a parameter
		/** @author Jakob */
		Reg.levels.set("Demo", new Level_Demo(false, null, this));
		Reg.levels.set("Demo2", new Level_Demo2(false, null, this));
		
		/** @author Rutger */
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
			_gamePads.push(FlxG.gamepads.getActiveGamepads()[i]);
			tempPlayer = (new Player(0, 0, i, FlxG.gamepads.getActiveGamepads()[i]));
			Players.add(tempPlayer);
		}
		
		//Adding keyboard player as a backup/for demo purposes
		/** @author Jakob */
		if (Players.members.length == 0)
		{
			tempPlayer = (new Player(0, 0, 0, null));
			tempPlayer.inputmanager = new KeyboardInputManager(tempPlayer);
			Players.add(tempPlayer);
		}
		
		
		//placing the players at a rendom location within the spawnpoint rectangle
		/** @author Jakob */
		for (tempPlayer in Players.iterator())
		{
			tempPlayer.x = Std.random(Math.floor(currentLevel.spawnPoints[0].width - tempPlayer.width)) + currentLevel.spawnPoints[0].x;
			tempPlayer.y = Std.random(Math.floor(currentLevel.spawnPoints[0].height - tempPlayer.height)) + currentLevel.spawnPoints[0].y;
		}
		
		//adding the camera object and placing it between the players
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
	
	/**
	 * unloads the current level and loads the new level. the current level can later be reloaded again.
	 * @param	name  The name of the level to load
	 * @param	spawnPointID  The ID of the spawnpoint that the players get placed at
	 * @author  Jakob
	 */
	public function changeLevel(name:String, spawnPointID:Int)
	{
		//removing all stuff from the playstate that is needed later on
		if (currentLevel != null)
			this.remove(currentLevel.masterLayer);
		this.remove(Players);
		this.remove(PlayerStuff);
		this.remove(cameraObj);
		this.remove(hud);
		
		//destroying everything that wasn't removed
		this.forEach(killstuff);
		
		
		Enemies = new FlxTypedGroup<Actor>();
		
		// Loading the new level
		Reg.currentLevel = currentLevel = Reg.levels[name];
		currentLevel.createObjects(null, this);
		currentLevel.addTileAnimations(currentLevel.layerInteractiveTiles);
		
		// Adjusting the world boundaries
		FlxG.worldBounds.left = currentLevel.boundsMinX;
		FlxG.worldBounds.right = currentLevel.boundsMaxX;
		FlxG.worldBounds.top = currentLevel.boundsMinY;
		FlxG.worldBounds.bottom = currentLevel.boundsMaxY;
		add(Enemies);
		
		//placing the players at a rendom location within the spawnpoint rectangle
		for (tempPlayer in Players.iterator())
		{
			tempPlayer.skipFrames = 2; //The player doesn't update for the first to frames after spawning to allow the camera to properly position itself
									   //Yes, this is a bugfix/hack
			tempPlayer.x = Std.random(Math.floor(currentLevel.spawnPoints[spawnPointID].width - tempPlayer.width)) + currentLevel.spawnPoints[spawnPointID].x;
			tempPlayer.y = Std.random(Math.floor(currentLevel.spawnPoints[spawnPointID].height - tempPlayer.height)) + currentLevel.spawnPoints[spawnPointID].y;
		}
		
		//Re-adding and positioning of the cameraobject
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
		
		//Re-adding the previously removed stuff
		add(PlayerStuff);
		add(Players);
		add(hud);
		// And a nice fade-in to top it all off
		FlxG.camera.fade( 0xFF000000, 2, true, null, true);
	}
	
	
	/**
	 * Simple function do destroy an object
	 * @param	obj  The object to be destroyed
	 */
	private function killstuff(obj:FlxBasic)
	{
		obj.destroy();
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
		//Collision detection with a callback function
		FlxG.overlap(Reg.bulletGroup, Enemies, receiveDamage);
		FlxG.collide(Reg.bulletGroup, currentLevel.hitTilemaps, collideWall);
		FlxG.collide(Reg.bulletGroup, currentLevel.collisionBoxes, collideWall);
		FlxG.overlap(currentLevel.triggers, Players, callTrigger);
		FlxG.collide(Players, Enemies, enemyCollision);
		
		//Collision detection only
		FlxG.collide(Enemies, currentLevel.hitTilemaps);
		FlxG.collide(Enemies, currentLevel.collisionBoxes);
		
		if (!FlxG.keys.checkStatus(FlxG.keys.getKeyCode("N"), FlxKey.PRESSED)) //CHEATCODE!!
		{
			FlxG.collide(Players, currentLevel.hitTilemaps);
			FlxG.collide(Players, currentLevel.collisionBoxes);
		}
		
		
		//Repositioning the camera objects to follow players that leave the center screen area
		/** @author Jakob */
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
			
			//Game Ending for the demonstration only!!
			if (Reg.inventory["pickup"] >= 3)
				FlxG.camera.fade(0xff000000, 2, false, endGame);
		}
		if (xPlayers > 0)
			cameraObj.x = tempX / xPlayers;
		if (yPlayers > 0)
			cameraObj.y = tempY / yPlayers;
		
		
		//updating repeatable gameobjects
		currentLevel.repeatables.update();
		//and everything else, basically
		super.update();
	}
	
	/**
	 * used to delay the endscreen until after the fadeout
	 */
	private function endGame()
	{
		FlxG.switchState(new EndState());
	}
	
	//These functions are all custom collider callbacks
	
	
	/**
	 * Triggering a trigger and giving it the triggerer 
	 * @author Jakob
	 */
	private function callTrigger(obj1:FlxObject, obj2:FlxObject)
	{
		var object = cast(obj1, GameObject);
		object.trigger(cast(obj2, Player));
	}
	
	/**
	 * Dealing damage to players when colliding with an enemy
	 * @author Rutger
	 */
	private function enemyCollision(obj1:FlxObject, obj2:FlxObject)
	{
		cast(obj1, Player).receiveDamage(5);
		cast(obj1, Player).myAnimationController.DamageColoring();
	}
	
	/**
	 * Dealing damage to enemies when they get hit by a bullet
	 * @author Rutger
	 */
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
	
	/**
	 * Removing a bullet when it hits a wall
	 */
	public function collideWall(obj1:FlxObject, obj2:FlxObject)
	{
		obj1.kill();
	}
	
	
}

