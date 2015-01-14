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
	
	var An:Float;
	private var timer:Float = 18;
	
	public function new(X:Float=0, Y:Float=0, angle:Float)
	{
		super(X, Y);
		
		
		An = angle;
		loadGraphic("assets/images/bullet.png");
	}
	public override function update()
	{
		super.update();
		
		//x = x + directionX;
		//y = y + directionY;
		FlxAngle.rotatePoint(500, 0, 0, 0, An, velocity);
		timer -= .1;
		if (timer < .1)
		{
			this.exists = false;
		}
	}
	
}