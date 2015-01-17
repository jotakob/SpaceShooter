package ;
	import flixel.group.FlxGroup;
	import flixel.FlxSprite;

	class PathData
	{
		public var nodes:Array<Dynamic>;
		public var isClosed:Bool;
		public var isSpline:Bool;
		public var layer:FlxGroup;

		// These values are only set if there is an attachment.
		public var childSprite:FlxSprite = null;
		public var childAttachNode:Int = 0;
		public var childAttachT:Float = 0;	// position of child between attachNode and next node.(0-1)

		public function new( Nodes:Array<Dynamic>, Closed:Bool, Spline:Bool, Layer:FlxGroup )
		{
			nodes = Nodes;
			isClosed = Closed;
			isSpline = Spline;
			layer = Layer;
		}

		public function destroy():Void
		{
			layer = null;
			childSprite = null;
			nodes = null;
		}
	}
