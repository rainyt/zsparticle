package away3d.loaders.parsers.particleSubParsers.nodes;

import away3d.animators.data.ParticlePropertiesMode;
import away3d.animators.nodes.ParticleColorNode;
import away3d.loaders.parsers.particleSubParsers.AllIdentifiers;
import away3d.loaders.parsers.particleSubParsers.values.ValueSubParserBase;
import away3d.loaders.parsers.particleSubParsers.values.color.CompositeColorValueSubParser;
import away3d.loaders.parsers.particleSubParsers.values.oneD.OneDConstValueSubParser;

class ParticleColorNodeSubParser extends ParticleNodeSubParserBase
{
    public static var identifier(get, never) : Dynamic;

    private var _startColorValue : CompositeColorValueSubParser;
    private var _endColorValue : CompositeColorValueSubParser;
    private var _cycleDurationValue : OneDConstValueSubParser;
    private var _cyclePhaseValue : OneDConstValueSubParser;
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
            
            
            var object : Dynamic;
            var Id : Dynamic;
            var subData : Dynamic;
            
            _usesCycle = _data.usesCycle;
            if (_usesCycle)
            {
                object = _data.cycleDuration;
                Id = object.id;
                subData = object.data;
                _cycleDurationValue = new OneDConstValueSubParser(null);
                addSubParser(_cycleDurationValue);
                _cycleDurationValue.parseAsync(subData);
            }
            _usesPhase = _data.usesPhase;
            if (_usesPhase)
            {
                object = _data.cyclePhase;
                Id = object.id;
                subData = object.data;
                _cyclePhaseValue = new OneDConstValueSubParser(null);
                addSubParser(_cyclePhaseValue);
                _cyclePhaseValue.parseAsync(subData);
            }
            
            object = _data.startColor;
            Id = object.id;
            subData = object.data;
            _startColorValue = new CompositeColorValueSubParser(ParticleColorNode.COLOR_START_COLORTRANSFORM);
            addSubParser(_startColorValue);
            _startColorValue.parseAsync(subData);
            
            object = _data.endColor;
            Id = object.id;
            subData = object.data;
            _endColorValue = new CompositeColorValueSubParser(ParticleColorNode.COLOR_END_COLORTRANSFORM);
            addSubParser(_endColorValue);
            _endColorValue.parseAsync(subData);
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
        var cycleDuration : Float = 1;
        var cyclePhase : Float = 0;
        if (_usesCycle)
        {
            cycleDuration = _cycleDurationValue.setter.generateOneValue();
            if (_usesPhase)
            {
                cyclePhase = _cyclePhaseValue.setter.generateOneValue();
            }
        }

        if (_startColorValue.valueType == ValueSubParserBase.CONST_VALUE && _endColorValue.valueType == ValueSubParserBase.CONST_VALUE)
        {
            _particleAnimationNode = new ParticleColorNode(ParticlePropertiesMode.GLOBAL, _startColorValue.usesMultiplier, _startColorValue.usesOffset, _usesCycle, _usesPhase, _startColorValue.setter.generateOneValue(), _endColorValue.setter.generateOneValue(), cycleDuration, cyclePhase);
        }
        else
        {
            _particleAnimationNode = new ParticleColorNode(ParticlePropertiesMode.LOCAL_STATIC, _startColorValue.usesMultiplier, _startColorValue.usesOffset, _usesCycle, _usesPhase, null, null, cycleDuration, cyclePhase);
            _setters.push(_startColorValue.setter);
            _setters.push(_endColorValue.setter);
        }
    }
    
    private static function get_identifier() : Dynamic
    {
        return AllIdentifiers.ParticleColorNodeSubParser;
    }
}

