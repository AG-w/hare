package impl.flixel ;
import openfl.Assets;
import impl.IAssetManager;
import openfl.media.Sound;
import sys.FileSystem;

/**
 * ...
 * @author Kevin
 */
class AssetManager implements IAssetManager
{
	private var maps:Map<Int, String>;
	private var scripts:Map<Int, Map<Int, String>>;
	private var musics:Map<Int, String>;
	private var sounds:Map<Int, String>;

	public function new() 
	{
		maps = new Map();
		scripts = new Map();
		musics = new Map();
		sounds = new Map();
		
		for (f in FileSystem.readDirectory("assets/data/map"))
		{
			var id = Std.parseInt(f.split("-")[0]);
			maps[id] = f;
			scripts[id] = new Map();
		}
		
		for (f in FileSystem.readDirectory("assets/data/script"))
		{
			var s = f.split("-");
			var mapId = Std.parseInt(s[0]);
			var eventId = Std.parseInt(s[1]);
			scripts[mapId][eventId] = f;
		}
		
		for (f in FileSystem.readDirectory("assets/music"))
		{
			var id =  Std.parseInt(f.split("-")[0]);
			musics[id] = f;
		}
		
		for (f in FileSystem.readDirectory("assets/sounds"))
		{
			var id =  Std.parseInt(f.split("-")[0]);
			sounds[id] = f;
		}
		
	}
	
	public function getMapData(id:Int):String 
	{
		var filename = maps[id];
		return Assets.getText('assets/data/map/$filename');
	}
	
	public function getScript(mapId:Int, eventId:Int):String 
	{
		var filename = scripts[mapId][eventId];
		return Assets.getText('assets/data/script/$filename');
	}
	
	public function getMusic(musicId:Int):String
	{
		var filename = musics[musicId];
		return Assets.getPath('assets/music/$filename');
	}
	
	public function getSound(soundId:Int):String
	{
		var filename = sounds[soundId];
		return Assets.getPath('assets/sounds/$filename');
	}
}