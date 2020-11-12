package away3d.loaders.parsers.particleSubParsers.nodes;

import away3d.animators.data.ParticlePropertiesMode;
import away3d.animators.nodes.ParticlePositionNode;
import away3d.loaders.parsers.particleSubParsers.AllIdentifiers;
import away3d.loaders.parsers.particleSubParsers.AllSubParsers;
import away3d.loaders.parsers.particleSubParsers.utils.MatchingTool;
import away3d.loaders.parsers.particleSubParsers.values.ValueSubParserBase;

class ParticlePositionNodeSubParser extends ParticleNodeSubParserBase
{
    public static var identifier(get, never) : Dynamic;

    private var _positionValue : ValueSubParserBase;
    
    public function new()
    {
        super();
    }
    
    override private function proceedParsing() : Bool
    {
        if (_isFirstParsing)
        {
            var object : Dynamic = _data.position;
            var Id : Dynamic = object.id;
            var subData : Dynamic = object.data;
            
            var valueCls : Class<Dynamic> = MatchingTool.getMatchedClass(Id, AllSubParsers.ALL_THREED_VALUES);
            if (valueCls == null)
            {
                dieWithError("Unknown value");
            }
            _positionValue = Type.createInstance(valueCls, [ParticlePositionNode.POSITION_VECTOR3D]);
            addSubParser(_positionValue);
            _positionValue.parseAsync(subData);
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
        if (_positionValue.valueType == ValueSubParserBase.CONST_VALUE)
        {
            _particleAnimationNode = new ParticlePositionNode(ParticlePropertiesMode.GLOBAL, _positionValue.setter.generateOneValue());
        }
        else
        {
            _particleAnimationNode = new ParticlePositionNode(ParticlePropertiesMode.LOCAL_STATIC);
            _setters.push(_positionValue.setter);
        }
    }
    
    private static function get_identifier() : Dynamic
    {
        return AllIdentifiers.ParticlePositionNodeSubParser;
    }
}

