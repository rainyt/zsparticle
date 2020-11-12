package away3d.animators.data;


class ParticleGroupEventProperty
{
    public var customName(get, never) : String;
    public var occurTime(get, never) : Float;

    private var _occurTime : Float;
    private var _customName : String;
    
    public function new(occurTime : Float, customName : String)
    {
        _occurTime = occurTime;
        _customName = customName;
    }
    
    private function get_customName() : String
    {
        return _customName;
    }
    
    private function get_occurTime() : Float
    {
        return _occurTime;
    }
}

