package away3d.loaders.parsers.particleSubParsers.values.setters.oneD;

import away3d.animators.data.ParticleProperties;
import away3d.loaders.parsers.particleSubParsers.values.setters.SetterBase;

class OneDRandomSetter extends SetterBase
{
    private var _min : Float;
    private var _max : Float;
    private var _delta : Float;
    
    public function new(propName : String, min : Float, max : Float)
    {
        super(propName);
        _min = min;
        _max = max;
        _delta = _max - _min;
    }
    
    override public function setProps(prop : ParticleProperties) : Void
    {
        prop.nodes.set(_propName , Math.random() * _delta + _min);
    }
    
    override public function generateOneValue(index : Int = 0, total : Int = 1) : Dynamic
    {
        return Math.random() * _delta + _min;
    }
}

