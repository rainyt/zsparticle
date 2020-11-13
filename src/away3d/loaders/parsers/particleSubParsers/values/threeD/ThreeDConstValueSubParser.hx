package away3d.loaders.parsers.particleSubParsers.values.threeD;

import away3d.loaders.parsers.particleSubParsers.AllIdentifiers;
import away3d.loaders.parsers.particleSubParsers.values.ValueSubParserBase;
import away3d.loaders.parsers.particleSubParsers.values.setters.threeD.ThreeDConstSetter;
import openfl.geom.Vector3D;

/**
	 * ...
	 */
class ThreeDConstValueSubParser extends ValueSubParserBase
{
    public static var identifier(get, never) : Dynamic;

    
    public function new(propName : String)
    {
        super(propName, ValueSubParserBase.CONST_VALUE);
    }
    
    override public function parseAsync(data : Dynamic, frameLimit : Float = 30) : Void
    {
        super.parseAsync(data, frameLimit);
        _setter = new ThreeDConstSetter(_propName, new Vector3D(_data.x, _data.y, _data.z));
    }
    
    private static function get_identifier() : Dynamic
    {
        return AllIdentifiers.ThreeDConstValueSubParser;
    }
}


