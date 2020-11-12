package away3d.loaders.parsers.particleSubParsers.values.fourD;

import away3d.loaders.parsers.particleSubParsers.AllIdentifiers;
import away3d.loaders.parsers.particleSubParsers.AllSubParsers;
import away3d.loaders.parsers.particleSubParsers.utils.MatchingTool;
import away3d.loaders.parsers.particleSubParsers.values.ValueSubParserBase;
import away3d.loaders.parsers.particleSubParsers.values.setters.SetterBase;
import away3d.loaders.parsers.particleSubParsers.values.setters.fourD.FourDCompositeWithOneDSetter;

class FourDCompositeWithOneDValueSubParser extends ValueSubParserBase
{
    public static var identifier(get, never) : Dynamic;

    
    private var _valueX : ValueSubParserBase;
    private var _valueY : ValueSubParserBase;
    private var _valueZ : ValueSubParserBase;
    private var _valueW : ValueSubParserBase;
    
    public function new(propName : String)
    {
        super(propName, ValueSubParserBase.VARIABLE_VALUE);
    }
    
    
    override private function proceedParsing() : Bool
    {
        if (_isFirstParsing)
        
        //for x
        {
            
            var object : Dynamic = _data.x;
            var Id : Dynamic = null;
            var subData : Dynamic = null;
            var valueCls : Class<Dynamic>;
            if (object != null)
            {
                Id = object.id;
                subData = object.data;
                valueCls = MatchingTool.getMatchedClass(Id, AllSubParsers.ALL_ONED_VALUES);
                if (valueCls == null)
                {
                    dieWithError("Unknown value");
                }
                _valueX = Type.createInstance(valueCls, [null]);
                addSubParser(_valueX);
                _valueX.parseAsync(subData);
            }
            
            //for y
            object = _data.y;
            if (object != null)
            {
                Id = object.id;
                subData = object.data;
                
                valueCls = MatchingTool.getMatchedClass(Id, AllSubParsers.ALL_ONED_VALUES);
                if (valueCls == null)
                {
                    dieWithError("Unknown value");
                }
                _valueY = Type.createInstance(valueCls,[null]);
                addSubParser(_valueY);
                _valueY.parseAsync(subData);
            }
            //for z
            object = _data.z;
            if (object != null)
            {
                Id = object.id;
                subData = object.data;
                
                valueCls = MatchingTool.getMatchedClass(Id, AllSubParsers.ALL_ONED_VALUES);
                if (valueCls == null)
                {
                    dieWithError("Unknown value");
                }
                _valueZ = Type.createInstance(valueCls,[null]);
                addSubParser(_valueZ);
                _valueZ.parseAsync(subData);
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
        var setterX : SetterBase = (_valueX != null) ? _valueX.setter : null;
        var setterY : SetterBase = (_valueY != null) ? _valueY.setter : null;
        var setterZ : SetterBase = (_valueZ != null) ? _valueZ.setter : null;
        var setterW : SetterBase = (_valueW != null) ? _valueW.setter : null;
        if ((_valueX == null || _valueX.valueType == ValueSubParserBase.CONST_VALUE) && (_valueY == null || _valueY.valueType == ValueSubParserBase.CONST_VALUE) && (_valueZ == null || _valueZ.valueType == ValueSubParserBase.CONST_VALUE) && (_valueW == null || _valueW.valueType == ValueSubParserBase.CONST_VALUE))
        {
            _valueType = ValueSubParserBase.CONST_VALUE;
        }
        else
        {
            _valueType = ValueSubParserBase.VARIABLE_VALUE;
        }
        _setter = new FourDCompositeWithOneDSetter(_propName, setterX, setterY, setterZ, setterW);
    }
    
    private static function get_identifier() : Dynamic
    {
        return AllIdentifiers.FourDCompositeWithOneDValueSubParser;
    }
}


