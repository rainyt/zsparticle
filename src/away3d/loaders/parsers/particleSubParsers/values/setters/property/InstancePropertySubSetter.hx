package away3d.loaders.parsers.particleSubParsers.values.setters.property;

import away3d.animators.data.ParticleProperties;
import away3d.animators.data.ParticleInstanceProperty;
import away3d.loaders.parsers.particleSubParsers.values.setters.SetterBase;
import openfl.geom.Vector3D;

class InstancePropertySubSetter extends SetterBase
{
    private var _positionSetter : SetterBase;
    private var _rotationSetter : SetterBase;
    private var _scaleSetter : SetterBase;
    private var _timeOffsetSetter : SetterBase;
    private var _playSpeedSetter : SetterBase;
    
    public function new(propName : String, positionSetter : SetterBase, rotationSetter : SetterBase, scaleSetter : SetterBase, timeOffsetSetter : SetterBase, playSpeedSetter : SetterBase)
    {
        super(propName);
        _positionSetter = positionSetter;
        _rotationSetter = rotationSetter;
        _scaleSetter = scaleSetter;
        _timeOffsetSetter = timeOffsetSetter;
        _playSpeedSetter = playSpeedSetter;
    }
    
    override public function setProps(prop : ParticleProperties) : Void
    {
        if(Reflect.hasField(prop,_propName)){
            Reflect.setProperty(prop,_propName,generateOneValue(prop.index, prop.total));
        }
        else
            prop.nodes.set(_propName,generateOneValue(prop.index, prop.total));
    }
    
    override public function generateOneValue(index : Int = 0, total : Int = 1) : Dynamic
    {
        var position : Vector3D = (_positionSetter != null) ? _positionSetter.generateOneValue(index, total) : null;
        var rotation : Vector3D = (_rotationSetter != null) ? _rotationSetter.generateOneValue(index, total) : null;
        var scale : Vector3D = (_scaleSetter != null) ? _scaleSetter.generateOneValue(index, total) : null;
        var timeOffset : Float = (_timeOffsetSetter != null) ? _timeOffsetSetter.generateOneValue(index, total) : 0;
        var playSpeed : Float = (_playSpeedSetter != null) ? _playSpeedSetter.generateOneValue(index, total) : 1;
        return new ParticleInstanceProperty(position, rotation, scale, timeOffset, playSpeed);
    }
    
    override public function startPropsGenerating(prop : ParticleProperties) : Void
    {
        if (_positionSetter != null)
        {
            _positionSetter.startPropsGenerating(prop);
        }
        if (_rotationSetter != null)
        {
            _rotationSetter.startPropsGenerating(prop);
        }
        if (_scaleSetter != null)
        {
            _scaleSetter.startPropsGenerating(prop);
        }
        if (_timeOffsetSetter != null)
        {
            _timeOffsetSetter.startPropsGenerating(prop);
        }
        if (_playSpeedSetter != null)
        {
            _playSpeedSetter.startPropsGenerating(prop);
        }
    }
    
    override public function finishPropsGenerating(prop : ParticleProperties) : Void
    {
        if (_positionSetter != null)
        {
            _positionSetter.finishPropsGenerating(prop);
        }
        if (_rotationSetter != null)
        {
            _rotationSetter.finishPropsGenerating(prop);
        }
        if (_scaleSetter != null)
        {
            _scaleSetter.finishPropsGenerating(prop);
        }
        if (_timeOffsetSetter != null)
        {
            _timeOffsetSetter.finishPropsGenerating(prop);
        }
        if (_playSpeedSetter != null)
        {
            _playSpeedSetter.finishPropsGenerating(prop);
        }
    }
}

