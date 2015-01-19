package ;

import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
/**
 * ...
 * @author ho
 */
class ParticleWeapon extends Weapon
{
	
	public var emitter:FlxEmitter;
	private var particles:Int = 500;
	
	public function new(player:Player, FiringRate:Float, ProjectileSpeed:Int, WeaponImage:String, BulletImage:String, Damage:Int) 
	{
		super(player, FiringRate, ProjectileSpeed, WeaponImage, BulletImage, Damage);
		
		emitter = new FlxEmitter(owner.x + owner.width/2, owner.y + owner.height/2);
		emitter.clear();
		for (i in 0...particles)
		{
			var particle:FlxParticle = new FlxParticle();
			particle.makeGraphic(4, 4, 0xfffffff);
			particle.exists = false;
			emitter.add(particle);
		}
		Reg.currentState.add(emitter);
		
		emitter.start(false,0.5,0.003,0,1);
		emitter.on = false;
	}
	
	private override function shoot()
	{
		emitter.setYSpeed((Math.sin(owner.inputmanager.rightAngle * Math.PI / 180) * 100) -25, (Math.sin(owner.inputmanager.rightAngle * Math.PI / 180) * 100)+25);
		emitter.setXSpeed((Math.cos(owner.inputmanager.rightAngle * Math.PI / 180) * 100)-25, (Math.cos(owner.inputmanager.rightAngle * Math.PI / 180) * 100)+25);
		if (emitter.on == false)
		{
			emitter.on = true;
		}
	}
	public override function update()
	{
		framesUntilShooting--;
		emitter.x = owner.x + owner.width/2;
		emitter.y = owner.y + owner.height/2;
	}
}