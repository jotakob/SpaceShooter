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
	private var randomNumber:Int;
	
	public function new(player:Player, FiringRate:Float, ProjectileSpeed:Int, WeaponImage:String, BulletImage:String, Damage:Int) 
	{
		super(player, FiringRate, ProjectileSpeed, WeaponImage, BulletImage, Damage);
		
		emitter = new FlxEmitter(owner.x + owner.width/2, owner.y + owner.height/2);
		emitter.clear();
		for (i in 0...particles)
		{
			var particle:FlxParticle = new FlxParticle();
			
			
			randomNumber = Std.random(10);
			switch (randomNumber)
			{
				case 0:
					particle.makeGraphic(5, 5, 0xffffbb00);
				case 1:
					particle.makeGraphic(5, 5, 0xffffb300);
				case 2:
					particle.makeGraphic(5, 5, 0xffffb250);
				case 3:
					particle.makeGraphic(5, 5, 0xffffb350);
				case 4:
					particle.makeGraphic(5, 5, 0xffffb400);
				case 5:
					particle.makeGraphic(5, 5, 0xffffb200);
				case 6:
					particle.makeGraphic(5, 5, 0xffffb175);
				case 7:
					particle.makeGraphic(5, 5, 0xffffb425);
				case 8:
					particle.makeGraphic(5, 5, 0xffff4800);
				case 9:
					particle.makeGraphic(5, 5, 0xffffffff);
			}
			particle.exists = false;
			Reg.bulletGroup.add(particle);
			emitter.add(particle);
			
		}
		Reg.currentState.add(emitter);
		emitter.start(false,0.05,0.003,0.5);
		emitter.on = false;
	
		
	}
	
	private override function shoot()
	{
		emitter.setYSpeed((Math.sin(owner.inputmanager.rightAngle * Math.PI / 180) * range) -coneWidth, (Math.sin(owner.inputmanager.rightAngle * Math.PI / 180) * range)+coneWidth);
		emitter.setXSpeed((Math.cos(owner.inputmanager.rightAngle * Math.PI / 180) * range) -coneWidth, (Math.cos(owner.inputmanager.rightAngle * Math.PI / 180) * range)+coneWidth);
		if (emitter.on == false)
		{
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