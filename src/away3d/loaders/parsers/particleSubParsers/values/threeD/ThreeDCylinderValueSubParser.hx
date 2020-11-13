package away3d.loaders.parsers.particleSubParsers.values.threeD;

import away3d.loaders.parsers.particleSubParsers.AllIdentifiers;
import away3d.loaders.parsers.particleSubParsers.values.ValueSubParserBase;
import away3d.loaders.parsers.particleSubParsers.values.setters.threeD.ThreeDCylinderSetter;

class ThreeDCylinderValueSubParser extends ValueSubParserBase
{
    public static var identifier(get, never) : Dynamic;

    public function new(propName : String)
    {
        super(propName, ValueSubParserBase.VARIABLE_VALUE);
    }
    
    override public function parseAsync(data : Dynamic, frameLimit : Float = 30) : Void
    {
        super.parseAsync(data, frameLimit);
        _setter = new ThreeDCylinderSetter(_propName, _data.innerRadius, _data.outerRadius, _data.height, _data.centerX, _data.centerY, _data.centerZ, _data.dX, _data.dY, _data.dZ);
    }
    
    private static function get_identifier() : Dynamic
    {
        return AllIdentifiers.ThreeDCylinderValueSubParser;
    }
}


