package away3d.loaders.parsers.particleSubParsers.values.color;

import away3d.loaders.parsers.particleSubParsers.AllIdentifiers;
import away3d.loaders.parsers.particleSubParsers.AllSubParsers;
import away3d.loaders.parsers.particleSubParsers.utils.MatchingTool;
import away3d.loaders.parsers.particleSubParsers.values.ValueSubParserBase;
import away3d.loaders.parsers.particleSubParsers.values.setters.SetterBase;
import away3d.loaders.parsers.particleSubParsers.values.setters.color.CompositeColorSetter;

class CompositeColorValueSubParser extends ValueSubParserBase
{
    public static var identifier(get, never) : Dynamic;

    private var _redMultiplierValue : ValueSubParserBase;
    private var _greenMultiplierValue : ValueSubParserBase;
    private var _blueMultiplierValue : ValueSubParserBase;
    private var _alphaMultiplierValue : ValueSubParserBase;
    
    private var _redOffsetValue : ValueSubParserBase;
    private var _greenOffsetValue : ValueSubParserBase;
    private var _blueOffsetValue : ValueSubParserBase;
    private var _alphaOffsetValue : ValueSubParserBase;
    
    public var usesMultiplier : Bool;
    public var usesOffset : Bool;
    
    public function new(propName : String)
    {
        super(propName, ValueSubParserBase.VARIABLE_VALUE);
    }
    
    override private function proceedParsing() : Bool
    {
        if (_isFirstParsing)
        {
            var Id : Dynamic;
            var subData : Dynamic;
            var valueCls : Class<Dynamic>;
            //for Multiplier
            var object : Dynamic = _data.redMultiplierValue;
            if (object != null)
            {
                usesMultiplier = true;
                //red
                Id = object.id;
                subData = object.data;
                valueCls = MatchingTool.getMatchedClass(Id, AllSubParsers.ALL_ONED_VALUES);
                if (valueCls == null)
                {
                    dieWithError("Unknown value");
                }
                _redMultiplierValue = Type.createInstance(valueCls, [null]);
                addSubParser(_redMultiplierValue);
                _redMultiplierValue.parseAsync(subData);
                
                //green
                object = _data.greenMultiplierValue;
                Id = object.id;
                subData = object.data;
                valueCls = MatchingTool.getMatchedClass(Id, AllSubParsers.ALL_ONED_VALUES);
                if (valueCls == null)
                {
                    dieWithError("Unknown value");
                }
                _greenMultiplierValue = Type.createInstance(valueCls, [null]);
                addSubParser(_greenMultiplierValue);
                _greenMultiplierValue.parseAsync(subData);
                
                //blue
                object = _data.blueMultiplierValue;
                Id = object.id;
                subData = object.data;
                valueCls = MatchingTool.getMatchedClass(Id, AllSubParsers.ALL_ONED_VALUES);
                if (valueCls == null)
                {
                    dieWithError("Unknown value");
                }
                _blueMultiplierValue = Type.createInstance(valueCls, [null]);
                addSubParser(_blueMultiplierValue);
                _blueMultiplierValue.parseAsync(subData);
                
                //alpha
                object = _data.alphaMultiplierValue;
                Id = object.id;
                subData = object.data;
                valueCls = MatchingTool.getMatchedClass(Id, AllSubParsers.ALL_ONED_VALUES);
                if (valueCls == null)
                {
                    dieWithError("Unknown value");
                }
                _alphaMultiplierValue = Type.createInstance(valueCls, [null]);
                addSubParser(_alphaMultiplierValue);
                _alphaMultiplierValue.parseAsync(subData);
            }
            
            
            object = _data.redOffsetValue;
            if (object != null)
            {
                usesOffset = true;
                //red
                Id = object.id;
                subData = object.data;
                valueCls = MatchingTool.getMatchedClass(Id, AllSubParsers.ALL_ONED_VALUES);
                if (valueCls == null)
                {
                    dieWithError("Unknown value");
                }
                _redOffsetValue = Type.createInstance(valueCls, [null]);
                addSubParser(_redOffsetValue);
                _redOffsetValue.parseAsync(subData);
                
                //green
                object = _data.greenOffsetValue;
                Id = object.id;
                subData = object.data;
                valueCls = MatchingTool.getMatchedClass(Id, AllSubParsers.ALL_ONED_VALUES);
                if (valueCls == null)
                {
                    dieWithError("Unknown value");
                }
                _greenOffsetValue = Type.createInstance(valueCls, [null]);
                addSubParser(_greenOffsetValue);
                _greenOffsetValue.parseAsync(subData);
                
                //blue
                object = _data.blueOffsetValue;
                Id = object.id;
                subData = object.data;
                valueCls = MatchingTool.getMatchedClass(Id, AllSubParsers.ALL_ONED_VALUES);
                if (valueCls == null)
                {
                    dieWithError("Unknown value");
                }
                _blueOffsetValue = Type.createInstance(valueCls, [null]);
                addSubParser(_blueOffsetValue);
                _blueOffsetValue.parseAsync(subData);
                
                //alpha
                object = _data.alphaOffsetValue;
                Id = object.id;
                subData = object.data;
                valueCls = MatchingTool.getMatchedClass(Id, AllSubParsers.ALL_ONED_VALUES);
                if (valueCls == null)
                {
                    dieWithError("Unknown value");
                }
                _alphaOffsetValue = Type.createInstance(valueCls, [null]);
                addSubParser(_alphaOffsetValue);
                _alphaOffsetValue.parseAsync(subData);
            }
        }
        
        if (super.proceedParsing() == ParserBase.PARSING_DONE)
        {
            initSetter();
            return ParserBase.PARSING_DONE;
        }
        else
        {
            return ParserBase.MORE_TO_PARSE;
        }
    }
    
    private function initSetter() : Void
    {
        var _redMultiplierSetter : SetterBase = null;
        var _greenMultiplierSetter : SetterBase = null;
        var _blueMultiplierSetter : SetterBase = null;
        var _alphaMultiplierSetter : SetterBase = null;
        
        var _redOffsetSetter : SetterBase = null;
        var _greenOffsetSetter : SetterBase = null;
        var _blueOffsetSetter : SetterBase = null;
        var _alphaOffsetSetter : SetterBase = null;
        
        if (usesMultiplier)
        {
            _redMultiplierSetter = _redMultiplierValue.setter;
            _greenMultiplierSetter = _greenMultiplierValue.setter;
            _blueMultiplierSetter = _blueMultiplierValue.setter;
            _alphaMultiplierSetter = _alphaMultiplierValue.setter;
        }
        
        if (usesOffset)
        {
            _redOffsetSetter = _redOffsetValue.setter;
            _greenOffsetSetter = _greenOffsetValue.setter;
            _blueOffsetSetter = _blueOffsetValue.setter;
            _alphaOffsetSetter = _alphaOffsetValue.setter;
        }
        
        if ((!usesMultiplier || (_redMultiplierValue.valueType == ValueSubParserBase.CONST_VALUE && _greenMultiplierValue.valueType == ValueSubParserBase.CONST_VALUE && _blueMultiplierValue.valueType == ValueSubParserBase.CONST_VALUE && _alphaMultiplierValue.valueType == ValueSubParserBase.CONST_VALUE)) && (!usesOffset || (_redOffsetValue.valueType == ValueSubParserBase.CONST_VALUE && _greenOffsetValue.valueType == ValueSubParserBase.CONST_VALUE && _blueOffsetValue.valueType == ValueSubParserBase.CONST_VALUE && _alphaOffsetValue.valueType == ValueSubParserBase.CONST_VALUE)))
        {
            _valueType = ValueSubParserBase.CONST_VALUE;
        }
        else
        {
            _valueType = ValueSubParserBase.VARIABLE_VALUE;
        }
        _setter = new CompositeColorSetter(_propName, _redMultiplierSetter, _greenMultiplierSetter, _blueMultiplierSetter, _alphaMultiplierSetter, _redOffsetSetter, _greenOffsetSetter, _blueOffsetSetter, _alphaOffsetSetter);
    }
    
    private static function get_identifier() : Dynamic
    {
        return AllIdentifiers.CompositeColorValueSubParser;
    }
}

