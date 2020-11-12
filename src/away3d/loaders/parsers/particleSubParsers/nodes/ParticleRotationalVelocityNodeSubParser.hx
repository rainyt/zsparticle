package away3d.loaders.parsers.particleSubParsers.nodes;

import away3d.animators.data.ParticlePropertiesMode;
import away3d.animators.nodes.ParticleRotationalVelocityNode;
import away3d.loaders.parsers.particleSubParsers.AllIdentifiers;
import away3d.loaders.parsers.particleSubParsers.values.ValueSubParserBase;
import away3d.loaders.parsers.particleSubParsers.values.fourD.FourDCompositeWithThreeDValueSubParser;

class ParticleRotationalVelocityNodeSubParser extends ParticleNodeSubParserBase
{
    public static var identifier(get, never) : Dynamic;

    private var _rotationValue : FourDCompositeWithThreeDValueSubParser;
    
    public function new()
    {
        super();
    }
    
    override private function proceedParsing() : Bool
    {
        if (_isFirstParsing)
        {
            var object : Dynamic = _data.rotation;
            var Id : Dynamic = object.id;
            var subData : Dynamic = object.data;
            _rotationValue = new FourDCompositeWithThreeDValueSubParser(ParticleRotationalVelocityNode.ROTATIONALVELOCITY_VECTOR3D);
            addSubParser(_rotationValue);
            _rotationValue.parseAsync(subData);
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
        if (_rotationValue.valueType == ValueSubParserBase.CONST_VALUE)
        {
            _particleAnimationNode = new ParticleRotationalVelocityNode(ParticlePropertiesMode.GLOBAL, _rotationValue.setter.generateOneValue());
        }
        else
        {
            _particleAnimationNode = new ParticleRotationalVelocityNode(ParticlePropertiesMode.LOCAL_STATIC);
            _setters.push(_rotationValue.setter);
        }
    }
    
    private static function get_identifier() : Dynamic
    {
        return AllIdentifiers.ParticleRotationalVelocityNodeSubParser;
    }
}

