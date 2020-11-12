package away3d.loaders.parsers.particleSubParsers.values.setters.fourD;

import away3d.animators.data.ParticleProperties;
import away3d.loaders.parsers.particleSubParsers.values.setters.SetterBase;
import openfl.geom.Vector3D;

class FourDCompositeWithOneDSetter extends SetterBase
{
    private var _setterX : SetterBase;
    private var _setterY : SetterBase;
    private var _setterZ : SetterBase;
    private var _setterW : SetterBase;
    
    public function new(propName : String, setterX : SetterBase = null, setterY : SetterBase = null, setterZ : SetterBase = null, setterW : SetterBase = null)
    {
        super(propName);
        _setterX = setterX;
        _setterY = setterY;
        _setterZ = setterZ;
        _setterW = setterW;
    }
    
    override public function setProps(prop : ParticleProperties) : Void
    {
        prop.nodes.set(_propName, generateOneValue(prop.index, prop.total));
    }
    
    override public function generateOneValue(index : Int = 0, total : Int = 1) : Dynamic
    {
        var x : Float = (_setterX != null) ? _setterX.generateOneValue(index, total) : 0;
        var y : Float = (_setterY != null) ? _setterY.generateOneValue(index, total) : 0;
        var z : Float = (_setterZ != null) ? _setterZ.generateOneValue(index, total) : 0;
        var w : Float = (_setterW != null) ? _setterW.generateOneValue(index, total) : 0;
        return new Vector3D(x, y, z, w);
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
        if (_setterW != null)
        {
            _setterW.startPropsGenerating(prop);
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
        if (_setterW != null)
        {
            _setterW.finishPropsGenerating(prop);
        }
    }
}

