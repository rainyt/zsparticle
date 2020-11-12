package away3d.loaders.parsers.particleSubParsers.geometries.shapes;


import away3d.core.base.Geometry;
import away3d.loaders.parsers.particleSubParsers.AllIdentifiers;
import away3d.primitives.CubeGeometry;

class CubeShapeSubParser extends ShapeSubParserBase
{
    public static var identifier(get, never) : Dynamic;

    private var _geometry : CubeGeometry;
    
    public function new()
    {
        super();
        _geometry = new CubeGeometry(10, 10, 10);
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
            _geometry.depth = _data.depth;
        }
        return super.proceedParsing();
    }
    
    private static function get_identifier() : Dynamic
    {
        return AllIdentifiers.CubeShapeSubParser;
    }
}


