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
 * @author ho
 */
class AiStateController
{

    private var previousState:State;
    private var currentState:State;

    private var owner:Actor;

    public function new(owner:Actor):Void
    {
        if (owner != null)
        {
            this.owner = owner;
        }
        else
            trace("no character attached");
    }

    public function Execute():Void
    {
        if (currentState != null)
            currentState.Execute(owner);
    }

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