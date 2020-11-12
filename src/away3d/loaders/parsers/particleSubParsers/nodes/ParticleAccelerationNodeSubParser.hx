package away3d.loaders.parsers.particleSubParsers.nodes;

import away3d.animators.data.ParticlePropertiesMode;
import away3d.animators.nodes.ParticleAccelerationNode;
import away3d.loaders.parsers.particleSubParsers.AllIdentifiers;
import away3d.loaders.parsers.particleSubParsers.AllSubParsers;
import away3d.loaders.parsers.particleSubParsers.utils.MatchingTool;
import away3d.loaders.parsers.particleSubParsers.values.ValueSubParserBase;

class ParticleAccelerationNodeSubParser extends ParticleNodeSubParserBase
{
    public static var identifier(get, never) : Dynamic;

    private var _acceleration : ValueSubParserBase;
    
    public function new()
    {
        super();
    }
    
    
    override private function proceedParsing() : Bool
    {
        if (_isFirstParsing)
        {
            var object : Dynamic = _data.acceleration;
            var Id : Dynamic = object.id;
            var subData : Dynamic = object.data;
            
            var valueCls : Class<Dynamic> = MatchingTool.getMatchedClass(Id, AllSubParsers.ALL_THREED_VALUES);
            if (valueCls == null)
            {
                dieWithError("Unknown value");
            }
            _acceleration = Type.createInstance(valueCls, [ParticleAccelerationNode.ACCELERATION_VECTOR3D]);
            addSubParser(_acceleration);
            _acceleration.parseAsync(subData);
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
        if (_acceleration.valueType == ValueSubParserBase.CONST_VALUE)
        {
            _particleAnimationNode = new ParticleAccelerationNode(ParticlePropertiesMode.GLOBAL, _acceleration.setter.generateOneValue());
        }
        else
        {
            _particleAnimationNode = new ParticleAccelerationNode(ParticlePropertiesMode.LOCAL_STATIC);
            _setters.push(_acceleration.setter);
        }
    }
    
    private static function get_identifier() : Dynamic
    {
        return AllIdentifiers.ParticleAccelerationNodeSubParser;
    }
}


