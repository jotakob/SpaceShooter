package ;
	class ObjectLink
	{
	public var fromObject:Dynamic;
	public var toObject:Dynamic;
	public function new(from:Dynamic, to:Dynamic)
	{
		fromObject = from;
		toObject = to;
	}

	public function destroy():Void
	{
		fromObject = null;
		toObject = null;
	}
}
