package away3d.loaders.parsers.particleSubParsers.nodes;

import away3d.animators.data.ParticlePropertiesMode;
import away3d.animators.nodes.ParticleScaleNode;
import away3d.loaders.parsers.particleSubParsers.AllIdentifiers;
import away3d.loaders.parsers.particleSubParsers.AllSubParsers;
import away3d.loaders.parsers.particleSubParsers.utils.MatchingTool;
import away3d.loaders.parsers.particleSubParsers.values.ValueSubParserBase;
import openfl.geom.Vector3D;

class ParticleScaleNodeSubParser extends ParticleNodeSubParserBase
{
    public static var identifier(get, never) : Dynamic;

    private var _scaleValue : ValueSubParserBase;
    private var _usesCycle : Bool;
    private var _usesPhase : Bool;
    
    
    public function new()
    {
        super();
    }
    
    override private function proceedParsing() : Bool
    {
        if (_isFirstParsing)
        {
            _usesCycle = _data.usesCycle;
            _usesPhase = _data.usesPhase;
            var object : Dynamic = _data.scale;
            var Id : Dynamic = object.id;
            var subData : Dynamic = object.data;
            var valueCls : Class<Dynamic> = MatchingTool.getMatchedClass(Id, AllSubParsers.ALL_FOURD_VALUES);
            if (valueCls == null)
            {
                dieWithError("Unknown value");
            }
            _scaleValue = Type.createInstance(valueCls, [ParticleScaleNode.SCALE_VECTOR3D]);
            addSubParser(_scaleValue);
            _scaleValue.parseAsync(subData);
        }
        
        if (super.proceedParsing() == ParserBase.PARSING_DONE)
        {
            initProps();
            return ParserBase.PARSING_DONE;
        }
        else
        {
            return ParserBase.MORE_TO_PARSE;
        }
    }
    
    private function initProps() : Void
    {
        if (_scaleValue.valueType == ValueSubParserBase.CONST_VALUE)
        {
            var scale : Vector3D = _scaleValue.setter.generateOneValue();
            _particleAnimationNode = new ParticleScaleNode(ParticlePropertiesMode.GLOBAL, _usesCycle, _usesPhase, scale.x, scale.y, scale.z, scale.w);
        }
        else
        {
            _particleAnimationNode = new ParticleScaleNode(ParticlePropertiesMode.LOCAL_STATIC, _usesCycle, _usesPhase);
            _setters.push(_scaleValue.setter);
        }
    }
    
    private static function get_identifier() : Dynamic
    {
        return AllIdentifiers.ParticleScaleNodeSubParser;
    }
}

