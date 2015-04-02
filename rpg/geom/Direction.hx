package rpg.geom;

/**
 * ...
 * @author Kevin
 */
class Direction
{
	public static inline var NONE:Int = 0;
	public static inline var UP:Int = 1;
	public static inline var DOWN:Int = 2;
	public static inline var LEFT:Int = 4;
	public static inline var RIGHT:Int = 8;
	public static inline var ALL:Int = UP | DOWN | LEFT | RIGHT;
	
	public static function toString(dir:Int):String
	{
		return switch (dir) 
		{
			case NONE: "none";
			case UP: "up";
			case DOWN: "down";
			case LEFT: "left";
			case RIGHT: "right";
			case ALL: "all";
			default: "other";
		}
	}
	
	
	public static function fromString(dir:String):Int
	{
		return switch (dir) 
		{
			case "none": NONE;
			case "up": UP;
			case "down": DOWN;
			case "left": LEFT;
			case "right": RIGHT;
			case "all": ALL;
			default: NONE;
		}
	}
}