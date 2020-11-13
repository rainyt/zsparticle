package away3d.loaders.parsers.particleSubParsers.values.setters.color;

import away3d.animators.data.ParticleProperties;
import away3d.loaders.parsers.particleSubParsers.values.setters.SetterBase;
import openfl.geom.ColorTransform;

class ConstColorSetter extends SetterBase
{
    private var _color : ColorTransform;
    
    public function new(propName : String, color : ColorTransform)
    {
        super(propName);
        _color = color;
    }
    
    override public function setProps(prop : ParticleProperties) : Void
    {
        if(Reflect.hasField(prop,_propName)){
            Reflect.setProperty(prop,_propName,_color);
        }
        else
            prop.nodes.set(_propName,_color);
    }
    
    override public function generateOneValue(index : Int = 0, total : Int = 1) : Dynamic
    {
        return _color;
    }
}

