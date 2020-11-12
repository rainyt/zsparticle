package away3d.loaders.parsers.particleSubParsers.geometries.shapes;


import away3d.core.base.Geometry;
import away3d.loaders.parsers.particleSubParsers.AllIdentifiers;
import away3d.primitives.SphereGeometry;

class SphereShapeSubParser extends ShapeSubParserBase
{
    public static var identifier(get, never) : Dynamic;

    private var _geometry : SphereGeometry;
    
    public function new()
    {
        super();
        _geometry = new SphereGeometry(10, 8, 8);
    }
    
    override public function getGeometry() : Geometry
    {
        return _geometry;
    }
    
    override private function proceedParsing() : Bool
    {
        if (_isFirstParsing)
        {
            _geometry.radius = _data.radius;
            _geometry.segmentsW = _data.segmentsW;
            _geometry.segmentsH = _data.segmentsH;
        }
        return super.proceedParsing();
    }
    
    private static function get_identifier() : Dynamic
    {
        return AllIdentifiers.SphereShapeSubParser;
    }
}


