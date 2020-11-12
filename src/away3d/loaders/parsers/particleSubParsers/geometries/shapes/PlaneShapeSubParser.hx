package away3d.loaders.parsers.particleSubParsers.geometries.shapes;


import away3d.core.base.Geometry;
import away3d.loaders.parsers.particleSubParsers.AllIdentifiers;
import away3d.primitives.PlaneGeometry;

class PlaneShapeSubParser extends ShapeSubParserBase
{
    public static var identifier(get, never) : Dynamic;

    private var _geometry : PlaneGeometry;
    
    public function new()
    {
        super();
        _geometry = new PlaneGeometry(10, 10, 1, 1, false);
    }
    
    override public function getGeometry() : Geometry
    {
        return _geometry;
    }
    
    override private function proceedParsing() : Bool
    {
        if (_isFirstParsing)
        {
            _geometry.width = _data.width;
            _geometry.height = _data.height;
        }
        return super.proceedParsing();
    }
    
    private static function get_identifier() : Dynamic
    {
        return AllIdentifiers.PlaneShapeSubParser;
    }
}


