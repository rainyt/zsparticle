package away3d.loaders.parsers.particleSubParsers.values.setters.color;

import away3d.animators.data.ParticleProperties;
import away3d.loaders.parsers.particleSubParsers.values.setters.SetterBase;
import openfl.geom.ColorTransform;

class CompositeColorSetter extends SetterBase
{
    private var _redMultiplierSetter : SetterBase;
    private var _greenMultiplierSetter : SetterBase;
    private var _blueMultiplierSetter : SetterBase;
    private var _alphaMultiplierSetter : SetterBase;
    
    private var _redOffsetSetter : SetterBase;
    private var _greenOffsetSetter : SetterBase;
    private var _blueOffsetSetter : SetterBase;
    private var _alphaOffsetSetter : SetterBase;
    
    public function new(propName : String, redMultiplierSetter : SetterBase, greenMultiplierSetter : SetterBase, blueMultiplierSetter : SetterBase, alphaMultiplierSetter : SetterBase, redOffsetSetter : SetterBase, greenOffsetSetter : SetterBase, blueOffsetSetter : SetterBase, alphaOffsetSetter : SetterBase)
    {
        super(propName);
        _redMultiplierSetter = redMultiplierSetter;
        _greenMultiplierSetter = greenMultiplierSetter;
        _blueMultiplierSetter = blueMultiplierSetter;
        _alphaMultiplierSetter = alphaMultiplierSetter;
        
        _redOffsetSetter = redOffsetSetter;
        _greenOffsetSetter = greenOffsetSetter;
        _blueOffsetSetter = blueOffsetSetter;
        _alphaOffsetSetter = alphaOffsetSetter;
    }
    
    override public function setProps(prop : ParticleProperties) : Void
    {
        if(Reflect.hasField(prop,_propName)){
            Reflect.setProperty(prop,_propName,generateOneValue(prop.index, prop.total));
        }
        else
            prop.nodes.set(_propName , generateOneValue(prop.index, prop.total));
    }
    
    override public function generateOneValue(index : Int = 0, total : Int = 1) : Dynamic
    {
        var rm : Float = (_redMultiplierSetter != null) ? _redMultiplierSetter.generateOneValue(index, total) : 0;
        var gm : Float = (_greenMultiplierSetter != null) ? _greenMultiplierSetter.generateOneValue(index, total) : 0;
        var bm : Float = (_blueMultiplierSetter != null) ? _blueMultiplierSetter.generateOneValue(index, total) : 0;
        var am : Float = (_alphaMultiplierSetter != null) ? _alphaMultiplierSetter.generateOneValue(index, total) : 0;
        
        var ro : Float = (_redOffsetSetter != null) ? _redOffsetSetter.generateOneValue(index, total) : 0;
        var go : Float = (_greenOffsetSetter != null) ? _greenOffsetSetter.generateOneValue(index, total) : 0;
        var bo : Float = (_blueOffsetSetter != null) ? _blueOffsetSetter.generateOneValue(index, total) : 0;
        var ao : Float = (_alphaOffsetSetter != null) ? _alphaOffsetSetter.generateOneValue(index, total) : 0;
        return new ColorTransform(rm, gm, bm, am, ro, go, bo, ao);
    }
    
    override public function startPropsGenerating(prop : ParticleProperties) : Void
    {
        if (_redMultiplierSetter != null)
        {
            _redMultiplierSetter.startPropsGenerating(prop);
        }
        if (_greenMultiplierSetter != null)
        {
            _greenMultiplierSetter.startPropsGenerating(prop);
        }
        if (_blueMultiplierSetter != null)
        {
            _blueMultiplierSetter.startPropsGenerating(prop);
        }
        if (_alphaMultiplierSetter != null)
        {
            _alphaMultiplierSetter.startPropsGenerating(prop);
        }
        
        if (_redOffsetSetter != null)
        {
            _redOffsetSetter.startPropsGenerating(prop);
        }
        if (_greenOffsetSetter != null)
        {
            _greenOffsetSetter.startPropsGenerating(prop);
        }
        if (_blueOffsetSetter != null)
        {
            _blueOffsetSetter.startPropsGenerating(prop);
        }
        if (_alphaOffsetSetter != null)
        {
            _alphaOffsetSetter.startPropsGenerating(prop);
        }
    }
    
    override public function finishPropsGenerating(prop : ParticleProperties) : Void
    {
        if (_redMultiplierSetter != null)
        {
            _redMultiplierSetter.finishPropsGenerating(prop);
        }
        if (_greenMultiplierSetter != null)
        {
            _greenMultiplierSetter.finishPropsGenerating(prop);
        }
        if (_blueMultiplierSetter != null)
        {
            _blueMultiplierSetter.finishPropsGenerating(prop);
        }
        if (_alphaMultiplierSetter != null)
        {
            _alphaMultiplierSetter.finishPropsGenerating(prop);
        }
        
        if (_redOffsetSetter != null)
        {
            _redOffsetSetter.finishPropsGenerating(prop);
        }
        if (_greenOffsetSetter != null)
        {
            _greenOffsetSetter.finishPropsGenerating(prop);
        }
        if (_blueOffsetSetter != null)
        {
            _blueOffsetSetter.finishPropsGenerating(prop);
        }
        if (_alphaOffsetSetter != null)
        {
            _alphaOffsetSetter.finishPropsGenerating(prop);
        }
    }
}

