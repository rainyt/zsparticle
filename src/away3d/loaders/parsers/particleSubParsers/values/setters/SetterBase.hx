package away3d.loaders.parsers.particleSubParsers.values.setters;

import away3d.animators.data.ParticleProperties;
import away3d.errors.AbstractMethodError;

class SetterBase
{
    public var propName(get, never) : String;

    private var _propName : String;
    
    public function new(propName : String)
    {
        _propName = propName;
    }
    
    private function get_propName() : String
    {
        return _propName;
    }
    
    public function startPropsGenerating(prop : ParticleProperties) : Void
    {
    }
    
    public function setProps(prop : ParticleProperties) : Void
    {
        throw (new AbstractMethodError());
    }
    
    public function generateOneValue(index : Int = 0, total : Int = 1) : Dynamic
    {
        throw (new AbstractMethodError());
    }
    
    public function finishPropsGenerating(prop : ParticleProperties) : Void
    {
    }
}


