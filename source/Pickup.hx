package ;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.util.FlxColor;
import flixel.util.FlxPoint;
import flixel.util.FlxVelocity;

/**
 * ...
 * @author Luuk
 */
class Pickup extends GameObject 
{
    public var emitter:FlxEmitter;
	private var particles:Int = 500;
	
	
	public function new(X:Float=0, Y:Float=0, Width:Float=25, Height:Float=25, Level:BaseLevel) 
	{
		super(X, Y, Width, Height, Level);
		emitter = new FlxEmitter(1700, 800);
		for ( i in 0...particles)
		{
			var particle: FlxParticle = new FlxParticle();
			particle.loadGraphic(AssetPaths.pickup_particle_glow__png, true, 5, 5, false);
			emitter.setXSpeed( -100, 100);
			emitter.setYSpeed( -100, 100);
			particle.exists = false;
			emitter.add(particle);
		}
		Reg.currentState.add(emitter);
		emitter.start(false, 0.2, 0, 0, 0);
		
	}
	
}