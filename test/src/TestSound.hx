package;
import hare.impl.Sound;

/**
 * ...
 * @author Kevin
 */
class TestSound extends hare.impl.Sound
{

	public function new() 
	{
		super();
	}
	
	override public function playSound(id:Int, volume:Float):Void
	{
		HareTest.lastCalledCommand.set(Macro.getCurrentFunction(), [id, volume]);
	}

	override public function playSystemSound(id:Int, volume:Float):Void
	{
		
	}
}