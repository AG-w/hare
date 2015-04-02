package rpg.map;

import haxe.xml.Fast;
import rpg.geom.Point;

/**
 * Last modified 10/3/2013 by Samuel Batista
 * (original by Matt Tuttle based on Thomas Jahn's. Haxe port by Adrien Fischer)
 * This content is released under the MIT License.
 */
class TiledObject
{
	/**
	 * Use these to determine whether a sprite should be flipped, for example:
	 * 
	 * var flipped:Bool = cast (oject.gid & TiledObject.FLIPPED_HORIZONTALLY_FLAG);
	 * sprite.facing = flipped ? FlxObject.LEFT : FlxObject.RIGHT;
	 */
	public static inline var FLIPPED_VERTICALLY_FLAG = 0x40000000;
	public static inline var FLIPPED_HORIZONTALLY_FLAG = 0x80000000;
	
	public static inline var RECTANGLE = 0;
	public static inline var ELLIPSE = 1;
	public static inline var POLYGON = 2;
	public static inline var POLYLINE = 3;
	public static inline var TILE = 4;
	
	public var id:Int;
	public var x:Int;
	public var y:Int;
	public var width:Int;
	public var height:Int;
	public var name:String;
	public var type:String;
	public var xmlData:Fast;
	/** 
	 * In degrees
	 */
	public var angle:Float;
	/**
	 * Global identifier for this object
	 */
	public var gid:Int;
	/**
	 * Custom properties that users can set on this object
	 */
	public var custom:TiledPropertySet;
	/** 
	 * Shared properties are tileset properties added on object tile
	 */ 
	public var shared:TiledPropertySet;
	/**
	 * Information on the group or "Layer" that contains this object
	 */
	public var group:TiledObjectGroup;
	/**
	 * The type of the object (RECTANGLE, ELLIPSE, POLYGON, POLYLINE, TILE)
	 */
	public var objectType(default, null):Int;
	/**
	 * Whether the object is flipped horizontally.
	 */
	public var flippedHorizontally(get, null):Bool;
	/**
	 * Whether the object is flipped vertically.
	 */
	public var flippedVertically(get, null):Bool;
	/**
	 * An array with points if the object is a POLYGON or POLYLINE
	 */
	public var points:Array<Point>;
	
	public function new(source:Fast, parent:TiledObjectGroup)
	{
		xmlData = source;
		group = parent;
		name = (source.has.name) ? source.att.name : "[object]";
		type = (source.has.type) ? source.att.type : parent.name;
		id = Std.parseInt(source.att.id);
		x = Std.parseInt(source.att.x);
		y = Std.parseInt(source.att.y);
		width = (source.has.width) ? Std.parseInt(source.att.width) : 0;
		height = (source.has.height) ? Std.parseInt(source.att.height) : 0;
		angle = (source.has.rotation) ? Std.parseFloat(source.att.rotation) : 0;
		// By default let's it be a rectangle object
		objectType = RECTANGLE;
		
		// resolve inheritence
		shared = null;
		gid = -1;
		
		// object with tile association?
		if (source.has.gid && source.att.gid.length != 0) 
		{
			gid = Std.parseInt(source.att.gid);
			
			for (set in group.map.tilesets)
			{
				shared = set.getPropertiesByGid(gid);
				
				if (shared != null)
				{
					break;
				}
			}
			// If there is a gid it means that it's a tile object
			objectType = TILE;
		}
		
		// load properties
		custom = new TiledPropertySet();
		
		for (node in source.nodes.properties)
		{
			custom.extend(node);
		}
		
		// Let's see if it's another object
		if (source.hasNode.ellipse) {
			objectType = ELLIPSE;
		} else if (source.hasNode.polygon) {
			objectType = POLYGON;
			getPoints(source.node.polygon);
		} else if (source.hasNode.polyline) {
			objectType = POLYLINE;
			getPoints(source.node.polyline);
		}
	}
	
	private function getPoints(node:Fast):Void 
	{
		points = [];
		
		var pointsStr = node.att.points.split(" ");
		for (p in pointsStr) {
			var pair = p.split(",");
			points.push(new Point(Std.parseFloat(pair[0]), Std.parseFloat(pair[1])));
		}
	}
	
	/**
	 * Property accessors
	 */
	private inline function get_flippedHorizontally():Bool
	{
		return cast (gid & FLIPPED_HORIZONTALLY_FLAG);
	}
	
	private inline function get_flippedVertically():Bool
	{
		return cast (gid & FLIPPED_VERTICALLY_FLAG);
	}
}
