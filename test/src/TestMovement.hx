package;
import rpg.event.ScriptHost.TeleportPlayerOptions;
import rpg.map.GameMap;
import rpg.movement.InteractionManager.MovableObjectType;

/**
 * ...
 * @author Kevin
 */
class TestMovement extends rpg.impl.Movement
{

	public function new() 
	{
		super();
	}
	
	
	override public function changeObjectFacing(type:MovableObjectType, dir:Int):Void
	{
		
	}

	override public function teleportPlayer(map:GameMap, x:Int, y:Int, options:TeleportPlayerOptions):Void
	{
		HareTest.lastCalledCommand.set(teleportPlayer, [map, x, y, options]);
	}
	/**
	 * Move an object
	 * @param	callback 	should be called by the implementation when the move is finished, will return true if the player continue moving (useful for determining the animation)
	 * @param	type		
	 * @param	dx
	 * @param	dy
	 * @param	speed 		in tiles/sec
	 */
	override public function moveObject(callback:Void->Bool, type:MovableObjectType, dx:Int, dy:Int, speed:Float):Void
	{
		callback();
	}
}