package away3d.loaders.parsers.particleSubParsers.utils;


class MatchingTool
{
    
    public static function getMatchedClass(identifier : Dynamic, classes : Array<Dynamic>) : Class<Dynamic>
    {
        var result : Class<Dynamic> = null;
        for (cls in classes)
        {
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

