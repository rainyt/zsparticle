package away3d.loaders.parsers.particleSubParsers.values.setters.oneD;

import away3d.animators.data.ParticleProperties;
import away3d.loaders.parsers.particleSubParsers.values.setters.SetterBase;

class OneDCurveSetter extends SetterBase
{
    private var _anchors : Array<Anchor>;
    
    public function new(propName : String, anchorDatas : Array<Dynamic>)
    {
        super(propName);
        var len : Int = anchorDatas.length;
        _anchors = new Array<Anchor>();
        for (i in 0...len)
        {
            _anchors[i] = new Anchor(anchorDatas[i].x, anchorDatas[i].y, anchorDatas[i].type);
        }
    }
    
    override public function setProps(prop : ParticleProperties) : Void
    {
        prop.nodes.set(_propName , generateOneValue(prop.index, prop.total));
    }
    
    override public function generateOneValue(index : Int = 0, total : Int = 1) : Dynamic
    //todo:optimise
    {
        
        var percent : Float = index / total;
        var i : Int = 0;
        while (i < _anchors.length - 1)
        {
            if (_anchors[i + 1].x > percent)
            {
                var _sw0_ = (_anchors[i].type);                

                switch (_sw0_)
                {
                    case Anchor.LINEAR:
                        return _anchors[i].y + (percent - _anchors[i].x) / (_anchors[i + 1].x - _anchors[i].x) * (_anchors[i + 1].y - _anchors[i].y);
                    case Anchor.CONST:
                        return _anchors[i].y;
                }
            }
            i++;
        }
        return _anchors[i].y;
    }
}




class Anchor
{
    //TODO: add the bezier curve support
    public static inline var LINEAR : Int = 0;
    public static inline var CONST : Int = 1;
    public static inline var BEZIER : Int = 2;
    
    public var x : Float;
    public var y : Float;
    public var type : Int;
    
    public function new(x : Float, y : Float, type : Int)
    {
        this.x = x;
        this.y = y;
        this.type = type;
    }
}
