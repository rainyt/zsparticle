package away3d.loaders.parsers.particleSubParsers.values.setters.threeD;

import away3d.animators.data.ParticleProperties;
import away3d.loaders.parsers.particleSubParsers.values.setters.SetterBase;
import openfl.geom.Vector3D;

class ThreeDConstSetter extends SetterBase
{
    private var _value : Vector3D;
    
    public function new(propName : String, value : Vector3D)
    {
        super(propName);
        _value = value;
    }
    
    override public function setProps(prop : ParticleProperties) : Void
    {
        if(Reflect.hasField(prop,_propName)){
            Reflect.setProperty(prop,_propName,_value);
        }
        else
            prop.nodes.set(_propName,_value);
    }
    
    override public function generateOneValue(index : Int = 0, total : Int = 1) : Dynamic
    {
        return _value;
    }
}


