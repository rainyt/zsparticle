package away3d.loaders.parsers.particleSubParsers.nodes;

import away3d.loaders.parsers.particleSubParsers.AllIdentifiers;
import away3d.loaders.parsers.particleSubParsers.AllSubParsers;
import away3d.loaders.parsers.particleSubParsers.utils.MatchingTool;
import away3d.loaders.parsers.particleSubParsers.values.ValueSubParserBase;

class ParticleTimeNodeSubParser extends ParticleNodeSubParserBase
{
    public static var identifier(get, never) : Dynamic;

    public var usesDuration : Bool;
    public var usesLooping : Bool;
    public var usesDelay : Bool;
    private var _startTimeValue : ValueSubParserBase;
    private var _durationValue : ValueSubParserBase;
    private var _delayValue : ValueSubParserBase;
    
    public function new()
    {
        super();
    }
    
    private function initSetters() : Void
    {
        _setters.push(_startTimeValue.setter);
        if (usesDuration)
        {
            _setters.push(_durationValue.setter);
        }
        if (usesDelay)
        {
            _setters.push(_delayValue.setter);
        }
    }
    
    override private function proceedParsing() : Bool
    {
        if (_isFirstParsing)
        {
            usesLooping = _data.usesLooping;
            usesDuration = _data.usesDuration;
            usesDelay = _data.usesDelay;
            
            var object : Dynamic = _data.startTime;
            var Id : Dynamic = object.id;
            var subData : Dynamic = object.data;
            
            var valueCls : Class<Dynamic>;
            
            valueCls = MatchingTool.getMatchedClass(Id, AllSubParsers.ALL_ONED_VALUES);
            if (valueCls == null)
            {
                dieWithError("Unknown value");
            }
            _startTimeValue = Type.createInstance(valueCls, ["startTime"]);
            addSubParser(_startTimeValue);
            _startTimeValue.parseAsync(subData);
            
            
            if (usesDuration)
            {
                object = _data.duration;
                Id = object.id;
                subData = object.data;
                valueCls = MatchingTool.getMatchedClass(Id, AllSubParsers.ALL_ONED_VALUES);
                if (valueCls == null)
                {
                    dieWithError("Unknown value");
                }
                _durationValue = Type.createInstance(valueCls, ["duration"]);
                addSubParser(_durationValue);
                _durationValue.parseAsync(subData);
            }
            
            
            if (usesDelay)
            {
                object = _data.delay;
                Id = object.id;
                subData = object.data;
                valueCls = MatchingTool.getMatchedClass(Id, AllSubParsers.ALL_ONED_VALUES);
                if (valueCls == null)
                {
                    dieWithError("Unknown value");
                }
                _delayValue = Type.createInstance(valueCls, ["delay"]);
                addSubParser(_delayValue);
                _delayValue.parseAsync(subData);
            }
        }
        if (super.proceedParsing() == ParserBase.PARSING_DONE)
        {
            initSetters();
            return ParserBase.PARSING_DONE;
        }
        else
        {
            return ParserBase.MORE_TO_PARSE;
        }
    }
    
    private static function get_identifier() : Dynamic
    {
        return AllIdentifiers.ParticleTimeNodeSubParser;
    }
}


