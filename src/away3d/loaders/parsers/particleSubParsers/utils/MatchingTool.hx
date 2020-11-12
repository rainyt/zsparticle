package away3d.loaders.parsers.particleSubParsers.utils;


class MatchingTool
{
    
    public static function getMatchedClass(identifier : Dynamic, classes : Array<Dynamic>) : Class<Dynamic>
    {
        var result : Class<Dynamic> = null;
        for (cls in classes)
        {
            // trace("查找：",Reflect.getProperty(cls, "identifier"),Std.string(cls));
            if (Reflect.getProperty(cls, "identifier") == identifier)
            {
                result = cls;
                break;
            }
        }
        return result;
    }

    public function new()
    {
    }
}

