package rpg;
import impl.IImplementation;
import rpg.event.EventManager;
import rpg.input.InputManager;
import rpg.map.GameMap;
import rpg.map.MapManager;
import rpg.movement.InteractionManager;

/**
 * ...
 * @author Kevin
 */
@:allow(rpg)
class Engine
{
	public var currentMap(get, never):GameMap;
	
	private var impl:IImplementation;
	private var mapManager:MapManager;
	private var eventManager:EventManager;
	private var inputManager:InputManager;
	private var interactionManager:InteractionManager;
	
	private var delayedCalls:Array<DelayedCall>;
	private var called:Array<DelayedCall>;
	
	public function new(impl:IImplementation, entryPointMapId:Int) 
	{
		this.impl = impl;
		impl.engine = this;
		delayedCalls = [];
		called = [];
		
		mapManager = new MapManager(this);
		eventManager = new EventManager(this);
		inputManager = new InputManager(this);
		interactionManager = new InteractionManager(this);
		
		eventManager.scriptHost.teleportPlayer(entryPointMapId, 5, 5);
		impl.playBackgroundMusic(1, 5, 5); //TODO: to be removed
	}
	
	public function update(elapsed:Float):Void
	{
		eventManager.update(elapsed);
		
		var now = Sys.time();
		for (c in delayedCalls)
		{
			if (now >= c.callAt)
			{
				c.callback();
				called.push(c);
			}
		}
		
		while (called.length > 0)
			delayedCalls.remove(called.pop());
	}
	
	public inline function press(key:InputKey):Void
	{
		inputManager.press(key);
	}
	
	public inline function release(key:InputKey):Void
	{
		inputManager.release(key);
	}
	
	private inline function delayedCall(callback:Void->Void, ms:Int):Void
	{
		delayedCalls.push(new DelayedCall(callback, Sys.time() + ms / 1000));
	}
	
	private inline function get_currentMap():GameMap
	{
		return mapManager.currentMap;
	}
}

private class DelayedCall
{
	public var callback:Void->Void;
	public var callAt:Float;
	
	public function new(callback, callAt)
	{
		this.callback = callback;
		this.callAt = callAt;
	}
}
