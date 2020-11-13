package away3d.loaders.parsers.particleSubParsers.values.threeD;

import away3d.loaders.parsers.particleSubParsers.AllIdentifiers;
import away3d.loaders.parsers.particleSubParsers.values.ValueSubParserBase;
import away3d.loaders.parsers.particleSubParsers.values.setters.threeD.ThreeDSphereSetter;

class ThreeDSphereValueSubParser extends ValueSubParserBase
{
    public static var identifier(get, never) : Dynamic;

    public function new(propName : String)
    {
        super(propName, ValueSubParserBase.VARIABLE_VALUE);
    }
    
    override public function parseAsync(data : Dynamic, frameLimit : Float = 30) : Void
    {
        super.parseAsync(data, frameLimit);
        _setter = new ThreeDSphereSetter(_propName, _data.innerRadius, _data.outerRadius, _data.centerX, _data.centerY, _data.centerZ);
    }
    
    private static function get_identifier() : Dynamic
    {
        return AllIdentifiers.ThreeDSphereValueSubParser;
    }
}


