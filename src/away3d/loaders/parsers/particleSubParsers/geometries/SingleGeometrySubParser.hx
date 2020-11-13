package away3d.loaders.parsers.particleSubParsers.geometries;


import away3d.loaders.parsers.particleSubParsers.values.matrix.Matrix3DCompositeValueSubParser;
import away3d.core.base.Geometry;
import away3d.core.base.ParticleGeometry;
import away3d.loaders.parsers.particleSubParsers.AllIdentifiers;
import away3d.loaders.parsers.particleSubParsers.AllSubParsers;
import away3d.loaders.parsers.particleSubParsers.geometries.shapes.ShapeSubParserBase;
import away3d.loaders.parsers.particleSubParsers.utils.MatchingTool;
import away3d.loaders.parsers.particleSubParsers.values.ValueSubParserBase;
import away3d.loaders.parsers.particleSubParsers.values.matrix.Matrix2DUVCompositeValueSubParser;
import away3d.loaders.parsers.particleSubParsers.values.setters.SetterBase;
import away3d.tools.helpers.ParticleGeometryHelper;
import away3d.tools.helpers.data.ParticleGeometryTransform;

class SingleGeometrySubParser extends GeometrySubParserBase
{
    public static var identifier(get, never) : Dynamic;

    
    private var _shape : ShapeSubParserBase;
    private var _vertexTransformValue : ValueSubParserBase;
    private var _uvTransformValue : ValueSubParserBase;
    private var _particleGeometry : ParticleGeometry;
    
    public function new()
    {
        super();
    }
    
    override private function proceedParsing() : Bool
    {
        if (_isFirstParsing)
        {
            var object : Dynamic;
            var Id : Dynamic;
            var subData : Dynamic;
            var valueCls : Class<Dynamic>;
            var cls : Class<Dynamic>;
            
            object = _data.vertexTransform;
            if (object != null)
            {
                Id = object.id;
                subData = object.data;
                valueCls = MatchingTool.getMatchedClass(Id, AllSubParsers.ALL_MATRIX3DS);
                if (valueCls == null)
                {
                    dieWithError("Unknown value");
                }
                _vertexTransformValue = Type.createInstance(valueCls, [null]);
                addSubParser(_vertexTransformValue);
                _vertexTransformValue.parseAsync(subData);
            }
            
            object = _data.uvTransformValue;
            if (object != null)
            {
                Id = object.id;
                subData = object.data;
                _uvTransformValue = new Matrix2DUVCompositeValueSubParser(null);
                addSubParser(_uvTransformValue);
                _uvTransformValue.parseAsync(subData);
            }
            
            
            object = _data.shape;
            Id = object.id;
            subData = object.data;
            valueCls = MatchingTool.getMatchedClass(Id, AllSubParsers.ALL_SHAPES);
            _shape = Type.createInstance(valueCls, []);
            addSubParser(_shape);
            _shape.parseAsync(subData);
        }
        if (super.proceedParsing() == ParserBase.PARSING_DONE)
        {
            generateParticleGeometry();
            finalizeAsset(_particleGeometry);
            return ParserBase.PARSING_DONE;
        }
        else
        {
            return ParserBase.MORE_TO_PARSE;
        }
    }
    
    private function generateParticleGeometry() : Void
    {
        var geometry : Geometry = _shape.getGeometry();
        var vector : openfl.Vector<Geometry> = new openfl.Vector<Geometry>();
        var i : Int = 0;
        while (i < _numParticles)
        {
            vector[i] = geometry;
            i++;
        }
        var transforms : openfl.Vector<ParticleGeometryTransform> = null;
        if (_vertexTransformValue != null || _uvTransformValue != null)
        {
            var vertexSetter : SetterBase = (_vertexTransformValue != null) ? _vertexTransformValue.setter : null;
            var uvSetter : SetterBase = (_uvTransformValue != null) ? _uvTransformValue.setter : null;
            
            transforms = new openfl.Vector<ParticleGeometryTransform>();
            var _geometryTransform : ParticleGeometryTransform;
            for (i in 0..._numParticles)
            {
                _geometryTransform = new ParticleGeometryTransform();
                if (vertexSetter != null)
                {
                    _geometryTransform.vertexTransform = vertexSetter.generateOneValue(i, _numParticles);
                }
                if (uvSetter != null)
                {
                    _geometryTransform.UVTransform = uvSetter.generateOneValue(i, _numParticles);
                }
                transforms[i] = _geometryTransform;
            }
        }
        _particleGeometry = ParticleGeometryHelper.generateGeometry(vector, transforms);
    }
    
    override private function get_particleGeometry() : ParticleGeometry
    {
        return _particleGeometry;
    }
    
    private static function get_identifier() : Dynamic
    {
        return AllIdentifiers.SingleGeometrySubParser;
    }
}


