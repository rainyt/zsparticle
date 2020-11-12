package away3d.loaders.parsers.particleSubParsers.materials;


import away3d.loaders.parsers.particleSubParsers.AllIdentifiers;
import away3d.materials.ColorMaterial;
import away3d.materials.MaterialBase;

class ColorMaterialSubParser extends MaterialSubParserBase
{
    public static var identifier(get, never) : Dynamic;

    
    private var _colorMaterial : ColorMaterial = new ColorMaterial();
    
    
    public function new()
    {
        super();
    }
    
    override public function parseAsync(data : Dynamic, frameLimit : Int = 30) : Void
    {
        super.parseAsync(data, frameLimit);
    }
    
    override private function proceedParsing() : Bool
    {
        if (super.proceedParsing() == ParserBase.PARSING_DONE)
        {
            _colorMaterial.color = _data.color;
            _colorMaterial.alpha = _data.alpha;
            _colorMaterial.bothSides = _bothSide;
            _colorMaterial.blendMode = _blendMode;
            _colorMaterial.alphaPremultiplied = false;
            return ParserBase.PARSING_DONE;
        }
        else
        {
            return ParserBase.MORE_TO_PARSE;
        }
    }
    
    
    
    override private function get_material() : MaterialBase
    {
        return _colorMaterial;
    }
    
    private static function get_identifier() : Dynamic
    {
        return AllIdentifiers.ColorMaterialSubParser;
    }
}


