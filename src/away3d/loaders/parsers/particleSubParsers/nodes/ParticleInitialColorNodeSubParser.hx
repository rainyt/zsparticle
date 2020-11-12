package away3d.loaders.parsers.particleSubParsers.nodes;

import away3d.animators.data.ParticlePropertiesMode;
import away3d.animators.nodes.ParticleInitialColorNode;
import away3d.loaders.parsers.particleSubParsers.AllIdentifiers;
import away3d.loaders.parsers.particleSubParsers.values.ValueSubParserBase;
import away3d.loaders.parsers.particleSubParsers.values.color.CompositeColorValueSubParser;

class ParticleInitialColorNodeSubParser extends ParticleNodeSubParserBase
{
    public static var identifier(get, never) : Dynamic;

    private var _colorValue : CompositeColorValueSubParser;
    
    
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
            
            object = _data.color;
            Id = object.id;
            subData = object.data;
            _colorValue = new CompositeColorValueSubParser(ParticleInitialColorNode.COLOR_INITIAL_COLORTRANSFORM);
            addSubParser(_colorValue);
            _colorValue.parseAsync(subData);
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
        if (_colorValue.valueType == ValueSubParserBase.CONST_VALUE)
        {
            _particleAnimationNode = new ParticleInitialColorNode(ParticlePropertiesMode.GLOBAL, _colorValue.usesMultiplier, _colorValue.usesOffset, _colorValue.setter.generateOneValue());
        }
        else
        {
            _particleAnimationNode = new ParticleInitialColorNode(ParticlePropertiesMode.LOCAL_STATIC, _colorValue.usesMultiplier, _colorValue.usesOffset);
            _setters.push(_colorValue.setter);
        }
    }
    
    private static function get_identifier() : Dynamic
    {
        return AllIdentifiers.ParticleInitialColorNodeSubParser;
    }
}

