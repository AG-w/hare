package rpg.geom;

/**
 * ...
 * @author Kevin
 */
class Point
{
	public var x:Float;
	public var y:Float;
	
	public function new(x:Float = 0, y:Float = 0)
	{
		this.x = x;
		this.y = y;
	}
	
	public inline function set(x:Float = 0, y:Float = 0)
	{
		this.x = x;
		this.y = y;
	}
}