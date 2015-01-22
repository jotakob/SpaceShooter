package;

import flixel.util.FlxSave;
import flixel.group.FlxGroup;
import flixel.FlxState;
import flixel.system.FlxSound;

/**
 * Handy, pre-built Registry class that can be used to store 
 * references to objects and other things for quick-access. Feel
 * free to simply ignore it or change it in any way you like.
 */
class Reg
{
	//public static var saves:Array<FlxSave> = [];
	
	public static var bullets:Array<FlxGroup> = [];
	
	public static var currentState:FlxState;
	
	public static var bulletGroup:FlxGroup = new FlxGroup();
	
	public static var currentLevel:BaseLevel;
	
	public static var music:Array<FlxSound> = new Array();
	
	public static var sounds:Array<FlxSound> = new Array();
	
	public static var characterAnimations:Map<String,Array<String>> = new Map<String,Array<String>>();
	
	
}