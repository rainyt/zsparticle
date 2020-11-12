package away3d.loaders.parsers.particleSubParsers.values.setters.oneD;

import away3d.animators.data.ParticleProperties;
import away3d.loaders.parsers.particleSubParsers.values.setters.SetterBase;

class OneDConstSetter extends SetterBase
{
    private var _value : Float;
    
    public function new(propName : String, value : Float)
    {
        super(propName);
        _value = value;
    }
    
    override public function setProps(prop : ParticleProperties) : Void
    {
        prop.nodes.set(_propName, _value);
    }
    
    override public function generateOneValue(index : Int = 0, total : Int = 1) : Dynamic
    {
        return _value;
    }
}

