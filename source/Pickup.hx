package ;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.util.FlxColor;
/**
 * ...
 * @author Luuk
 */
class Pickup extends GameObject 
{
    public var emitter:FlxEmitter;
	private var particles:Int = 2;
	
	public function new(X:Float=0, Y:Float=0, Width:Float=0, Height:Float=0, Level:BaseLevel) 
	{
		super(X, Y, Width, Height, Level);
		
	}
	
	for ( i in 0...particles)
	{
		private var particle: FlxParticle = new FlxParticle();
		particle.MakeGraphic(2, 2, 0xffff0000);
		particle.exist = false;
		emitter.add(particle);
	}
	add(emitter);
	emitter.start();
}