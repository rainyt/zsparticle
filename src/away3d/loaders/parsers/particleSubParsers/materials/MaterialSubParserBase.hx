package away3d.loaders.parsers.particleSubParsers.materials;

import away3d.errors.AbstractMethodError;
import away3d.loaders.parsers.CompositeParserBase;
import away3d.materials.MaterialBase;
import openfl.display.BlendMode;

class MaterialSubParserBase extends CompositeParserBase
{
    public var material(get, never) : MaterialBase;

    private var _bothSide : Bool;
    private var _blendMode : String = BlendMode.NORMAL;
    
    public function new()
    {
        super();
    }
    
    override private function proceedParsing() : Bool
    {
        if (_isFirstParsing)
        {
            _bothSide = _data.bothSide;
            if (_data.blendMode != null)
            {
                _blendMode = _data.blendMode;
            }
        }
        return super.proceedParsing();
    }
    
    private function get_material() : MaterialBase
    {
        throw (new AbstractMethodError());
    }
}


