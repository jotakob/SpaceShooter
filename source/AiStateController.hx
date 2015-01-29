package ;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxObject;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxSpriteUtil;
import flixel.input.gamepad.FlxGamepad;
import flixel.input.gamepad.XboxButtonID;
import flixel.group.FlxGroup;
import openfl.utils.Object;

/**
 * ...
 * @author Rutger
 */
class AiStateController
{

    private var previousState:State;
    private var currentState:State;

    private var owner:Actor;

	/**
	 * 
	 * @param	owner	Reference to the owner of the class
	 */
    public function new(owner:Actor):Void
    {
        if (owner != null)
        {
            this.owner = owner;
        }
        else
            trace("no character attached");
    }
	
	/**
	 * the functionality that calls the execute on the current A.I state this Actor has.
	 */
    public function Execute():Void
    {
        if (currentState != null)
            currentState.Execute(owner);
    }
	
	/**
	 * 
	 * @param	newState	The state this character should switch to
	 * 
	 * First check whether or not no state has been passed
	 * then checks if there is already a state in place and if there is calls the exit functionality for this state
	 * and saves it to the previous state variable incase this needs to be checked.
	 * Finnaly calls the enter functionality and then switches the state.
	 */
    public function ChangeState(newState:State):Void
    {
	if (newState == null)
        {
            if (newState == null)
				trace("newstate is null on gameobject: " + owner);
            return;
        }
        if (currentState != null)
        {
            currentState.Exit(owner);
            previousState = currentState;
        }
        newState.Enter(owner);
        currentState = newState;
    }
}