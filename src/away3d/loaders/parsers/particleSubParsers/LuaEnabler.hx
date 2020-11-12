package away3d.loaders.parsers.particleSubParsers;

import away3d.loaders.parsers.particleSubParsers.values.global.LuaGeneratorSubParser;
import away3d.loaders.parsers.particleSubParsers.values.oneD.LuaExtractSubParser;

class LuaEnabler
{
    private static var enable : Bool = false;
    
    public static function enableLua() : Void
    {
        if (!enable)
        {
            AllSubParsers.ALL_GLOBAL_VALUES.push(LuaGeneratorSubParser);
            AllSubParsers.ALL_ONED_VALUES.push(LuaExtractSubParser);
            enable = true;
        }
    }

    public function new()
    {
    }
}

