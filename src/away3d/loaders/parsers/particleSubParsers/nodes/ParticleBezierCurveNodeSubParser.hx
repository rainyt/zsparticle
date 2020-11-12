package away3d.loaders.parsers.particleSubParsers.nodes;

import away3d.animators.data.ParticlePropertiesMode;
import away3d.animators.nodes.ParticleBezierCurveNode;
import away3d.loaders.parsers.particleSubParsers.AllIdentifiers;
import away3d.loaders.parsers.particleSubParsers.AllSubParsers;
import away3d.loaders.parsers.particleSubParsers.utils.MatchingTool;
import away3d.loaders.parsers.particleSubParsers.values.ValueSubParserBase;

class ParticleBezierCurveNodeSubParser extends ParticleNodeSubParserBase
{
    public static var identifier(get, never) : Dynamic;

    private var _controlValue : ValueSubParserBase;
    private var _endValue : ValueSubParserBase;
    
    public function new()
    {
        super();
    }
    
    override private function proceedParsing() : Bool
    {
        if (_isFirstParsing)
        {
            var object : Dynamic = _data.control;
            var Id : Dynamic = object.id;
            var subData : Dynamic = object.data;
            var valueCls : Class<Dynamic> = MatchingTool.getMatchedClass(Id, AllSubParsers.ALL_THREED_VALUES);
            if (valueCls == null)
            {
                dieWithError("Unknown value");
            }
            _controlValue = Type.createInstance(valueCls, [ParticleBezierCurveNode.BEZIER_CONTROL_VECTOR3D]);
            addSubParser(_controlValue);
            _controlValue.parseAsync(subData);
            
            object = _data.end;
            Id = object.id;
            subData = object.data;
            valueCls = MatchingTool.getMatchedClass(Id, AllSubParsers.ALL_THREED_VALUES);
            if (valueCls == null)
            {
                dieWithError("Unknown value");
            }
            _endValue = Type.createInstance(valueCls, [ParticleBezierCurveNode.BEZIER_END_VECTOR3D]);
            addSubParser(_endValue);
            _endValue.parseAsync(subData);
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
        if (_controlValue.valueType == ValueSubParserBase.CONST_VALUE && _endValue.valueType == ValueSubParserBase.CONST_VALUE)
        {
            _particleAnimationNode = new ParticleBezierCurveNode(ParticlePropertiesMode.GLOBAL, _controlValue.setter.generateOneValue(), _endValue.setter.generateOneValue());
        }
        else
        {
            _particleAnimationNode = new ParticleBezierCurveNode(ParticlePropertiesMode.LOCAL_STATIC);
            _setters.push(_controlValue.setter);
            _setters.push(_endValue.setter);
        }
    }
    
    private static function get_identifier() : Dynamic
    {
        return AllIdentifiers.ParticleBezierCurveNodeSubParser;
    }
}

