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
 * Enemy AI base class
 * @author Rutger
 */

class State 
{

    public function Enter(owner:Actor):Void { }

    public function Execute(owner:Actor):Void { }

    public function Exit(owner:Actor):Void { }
}
