package away3d.loaders.parsers.particleSubParsers.values.oneD;

import away3d.loaders.parsers.particleSubParsers.AllIdentifiers;
import away3d.loaders.parsers.particleSubParsers.values.ValueSubParserBase;
import away3d.loaders.parsers.particleSubParsers.values.setters.oneD.LuaExtractSetter;

class LuaExtractSubParser extends ValueSubParserBase
{
    public static var identifier(get, never) : Dynamic;

    public function new(propName : String)
    {
        super(propName, ValueSubParserBase.VARIABLE_VALUE);
    }
    
    override public function parseAsync(data : Dynamic, frameLimit : Int = 30) : Void
    {
        super.parseAsync(data, frameLimit);
        _setter = new LuaExtractSetter(_propName, _data.value);
    }
    
    private static function get_identifier() : Dynamic
    {
        return AllIdentifiers.LuaExtractSubParser;
    }
}

