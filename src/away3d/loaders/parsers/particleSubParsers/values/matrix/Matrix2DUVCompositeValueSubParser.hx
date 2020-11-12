package away3d.loaders.parsers.particleSubParsers.values.matrix;

import away3d.loaders.parsers.particleSubParsers.AllIdentifiers;
import away3d.loaders.parsers.particleSubParsers.AllSubParsers;
import away3d.loaders.parsers.particleSubParsers.utils.MatchingTool;
import away3d.loaders.parsers.particleSubParsers.values.ValueSubParserBase;
import away3d.loaders.parsers.particleSubParsers.values.setters.matrix.Matrix2DUVCompositeSetter;

class Matrix2DUVCompositeValueSubParser extends ValueSubParserBase
{
    public static var identifier(get, never) : Dynamic;

    private var _numColumns : Int;
    private var _numRows : Int;
    private var _selectedValue : ValueSubParserBase;
    
    public function new(propName : String)
    {
        super(propName, ValueSubParserBase.VARIABLE_VALUE);
    }
    
    override private function proceedParsing() : Bool
    {
        if (_isFirstParsing)
        {
            _numColumns = _data.numColumns;
            _numRows = _data.numRows;
            
            var object : Dynamic = _data.selectedValue;
            var Id : Dynamic = object.id;
            var subData : Dynamic = object.data;
            
            var valueCls : Class<Dynamic> = MatchingTool.getMatchedClass(Id, AllSubParsers.ALL_ONED_VALUES);
            if (valueCls == null)
            {
                dieWithError("Unknown value");
            }
            _selectedValue = Type.createInstance(valueCls, [null]);
            addSubParser(_selectedValue);
            _selectedValue.parseAsync(subData);
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
        _setter = new Matrix2DUVCompositeSetter(_propName, _numColumns, _numRows, _selectedValue.setter);
    }
    
    private static function get_identifier() : Dynamic
    {
        return AllIdentifiers.Matrix2DUVCompositeValueSubParser;
    }
}

