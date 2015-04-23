package rpg.config;
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;
import haxe.macro.Type.ClassField;

using haxe.macro.ExprTools;

/**
 * ...
 * @author Kevin
 */
class ConfigMacro
{
	macro public static function checkConfig(data:Expr, typePath:String):Expr
	{
		var configDataType = Context.getType(typePath);
		var fields = getFields(configDataType);
		return genCheckFieldsExpr(data, fields);
	}
	
	private static function genCheckFieldsExpr(expr:Expr, fields:Array<ClassField>, ?fromFieldName:String = ""):Expr
	{
		var exprs = [];
		for (field in fields)
		{
			var name = field.name;
			var type = field.type;
			
			// check if the field is optional
			var optional = isNullType(field.type);
			
			var isArray = switch (field.type) 
			{
				case TInst(t, param):
					if (t.get().name == "Array")
					{
						type = param[0];
						true;
					}
					else
						false;
				default:
					false;
			}
			
			// check if this field is an anon object (or Array of anon object)
			var nestedFields = getFields(type);
			var isAnonObj = nestedFields != null;
			
			// expr for checking if the field is missing
			var verboseName = fromFieldName + name;
			var optionalErrorMessage = "optional field: " + verboseName + " missing";
			var errorMessage = "non-optional field: " + verboseName + " missing";
			var missingCheck = optional ? macro trace($v{optionalErrorMessage}) : macro trace($v{errorMessage});
			
			if(isArray)
				verboseName += "[n]";
			verboseName += ".";
				
			// expr for checking the nested fields if current field is also an anon object
			var nestedFieldCheck =
				if (isAnonObj)
				{
					if (isArray)
						macro for($i{name} in cast($expr.$name, Array<Dynamic>)) ${genCheckFieldsExpr(macro $i{name}, nestedFields, verboseName)};
						
					else
						genCheckFieldsExpr(macro $expr.$name, nestedFields, verboseName);
				}
				else
					null;
			
			
			if (optional)
			{
				if (isAnonObj)
				{
					exprs.push(macro if ($expr.$name == null) $missingCheck else $nestedFieldCheck);
				}
				else
					exprs.push(macro if ($expr.$name == null) $missingCheck);
			}
			else
			{
				exprs.push(macro if ($expr.$name == null) $missingCheck);
				if (isAnonObj)
					exprs.push(nestedFieldCheck);
			}
		}
		
		return macro $b{exprs};
	}
	
	/**
	 * Return the fields of an anonymous object. If `type` does not defines an anonymous object, return null.
	 * @param	type
	 * @return
	 */
	private static function getFields(type:Type):Array<ClassField>
	{
		return switch (type) 
		{
			case TType(t, param):
				// if a field is declared as optional, its type will be wrapped with Null (e.g. `?myField:Int` becomes `myField:Null<Int>`)
				// so we need to extract that wrapped type
				if (t.get().name == "Null") 
					getFields(param[0]);
				else
					getFields(t.get().type);
				
			case TAnonymous(a):
				a.get().fields;
				
			default:
				null;
		}
	}
	
	private static function isNullType(type:Type):Bool
	{
		return switch (type) 
		{
			case TType(t, _):
				t.get().name == "Null";
			default:
				false;
		}
	}
}