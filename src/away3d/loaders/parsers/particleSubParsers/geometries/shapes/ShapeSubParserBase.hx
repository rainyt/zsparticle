package away3d.loaders.parsers.particleSubParsers.geometries.shapes;

import away3d.core.base.Geometry;
import away3d.errors.AbstractMethodError;
import away3d.loaders.parsers.CompositeParserBase;

class ShapeSubParserBase extends CompositeParserBase
{
    public function new()
    {
        super();
    }
    
    public function getGeometry() : Geometry
    {
        throw (new AbstractMethodError());
    }
}


