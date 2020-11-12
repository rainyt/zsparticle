package away3d.loaders.parsers.particleSubParsers.values;

import away3d.loaders.parsers.CompositeParserBase;
import away3d.loaders.parsers.particleSubParsers.values.setters.SetterBase;

class ValueSubParserBase extends CompositeParserBase
{
    public var valueType(get, never) : Int;
    public var setter(get, never) : SetterBase;

    public static inline var CONST_VALUE : Int = 0;
    public static inline var VARIABLE_VALUE : Int = 1;
    
    private var _propName : String;
    
    private var _valueType : Int;
    
    private var _setter : SetterBase;
    
    public function new(propName : String, type : Int)
    {
        _propName = propName;
        _valueType = type;
        super();
    }
    
    private function get_valueType() : Int
    {
        return _valueType;
    }
    
    private function get_setter() : SetterBase
    {
        return _setter;
    }
}


