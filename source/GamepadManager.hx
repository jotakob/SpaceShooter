package ;

import flixel.input.gamepad.FlxGamepadManager;
import flixel.input.gamepad.FlxGamepad;

import flash.Lib;
import flixel.FlxG;
import flixel.input.gamepad.FlxGamepad;
import flixel.interfaces.IFlxInput;
import flixel.util.FlxDestroyUtil;

#if (cpp || neko)
import openfl.events.JoystickEvent;
#end

#if flash
import flash.ui.GameInput;
import flash.ui.GameInputDevice;
import flash.events.GameInputEvent;
#end

/**
 * ...
 * @author ...
 */
class GamepadManager extends FlxGamepadManager
{

	public function new() 
	{
		super();
		
	}
	
	/**
	 * Get array of gamepads.
	 * 
	 * @param	GamepadArray	optional array to fill with active gamepads
	 * @return	array filled with active gamepads
	 */
	public override function getActiveGamepads(?GamepadArray:Array<FlxGamepad>):Array<FlxGamepad>
	{
		if (GamepadArray == null)
		{
			GamepadArray = [];
		}
		
		for (gamepad in _gamepads)
		{
			if ((gamepad != null) /*&& gamepad.anyInput()*/)
			{
				GamepadArray.push(gamepad);
			}
		}
		
		return GamepadArray;
	}
	
}