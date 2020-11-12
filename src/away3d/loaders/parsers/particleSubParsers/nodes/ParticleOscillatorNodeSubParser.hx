package away3d.loaders.parsers.particleSubParsers.nodes;

import away3d.animators.data.ParticlePropertiesMode;
import away3d.animators.nodes.ParticleOscillatorNode;
import away3d.loaders.parsers.particleSubParsers.AllIdentifiers;
import away3d.loaders.parsers.particleSubParsers.values.ValueSubParserBase;
import away3d.loaders.parsers.particleSubParsers.values.fourD.FourDCompositeWithThreeDValueSubParser;

class ParticleOscillatorNodeSubParser extends ParticleNodeSubParserBase
{
    public static var identifier(get, never) : Dynamic;

    private var _oscillatorValue : FourDCompositeWithThreeDValueSubParser;
    
    public function new()
    {
        super();
    }
    
    override private function proceedParsing() : Bool
    {
        if (_isFirstParsing)
        {
            var object : Dynamic = _data.oscillator;
            var Id : Dynamic = object.id;
            var subData : Dynamic = object.data;
            _oscillatorValue = new FourDCompositeWithThreeDValueSubParser(ParticleOscillatorNode.OSCILLATOR_VECTOR3D);
            addSubParser(_oscillatorValue);
            _oscillatorValue.parseAsync(subData);
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
        if (_oscillatorValue.valueType == ValueSubParserBase.CONST_VALUE)
        {
            _particleAnimationNode = new ParticleOscillatorNode(ParticlePropertiesMode.GLOBAL, _oscillatorValue.setter.generateOneValue());
        }
        else
        {
            _particleAnimationNode = new ParticleOscillatorNode(ParticlePropertiesMode.LOCAL_STATIC);
            _setters.push(_oscillatorValue.setter);
        }
    }
    
    private static function get_identifier() : Dynamic
    {
        return AllIdentifiers.ParticleOscillatorNodeSubParser;
    }
}

