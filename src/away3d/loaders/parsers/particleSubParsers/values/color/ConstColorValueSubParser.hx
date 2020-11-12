package away3d.loaders.parsers.particleSubParsers.values.color;

import away3d.loaders.parsers.particleSubParsers.AllIdentifiers;
import away3d.loaders.parsers.particleSubParsers.values.ValueSubParserBase;
import away3d.loaders.parsers.particleSubParsers.values.setters.color.ConstColorSetter;
import openfl.geom.ColorTransform;

class ConstColorValueSubParser extends ValueSubParserBase
{
    public static var identifier(get, never) : Dynamic;

    public function new(propName : String)
    {
        super(propName,ValueSubParserBase.CONST_VALUE);
    }
    
    override public function parseAsync(data : Dynamic, frameLimit : Int = 30) : Void
    {
        super.parseAsync(data, frameLimit);
        _setter = new ConstColorSetter(_propName, extractColor(data));
    }
    
    private function extractColor(data : Dynamic) : ColorTransform
    {
        var color : ColorTransform = new ColorTransform();
        
        if (Reflect.getProperty(data,"mr") != null)
        {
            color.redMultiplier = data.mr;
        }
        if (Reflect.getProperty(data,"mg") != null)
        {
            color.greenMultiplier = data.mg;
        }
        if (Reflect.getProperty(data,"mb") != null)
        {
            color.blueMultiplier = data.mb;
        }
        if (Reflect.getProperty(data,"ma") != null)
        {
            color.alphaMultiplier = data.ma;
        }
        if (Reflect.getProperty(data,"or") != null)
        {
            color.redOffset = data.or;
        }
        if (Reflect.getProperty(data,"og") != null)
        {
            color.greenOffset = data.og;
        }
        if (Reflect.getProperty(data,"ob") != null)
        {
            color.blueOffset = data.ob;
        }
        if (Reflect.getProperty(data,"oa") != null)
        {
            color.alphaOffset = data.oa;
        }
        return color;
    }
    
    private static function get_identifier() : Dynamic
    {
        return AllIdentifiers.ConstColorValueSubParser;
    }
}

