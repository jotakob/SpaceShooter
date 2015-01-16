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
	private var particles:Int = 5;
	
	public function new(player:Player, FiringRate:Float, ProjectileSpeed:Int, WeaponImage:String, BulletImage:String, Damage:Int) 
	{
		super(player, FiringRate, ProjectileSpeed, WeaponImage, BulletImage, Damage);
		
		owner = player;
		firingRate = FiringRate;
		firingFrames = Math.round(1 / FiringRate);
		if (firingFrames < 1)
			firingFrames = 1;
		projectileSpeed = ProjectileSpeed;
		weaponImage = WeaponImage;
		bulletImage = BulletImage;
		damage = Damage;
		
		emitter = new FlxEmitter(owner.x, owner.y);
		for (i in 0...particles)
		{
			var particle:FlxParticle = new FlxParticle();
			particle.makeGraphic(2, 2, 0xE30B21);
			particle.exists = false;
			emitter.add(particle);
		}
		Reg.currentState.add(emitter);
		
		emitter.start(false,1,0.00001);
		emitter.on = false;
	}
	
	private override function shoot()
	{
		trace(Math.sin(owner.inputmanager.rightAngle * Math.PI / 180) * 100);
		trace(Math.cos(owner.inputmanager.rightAngle * Math.PI / 180) * 100);
		emitter.setYSpeed((Math.sin(owner.inputmanager.rightAngle * Math.PI / 180) * 100) -100, (Math.sin(owner.inputmanager.rightAngle * Math.PI / 180) * 100)+100);
		emitter.setXSpeed((Math.cos(owner.inputmanager.rightAngle * Math.PI / 180) * 100)-100, (Math.cos(owner.inputmanager.rightAngle * Math.PI / 180) * 100)+100);
		//trace(Math.cos(owner.inputmanager.rightAngle*Math.PI/180)*5);
		if (emitter.on == false)
		{
			emitter.on = true;
		}
	}
	public override function update()
	{
		framesUntilShooting--;
		emitter.x = owner.x;
		emitter.y = owner.y;
	}
}