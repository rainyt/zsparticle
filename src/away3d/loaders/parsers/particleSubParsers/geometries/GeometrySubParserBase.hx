package away3d.loaders.parsers.particleSubParsers.geometries;

import away3d.core.base.ParticleGeometry;
import away3d.errors.AbstractMethodError;
import away3d.loaders.parsers.CompositeParserBase;

class GeometrySubParserBase extends CompositeParserBase
{
    public var particleGeometry(get, never) : ParticleGeometry;

    private var _numParticles : Int;
    
    public function new()
    {
        super();
    }
    
    override public function parseAsync(data : Dynamic, frameLimit : Float = 30) : Void
    {
        super.parseAsync(data, frameLimit);
        _numParticles = _data.num;
    }
    
    private function get_particleGeometry() : ParticleGeometry
    {
        throw (new AbstractMethodError());
    }
}


