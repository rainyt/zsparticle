package away3d.loaders.parsers;

import away3d.core.base.ParticleGeometry;
import away3d.loaders.parsers.particleSubParsers.AllSubParsers;
import away3d.loaders.parsers.particleSubParsers.geometries.GeometrySubParserBase;
import away3d.loaders.parsers.particleSubParsers.utils.MatchingTool;


class ParticleGeometryParser extends CompositeParserBase
{
    public var particleGeometry(get, never) : ParticleGeometry;

    
    private var _assembler : GeometrySubParserBase;
    
    public function new()
    {
        super();
    }
    
    public static function supportsType(extension : String) : Bool
    {
        extension = extension.toLowerCase();
        return extension == "pag";
    }
    
    public static function supportsData(data : Dynamic) : Bool
    {
        return false;
    }
    
    private function get_particleGeometry() : ParticleGeometry
    {
        return _assembler.particleGeometry;
    }
    
    override private function proceedParsing() : Bool
    {
        if (_isFirstParsing)
        {
            var assemblerData : Dynamic = _data.assembler.data;
            var assemblerId : Dynamic = _data.assembler.id;
            var parserCls : Class<Dynamic> = MatchingTool.getMatchedClass(assemblerId, AllSubParsers.ALL_GEOMETRIES);
            
            if (parserCls == null)
            {
                dieWithError("Unknown geometry assembler");
            }
            
            _assembler = Type.createInstance(parserCls, []);
            addSubParser(_assembler);
            _assembler.parseAsync(assemblerData);
        }
        
        return super.proceedParsing();
    }
}


