package ;

import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import Std;
/**
 * ...
 * @author ho
 */
class ParticleWeapon extends Weapon
{
	
	public var emitter:FlxEmitter;
	private var particles:Int = 150;
	private var coneWidth:Float= 50;
	private var range:Float = 500;
	
	
	public function new(player:Player, FiringRate:Float, ProjectileSpeed:Int, WeaponImage:String, BulletImage:String, Damage:Int) 
	{
		super(player, FiringRate, ProjectileSpeed, WeaponImage, BulletImage, Damage);
		damage = Damage;
		emitter = new FlxEmitter(owner.x + owner.width/2, owner.y + owner.height/2);
		emitter.clear();
		for (i in 0...particles)
		{
			var particle:ParticleBullet = new ParticleBullet(damage);
			emitter.add(particle);
		}
		Reg.currentState.add(emitter);
		emitter.start(false,0.01,0.003,0.40);
		emitter.on = false;
	
		
	}
	
	private override function shoot()
	{
		trace(owner.inputmanager.lastRightAngle);
		emitter.setYSpeed((Math.sin(owner.inputmanager.lastRightAngle * Math.PI / 180) * range) -coneWidth, (Math.sin(owner.inputmanager.lastRightAngle * Math.PI / 180) * range)+coneWidth);
		emitter.setXSpeed((Math.cos(owner.inputmanager.lastRightAngle * Math.PI / 180) * range) -coneWidth, (Math.cos(owner.inputmanager.lastRightAngle * Math.PI / 180) * range)+coneWidth);
		if (emitter.on == false)
		{
			
			trace("shooting");
			emitter.on = true;
			Reg.sounds[2].play(true);
		}
	}
	
	public function stopEmitter() {
		emitter.on = false;
		Reg.sounds[2].stop();
	}
	
	public override function update()
	{
		
		framesUntilShooting--;
		emitter.x = owner.x + owner.width/2;
		emitter.y = owner.y + owner.height / 2;
	}
}