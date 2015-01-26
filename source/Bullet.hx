package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.util.FlxAngle;
import flixel.util.FlxCollision;
import flixel.util.FlxPoint;
import haxe.Timer;
/**
 * ...
 * @author fgnbmghfsfghghjgffdsas
 */
class Bullet extends FlxSprite
{
	private var timer:Float = 180;
	private var speed:Int;
	public var damage:Int;
	public var explosive:Bool = false;
	
	public function new(X:Float=0, Y:Float=0, Angle:Float, Speed:Int,Damage:Int, bulletImage:String) 
	{
		super();
		this.x = X;
		this.y = Y;
		//this.velocity = speed;
		damage = Damage;
		speed = Speed;
		angle = Angle;
		loadGraphic(bulletImage);
	}
	public override function update()
	{
		super.update();
		
		//x = x + directionX;
		//y = y + directionY;
		FlxAngle.rotatePoint(speed, 0, 0, 0, angle, velocity);
		timer --;
		if (timer < 1)
		{
			this.kill();
		}
	}
	
	public override function kill ()
	{
		if (this.explosive)
		{
			var explosion = new FlxSprite (this.x, this.y, AssetPaths.explosion__png);
			explosion.x = this.x - explosion.width / 2;
			explosion.y = this.y - explosion.height / 2;
			Reg.currentState.add(explosion);
			Reg.sounds[5].play(true);
			FlxG.overlap(explosion, cast(Reg.currentState, PlayState).Enemies, explodeEnemies);
			Timer.delay(explosion.kill, 100);
		}
		
		super.kill();
	}
	
	private function explodeEnemies (obj1:FlxObject, obj2:FlxObject)
	{
		trace("overlapping");
		var explosion:FlxSprite = cast(obj1, FlxSprite);
		var enemy:Enemy = cast(obj2, Enemy);
		if (FlxCollision.pixelPerfectCheck(explosion, enemy.myAnimationController.topSprite))
		{
			trace("hit");
			enemy.receiveDamage(5*this.damage);
		}
	}
}