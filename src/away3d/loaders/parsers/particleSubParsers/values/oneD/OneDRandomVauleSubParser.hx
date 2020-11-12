package away3d.loaders.parsers.particleSubParsers.values.oneD;

import away3d.loaders.parsers.particleSubParsers.AllIdentifiers;
import away3d.loaders.parsers.particleSubParsers.values.ValueSubParserBase;
import away3d.loaders.parsers.particleSubParsers.values.setters.oneD.OneDRandomSetter;

/**
	 * ...
	 */
class OneDRandomVauleSubParser extends ValueSubParserBase
{
    public static var identifier(get, never) : Dynamic;

    
    public function new(propName : String)
    {
        super(propName, ValueSubParserBase.VARIABLE_VALUE);
    }
    
    override public function parseAsync(data : Dynamic, frameLimit : Int = 30) : Void
    {
        super.parseAsync(data, frameLimit);
        _setter = new OneDRandomSetter(_propName, _data.min, _data.max);
    }
    
    private static function get_identifier() : Dynamic
    {
        return AllIdentifiers.OneDRandomVauleSubParser;
    }
}


