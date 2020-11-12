package away3d.loaders.parsers.particleSubParsers.values.matrix;

import away3d.loaders.parsers.particleSubParsers.AllIdentifiers;
import away3d.loaders.parsers.particleSubParsers.AllSubParsers;
import away3d.loaders.parsers.particleSubParsers.utils.MatchingTool;
import away3d.loaders.parsers.particleSubParsers.values.ValueSubParserBase;
import away3d.loaders.parsers.particleSubParsers.values.setters.SetterBase;
import away3d.loaders.parsers.particleSubParsers.values.setters.matrix.Matrix3DCompositeSetter;

class Matrix3DCompositeValueSubParser extends ValueSubParserBase
{
    public static var identifier(get, never) : Dynamic;

    private var _transforms : Array<ValueSubParserBase> = new Array<ValueSubParserBase>();
    
    public function new(propName : String)
    {
        super(propName, ValueSubParserBase.VARIABLE_VALUE);
    }
    
    override private function proceedParsing() : Bool
    {
        if (_isFirstParsing)
        {
            var object : Dynamic;
            var Id : Dynamic;
            var subData : Dynamic;
            var valueCls : Class<Dynamic>;
            var valueData : Dynamic;
            
            var transformDatas : Array<Dynamic> = _data.transforms;
            for (transformData in transformDatas)
            {
                valueData = transformData.data;
                subData = valueData.data;
                Id = valueData.id;
                valueCls = MatchingTool.getMatchedClass(Id, AllSubParsers.ALL_THREED_VALUES);
                
                if (valueCls == null)
                {
                    dieWithError("Unknown value parser");
                }
                //use name property as type
                var valueParser : ValueSubParserBase = Type.createInstance(valueCls, [transformData.type]);
                addSubParser(valueParser);
                valueParser.parseAsync(subData);
                _transforms.push(valueParser);
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
        var transformSetters : Array<SetterBase> = new Array<SetterBase>();
        for (i in 0..._transforms.length)
        {
            transformSetters.push(_transforms[i].setter);
        }
        _setter = new Matrix3DCompositeSetter(_propName, transformSetters);
    }
    
    private static function get_identifier() : Dynamic
    {
        return AllIdentifiers.Matrix3DCompositeValueSubParser;
    }
}


