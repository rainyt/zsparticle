package away3d.loaders.parsers.particleSubParsers.values.setters.threeD;

import away3d.animators.data.ParticleProperties;
import away3d.loaders.parsers.particleSubParsers.values.setters.SetterBase;
import openfl.geom.Vector3D;

class ThreeDCompositeSetter extends SetterBase
{
    private var _setterX : SetterBase;
    private var _setterY : SetterBase;
    private var _setterZ : SetterBase;
    private var _isometric : Bool;
    
    public function new(propName : String, setterX : SetterBase, setterY : SetterBase, setterZ : SetterBase, isometric : Bool = false)
    {
        super(propName);
        _setterX = setterX;
        _setterY = setterY;
        _setterZ = setterZ;
        _isometric = isometric;
    }
    
    override public function setProps(prop : ParticleProperties) : Void
    {
        prop.nodes.set(_propName , generateOneValue(prop.index, prop.total));
    }
    
    override public function generateOneValue(index : Int = 0, total : Int = 1) : Dynamic
    {
        var x : Float = _setterX.generateOneValue(index, total);
        var y : Float = (_isometric) ? x : _setterY.generateOneValue(index, total);
        var z : Float = (_isometric) ? x : _setterZ.generateOneValue(index, total);
        return new Vector3D(x, y, z);
    }
    
    override public function startPropsGenerating(prop : ParticleProperties) : Void
    {
        if (_setterX != null)
        {
            _setterX.startPropsGenerating(prop);
        }
        if (_setterY != null)
        {
            _setterY.startPropsGenerating(prop);
        }
        if (_setterZ != null)
        {
            _setterZ.startPropsGenerating(prop);
        }
    }
    
    override public function finishPropsGenerating(prop : ParticleProperties) : Void
    {
        if (_setterX != null)
        {
            _setterX.finishPropsGenerating(prop);
        }
        if (_setterY != null)
        {
            _setterY.finishPropsGenerating(prop);
        }
        if (_setterZ != null)
        {
            _setterZ.finishPropsGenerating(prop);
        }
    }
}


