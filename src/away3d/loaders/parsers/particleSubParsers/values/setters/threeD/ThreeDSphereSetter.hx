package away3d.loaders.parsers.particleSubParsers.values.setters.threeD;

import away3d.animators.data.ParticleProperties;
import away3d.loaders.parsers.particleSubParsers.values.setters.SetterBase;
import openfl.geom.Vector3D;

class ThreeDSphereSetter extends SetterBase
{
    private var _innerRadius3 : Float;
    private var _outerRadius3 : Float;
    private var _centerX : Float;
    private var _centerY : Float;
    private var _centerZ : Float;
    
    public function new(propName : String, innerRadius : Float, outerRadius : Float, centerX : Float, centerY : Float, centerZ : Float)
    {
        super(propName);
        _innerRadius3 = Math.pow(innerRadius, 3);
        _outerRadius3 = Math.pow(outerRadius, 3);
        _centerX = centerX;
        _centerY = centerY;
        _centerZ = centerZ;
    }
    
    override public function setProps(prop : ParticleProperties) : Void
    {
        prop.nodes.set(_propName, generateOneValue(prop.index, prop.total));
    }
    
    override public function generateOneValue(index : Int = 0, total : Int = 1) : Dynamic
    {
        var degree1 : Float = Math.random() * Math.PI * 2;
        
        var radius : Float = Math.pow(Math.random() * (_outerRadius3 - _innerRadius3) + _innerRadius3, 1 / 3);
        var direction : Vector3D = new Vector3D(Math.random() - 0.5, Math.random() - 0.5, Math.random() - 0.5);
        if (direction.length == 0)
        {
            direction.x = 1;
        }
        direction.normalize();
        direction.scaleBy(radius);
        direction.x += _centerX;
        direction.y += _centerY;
        direction.z += _centerZ;
        return direction;
    }
}


