package away3d.events;

import away3d.animators.data.ParticleGroupEventProperty;
import openfl.events.Event;

class ParticleGroupEvent extends Event
{
    public var eventProperty(get, never) : ParticleGroupEventProperty;

    public static inline var OCCUR : String = "occur";
    
    private var _eventProperty : ParticleGroupEventProperty;
    
    public function new(type : String, eventProperty : ParticleGroupEventProperty, bubbles : Bool = false, cancelable : Bool = false)
    {
        super(type, bubbles, cancelable);
        _eventProperty = eventProperty;
    }
    
    private function get_eventProperty() : ParticleGroupEventProperty
    {
        return _eventProperty;
    }
}

