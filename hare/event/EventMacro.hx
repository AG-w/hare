package hare.event;
import haxe.io.Path;
import haxe.macro.Context;
import haxe.macro.Expr;
import StringTools;
#if sys
import sys.FileSystem;
import sys.io.File;
#end
/**
 * ...
 * @author Kevin
 */
class EventMacro
{
	macro public static function getBridgeScript():Expr
	{
		var s = new StringBuf();
		var p = Context.resolvePath("assets/engine/script/bridge.lua");
		p = Path.normalize(p);
		p = StringTools.replace(p,"bridge.lua","");
		
		for (f in FileSystem.readDirectory(p))
		{
			s.add(" ");
			s.add(File.getContent(p + "/" + f));
		}
		
		s.add(" return true");
		
		return macro $v{s.toString()};
	}
}