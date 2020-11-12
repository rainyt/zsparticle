package away3d.loaders.parsers.particleSubParsers.geometries.shapes;

import away3d.core.base.Geometry;
import away3d.loaders.parsers.particleSubParsers.AllIdentifiers;
import away3d.primitives.CylinderGeometry;

class CylinderShapeSubParser extends ShapeSubParserBase
{
    public static var identifier(get, never) : Dynamic;

    private var _geometry : CylinderGeometry;
    
    public function new()
    {
        super();
        _geometry = new CylinderGeometry(10, 10, 10);
    }
    
    override public function getGeometry() : Geometry
    {
        return _geometry;
    }
    
    override private function proceedParsing() : Bool
    {
        if (_isFirstParsing)
        {
            _geometry = new CylinderGeometry(_data.topRadius, _data.bottomRadius, _data.height, _data.segmentsW, 1, _data.topClosed, _data.bottomClosed);
        }
        return super.proceedParsing();
    }
    
    private static function get_identifier() : Dynamic
    {
        return AllIdentifiers.CylinderShapeSubParser;
    }
}

