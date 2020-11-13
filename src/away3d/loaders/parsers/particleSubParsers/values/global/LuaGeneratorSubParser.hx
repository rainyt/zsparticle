package away3d.loaders.parsers.particleSubParsers.values.global;

import away3d.loaders.parsers.particleSubParsers.AllIdentifiers;
import away3d.loaders.parsers.particleSubParsers.values.ValueSubParserBase;
import away3d.loaders.parsers.particleSubParsers.values.setters.global.LuaGeneratorSetter;

class LuaGeneratorSubParser extends ValueSubParserBase
{
    public static var identifier(get, never) : Dynamic;

    public function new(propName : String)
    {
        super(propName, ValueSubParserBase.VARIABLE_VALUE);
    }
    
    override public function parseAsync(data : Dynamic, frameLimit : Float = 30) : Void
    {
        super.parseAsync(data, frameLimit);
        _setter = new LuaGeneratorSetter(_propName, _data.code);
    }
    
    private static function get_identifier() : Dynamic
    {
        return AllIdentifiers.LuaGeneratorSubParser;
    }
}

