package ;

import flixel.FlxObject;
import flixel.system.FlxSound;

/**
 * ...
 * @author JJM
 */
class GameObject extends FlxObject
{
	public var repeatable:Bool = false;
	private var hasBeenExecuted:Bool = false; //Has the associated action been executed?
	public var triggered:Bool = false; //Is it being triggered right at this moment?
	public var resetTime:Int = 50; // In Frames
	private var framesUntilReset:Int = 1;
	public var sound:FlxSound;
	public var deactivateSound:FlxSound;
	
	public var tilesToSet:Array<Array<Int>> = new Array<Array<Int>>();
	private var level:BaseLevel;

	public function new(X:Float=0, Y:Float=0, Width:Float=0, Height:Float=0, Level:BaseLevel) 
	{
		super(X, Y, Width, Height);
		level = Level;
	}
	
	public function trigger(actor:Actor)
	{
		triggered = true;
		if (!repeatable && !hasBeenExecuted)
		{
			hasBeenExecuted = true;
			activate();
		}
	}
	
	private function setTiles(tilesToSet:Array<Array<Int>>)
	{
		for (i in 0...tilesToSet.length)
		{
			level.layerInteractiveTiles.setTile(tilesToSet[i][0], tilesToSet[i][1], tilesToSet[i][2]);
		}
	}
	
	private function activate()
	{
		if (sound != null)
			sound.play();
		setTiles(tilesToSet);
	}
	
	private function deactivate()
	{
		if (deactivateSound != null)
			deactivateSound.play();
		for (i in tilesToSet)
		{
			level.layerInteractiveTiles.setTile(i[0], i[1], i[3]);
		}
	}
	
	public override function update()
	{
		super.update();
		if (repeatable)
		{
			framesUntilReset--;
			
			if (triggered)
			{
				framesUntilReset = resetTime;
				if (!hasBeenExecuted)
				{
					activate();
					hasBeenExecuted = true;
				}
				
				triggered = false;
			}
			if (framesUntilReset == 0)
			{
				deactivate();
				hasBeenExecuted = false;
			}
		}
	}
}