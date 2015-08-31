package rpg.impl;
import rpg.Engine;
import rpg.image.Image;
import rpg.map.GameMap;
import rpg.save.SaveManager.SaveDisplayData;

/**
 * ...
 * @author Kevin
 */
class System extends Module
{

	public function new(impl) 
	{
		super(impl);
	}
	
	public function showMainMenu(startGameCallback:Void->Void, loadGameCallback:Void->Void):Void
	{
		
	}
	
	public function hideMainMenu():Void
	{
		
	}
	
	public function showGameMenu(callback:GameMenuAction->Void, cancelCallback:Void->Void):Void
	{
		
	}
	
	public function hideGameMenu():Void
	{
		
	}
	
	public function showSaveScreen(saveGameCallback:Int->Void, cancelCallback:Void->Void, data:Array<SaveDisplayData>):Void
	{
		
	}
	
	public function hideSaveScreen():Void
	{
		
	}
	
	public function showLoadScreen(loadGameCallback:Int->Void, cancelCallback:Void->Void, data:Array<SaveDisplayData>):Void
	{
		
	}
	
	public function hideLoadScreen():Void
	{
		
	}
	
	public function switchMap(map:GameMap):Void
	{
		
	}
	
	public function log(message:String, level:LogLevel):Void
	{
		
	}
}