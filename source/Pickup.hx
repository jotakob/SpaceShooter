package ;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxPoint;
import flixel.util.FlxVelocity;
import flixel.util.FlxRandom;

/**
 * ...
 * @author Luuk
 */
class Pickup extends GameObject 
{
    public var emitter:FlxEmitter;
	private var particles:Int = 500;
	private var pickupImage = new FlxSprite();
	private var randomColor:Int;
	private var particleSize:Int;
	
	
	public function new(X:Float=0, Y:Float=0, Width:Float=25, Height:Float=25, Level:BaseLevel) 
	{
		super(X, Y, Width, Height, Level);
		
		emitter = new FlxEmitter(X, Y);
		pickupImage.loadGraphic(AssetPaths.lore_pickup_card__png, false, 32, 32, false);
		pickupImage.x = X- pickupImage.width/2;
		pickupImage.y = Y - pickupImage.width / 2;
			
		for ( i in 0...particles)
		{
			var particle: FlxParticle = new FlxParticle();
			particleSize = Std.random(3) + 3;
			randomColor = FlxRandom.colorExt(0,0,0,255,255,255,255,255);
			particle.makeGraphic(particleSize, particleSize, randomColor, false);
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
	
	public override function activate()
	{
		Reg.inventory.set("pickup", Reg.inventory["pickup"] + 1);
		this.kill();
	}
	
	public override function kill()
	{
		emitter.destroy();
		pickupImage.destroy();
		super.kill();
	}
	
}