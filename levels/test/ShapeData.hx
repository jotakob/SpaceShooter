package ;
	import flixel.group.FlxGroup;

	class ShapeData
	{
	public var x:Float;
	public var y:Float;
	public var group:FlxGroup;

	public function new(X:Float, Y:Float, Group:FlxGroup )
	{
		x = X;
		y = Y;
		group = Group;
	}

	public function destroy():Void
	{
		group = null;
	}
}
