package away3d.loaders.parsers.particleSubParsers.values.fourD;

import away3d.loaders.parsers.particleSubParsers.AllIdentifiers;
import away3d.loaders.parsers.particleSubParsers.AllSubParsers;
import away3d.loaders.parsers.particleSubParsers.utils.MatchingTool;
import away3d.loaders.parsers.particleSubParsers.values.ValueSubParserBase;
import away3d.loaders.parsers.particleSubParsers.values.setters.SetterBase;
import away3d.loaders.parsers.particleSubParsers.values.setters.fourD.FourDCompositeWithThreeDSetter;

class FourDCompositeWithThreeDValueSubParser extends ValueSubParserBase
{
    public static var identifier(get, never) : Dynamic;

    
    private var _value3D : ValueSubParserBase;
    private var _valueW : ValueSubParserBase;
    
    public function new(propName : String)
    {
        super(propName, ValueSubParserBase.VARIABLE_VALUE);
    }
    
    
    override private function proceedParsing() : Bool
    {
        if (_isFirstParsing)
        
        //for 3d
        {
            
            var object : Dynamic = _data.x;
            var Id : Dynamic;
            var subData : Dynamic;
            var valueCls : Class<Dynamic>;

            if (object != null)
            {
                Id = object.id;
                subData = object.data;
                
                valueCls = MatchingTool.getMatchedClass(Id, AllSubParsers.ALL_THREED_VALUES);
                if (valueCls == null)
                {
                    dieWithError("Unknown value");
                }
                _value3D = Type.createInstance(valueCls, [null]);
                addSubParser(_value3D);
                _value3D.parseAsync(subData);
            }
            
            //for w
            object = _data.w;
            if (object != null)
            {
                Id = object.id;
                subData = object.data;
                
                valueCls = MatchingTool.getMatchedClass(Id, AllSubParsers.ALL_ONED_VALUES);
                if (null == valueCls)
                {
                    dieWithError("Unknown value");
                }
                _valueW = Type.createInstance(valueCls,[null]);
                addSubParser(_valueW);
                _valueW.parseAsync(subData);
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
        var setter3D : SetterBase = _value3D.setter;
        var setterW : SetterBase = _valueW.setter;
        if (_value3D.valueType == ValueSubParserBase.CONST_VALUE && _valueW.valueType == ValueSubParserBase.CONST_VALUE)
        {
            _valueType = ValueSubParserBase.CONST_VALUE;
        }
        else
        {
            _valueType = ValueSubParserBase.VARIABLE_VALUE;
        }
        _setter = new FourDCompositeWithThreeDSetter(_propName, setter3D, setterW);
    }
    
    private static function get_identifier() : Dynamic
    {
        return AllIdentifiers.FourDCompositeWithThreeDValueSubParser;
    }
}

