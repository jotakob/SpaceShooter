package ;
	class TextData
	{
	public var x:Float;
	public var y:Float;
	public var width:UInt;
	public var height:UInt;
	public var angle:Float;
	public var text:String;
	public var fontName:String;
	public var size:UInt;
	public var color:UInt;
	public var alignment:String;

	public function new( X:Float, Y:Float, Width:UInt, Height:UInt, Angle:Float, Text:String, FontName:String, Size:UInt, Color:UInt, Alignment:String )
	{
		x = X;
		y = Y;
		width = Width;
		height = Height;
		angle = Angle;
		text = Text;
		fontName = FontName;
		size = Size;
		color = Color;
		alignment = Alignment;
	}
}
