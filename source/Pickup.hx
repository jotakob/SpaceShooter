package ;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.FlxSprite;
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
	private var pickupImage = new FlxSprite();
	
	public function new(X:Float=0, Y:Float=0, Width:Float=25, Height:Float=25, Level:BaseLevel) 
	{
		super(X, Y, Width, Height, Level);
		emitter = new FlxEmitter(1700, 800);
		pickupImage.loadGraphic(AssetPaths.engineer_pickup_card__png, false, 32, 32, false);
		pickupImage.x = 1700- pickupImage.width/2;
		pickupImage.y = 800 - pickupImage.width/2;
		for ( i in 0...particles)
		{
			var particle: FlxParticle = new FlxParticle();
			particle.loadGraphic(AssetPaths.pickup_particle_glow__png, true, 5, 5, false);
			
			particle.exists = false;
			emitter.add(particle);
			particle.maxVelocity.x = 20;
			particle.maxVelocity.y = 20;
			emitter.setXSpeed( -2000, 2000);
			emitter.setYSpeed( -2000, 2000);
			
		}
		Reg.currentState.add(emitter);
		emitter.start(false, 0.2, 0, 0, 0);
		Reg.currentState.add(pickupImage);
		
		
		
	}
	
}