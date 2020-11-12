package away3d.loaders.parsers.particleSubParsers.values.setters.fourD;

import away3d.animators.data.ParticleProperties;
import away3d.loaders.parsers.particleSubParsers.values.setters.SetterBase;
import openfl.geom.Vector3D;

class FourDCompositeWithThreeDSetter extends SetterBase
{
    private var _setter3D : SetterBase;
    private var _setterW : SetterBase;
    
    public function new(propName : String, setter3D : SetterBase, setterW : SetterBase)
    {
        super(propName);
        _setter3D = setter3D;
        _setterW = setterW;
    }
    
    override public function startPropsGenerating(prop : ParticleProperties) : Void
    {
        _setter3D.startPropsGenerating(prop);
        _setterW.startPropsGenerating(prop);
    }
    
    override public function finishPropsGenerating(prop : ParticleProperties) : Void
    {
        _setter3D.finishPropsGenerating(prop);
        _setterW.finishPropsGenerating(prop);
    }
    
    override public function setProps(prop : ParticleProperties) : Void
    {
        prop.nodes.set(_propName, generateOneValue(prop.index, prop.total));
    }
    
    override public function generateOneValue(index : Int = 0, total : Int = 1) : Dynamic
    {
        var vector3D : Vector3D = _setter3D.generateOneValue(index, total);
        vector3D.w = _setterW.generateOneValue(index, total);
        return vector3D;
    }
}

