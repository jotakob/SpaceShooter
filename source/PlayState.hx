package;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxObject;
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
	private var Players:Array<Player> = new Array();
	private var Enemies:FlxGroup = new FlxGroup();
	
	private var shootDirX:Float = 0;
	private var shootDirY:Float = 0;
	
	private var index:Int;
	
	private var level1:Level_Group1;
	private var map:FlxTilemap;
	
	override public function create():Void
	{
		Reg.currentState = this;		
		
		level1 = new Level_Group1(true, null, this);
		
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
			Players.push(tempPlayer);
		}
		FlxG.camera.follow(Players[0], FlxCamera.STYLE_TOPDOWN, null, 1);
		
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
		FlxG.overlap(Reg.bulletGroup, Enemies, receiveDamage);	
		//Code for level collision
		FlxG.collide(Players[0], level1.hitTilemaps);
		FlxG.collide(Players[0], level1.Layer1Group);
		
		super.update();
		
		
	}
	public function receiveDamage(obj1:FlxObject,obj2:FlxObject)
	{
		var bullet:Bullet = cast(obj1, Bullet);
		var enemy:Enemy = cast(obj2, Enemy);
		//var Obj1:Bullet = obj1; Obj1.damage
		//var Obj2:Enemy = obj2;
		enemy.receiveDamage(bullet.damage);
		obj1.kill();
	}
			
		
	private function dealDamage(bullets:FlxObject, player:FlxObject)
	{
		Players[index].hp -= 1;
		bullets.kill();
	}
}

//collision example

