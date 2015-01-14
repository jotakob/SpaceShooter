package ;

import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.util.FlxAngle;
import flixel.util.FlxPoint;
/**
 * ...
 * @author fgnbmghfsfghghjgffdsas
 */
class Bullet extends FlxSprite
{
	private var timer:Float = 180;
	private var speed:Int;
	
	public function new(X:Float=0, Y:Float=0, Angle:Float, Speed:Int, bulletImage:String) 
	{
		super(X, Y);
		//this.velocity = speed;
		
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
			this.exists = false;
		}
	}
	
}