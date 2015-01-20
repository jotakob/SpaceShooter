package ;

import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;

/**
 * ...
 * @author fgnbmghfsfghghjgffdsas
 */
class ParticleBullet extends FlxParticle
{
	public var damage:Int;
	public var randomNumber:Int;
	public function new(Damage:Int) 
	{
		super();
		damage = Damage;
		
		randomNumber = Std.random(10);
			switch (randomNumber)
			{
				case 0:
					this.makeGraphic(5, 5, 0xffffbb00);
				case 1:
					this.makeGraphic(5, 5, 0xffffb300);
				case 2:
					this.makeGraphic(5, 5, 0xffffb250);
				case 3:
					this.makeGraphic(5, 5, 0xffffb350);
				case 4:
					this.makeGraphic(5, 5, 0xffffb400);
				case 5:
					this.makeGraphic(5, 5, 0xffffb200);
				case 6:
					this.makeGraphic(5, 5, 0xffffb175);
				case 7:
					this.makeGraphic(5, 5, 0xffffb425);
				case 8:
					this.makeGraphic(5, 5, 0xffff4800);
				case 9:
					this.makeGraphic(5, 5, 0xffffbb00);
			}
			this.exists = false;
			Reg.bulletGroup.add(this);
	}
	override public function update() 
	{
		super.update();
	}
	
}