package away3d.loaders.parsers.particleSubParsers.values.threeD;

import away3d.loaders.parsers.particleSubParsers.AllIdentifiers;
import away3d.loaders.parsers.particleSubParsers.AllSubParsers;
import away3d.loaders.parsers.particleSubParsers.utils.MatchingTool;
import away3d.loaders.parsers.particleSubParsers.values.ValueSubParserBase;
import away3d.loaders.parsers.particleSubParsers.values.setters.threeD.ThreeDCompositeSetter;

class ThreeDCompositeValueSubParser extends ValueSubParserBase
{
    public static var identifier(get, never) : Dynamic;

    
    private var _valueX : ValueSubParserBase;
    private var _valueY : ValueSubParserBase;
    private var _valueZ : ValueSubParserBase;
    private var _isometric : Bool;
    
    public function new(propName : String)
    {
        super(propName, ValueSubParserBase.VARIABLE_VALUE);
    }
    
    
    override private function proceedParsing() : Bool
    {
        if (_isFirstParsing)
        {
            _isometric = _data.isometric;
            //for x
            var object : Dynamic = _data.x;
            var Id : Dynamic = object.id;
            var subData : Dynamic = object.data;
            
            var valueCls : Class<Dynamic>;
            valueCls = MatchingTool.getMatchedClass(Id, AllSubParsers.ALL_ONED_VALUES);
            if (valueCls == null)
            {
                dieWithError("Unknown value");
            }
            _valueX = Type.createInstance(valueCls, [null]);
            addSubParser(_valueX);
            _valueX.parseAsync(subData);
            
            //for y
            object = _data.y;
            Id = object.id;
            subData = object.data;
            
            valueCls = MatchingTool.getMatchedClass(Id, AllSubParsers.ALL_ONED_VALUES);
            if (valueCls == null)
            {
                dieWithError("Unknown value");
            }
            _valueY = Type.createInstance(valueCls, [null]);
            addSubParser(_valueY);
            _valueY.parseAsync(subData);
            
            //for z
            object = _data.z;
            Id = object.id;
            subData = object.data;
            
            valueCls = MatchingTool.getMatchedClass(Id, AllSubParsers.ALL_ONED_VALUES);
            if (valueCls == null)
            {
                dieWithError("Unknown value");
            }
            _valueZ = Type.createInstance(valueCls, [null]);
            addSubParser(_valueZ);
            _valueZ.parseAsync(subData);
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
        if (_valueX.valueType == ValueSubParserBase.CONST_VALUE && (_isometric || (_valueY.valueType == ValueSubParserBase.CONST_VALUE && _valueZ.valueType == ValueSubParserBase.CONST_VALUE)))
        {
            _valueType = ValueSubParserBase.CONST_VALUE;
        }
        _setter = new ThreeDCompositeSetter(_propName, _valueX.setter, _valueY.setter, _valueZ.setter, _isometric);
    }
    
    private static function get_identifier() : Dynamic
    {
        return AllIdentifiers.ThreeDCompositeValueSubParser;
    }
}


