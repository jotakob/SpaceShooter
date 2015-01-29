package ;

import flixel.FlxObject;
import flixel.system.FlxSound;

/**
 * A basic Gameobject in a level
 * @author JJM
 */
class GameObject extends FlxObject
{
	public var repeatable:Bool = false; //Can the Action be executed more than once?
	private var hasBeenExecuted:Bool = false; //Has the associated action been executed?
	public var triggered:Bool = false; //Is it being triggered right at this moment?
	public var resetTime:Int = 50; // In Frames
	private var framesUntilReset:Int = 1; //Countdown variable
	public var sound:FlxSound; //Sound to be played when activated
	public var deactivateSound:FlxSound; //Sound to be played when deactivated
	
	public var tilesToSet:Array<Array<Int>> = new Array<Array<Int>>();
	private var level:BaseLevel;

	public function new(X:Float=0, Y:Float=0, Width:Float=0, Height:Float=0, Level:BaseLevel) 
	{
		super(X, Y, Width, Height);
		level = Level;
	}
	
	/**
	 * Called whenever a object is triggered
	 * @param	actor The actor that triggered the GameObject
	 */
	public function trigger(actor:Actor)
	{
		triggered = true;
		if (!repeatable && !hasBeenExecuted)
		{
			hasBeenExecuted = true;
			activate();
		}
	}
	
	
	/**
	 * A function to set tiles on the layerInteractiveTiles tilemap
	 * @param	tilesToSet An Array of tiles to set, each tile to set needs 3 values: [X, Y, newTileID]
	 */
	private function setTiles(tilesToSet:Array<Array<Int>>)
	{
		for (i in 0...tilesToSet.length)
		{
			level.layerInteractiveTiles.setTile(tilesToSet[i][0], tilesToSet[i][1], tilesToSet[i][2]);
		}
	}
	
	/**
	 * Called whenever an object is activated.
	 * This function is overridden in most child classes to execute specific actions
	 */
	private function activate()
	{
		if (sound != null)
			sound.play();
		setTiles(tilesToSet);
	}
	
	/**
	 * Undoing the actions done in activate(), used for repeatable tiggers
	 */
	private function deactivate()
	{
		if (deactivateSound != null)
			deactivateSound.play();
		for (i in tilesToSet)
		{
			level.layerInteractiveTiles.setTile(i[0], i[1], i[3]);
		}
	}
	
	
	/**
	 * This is used for the timeout of repeatable objects, as well as the check to tigger them in the first place.
	 * Repeatable objects check their triggered-property every frame, and if the trigger is deactivated activates accordingly
	 */
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