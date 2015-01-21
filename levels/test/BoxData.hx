package ;
	import flixel.group.FlxGroup;

	class BoxData extends ShapeData
	{
	public var angle:Float;
	public var width:UInt;
	public var height:UInt;

	public function new( X:Float, Y:Float, Angle:Float, Width:Float, Height:Float, Group:FlxGroup ) 
	{
		super(X, Y, Group);
		angle = Angle;
		width = Std.int(Width); //rounding Float to Int
		height = Std.int(Height); //rounding Float to Int
	}
}
