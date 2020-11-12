package away3d.loaders.parsers.particleSubParsers.values.setters.threeD;

import away3d.animators.data.ParticleProperties;
import away3d.core.math.MathConsts;
import away3d.loaders.parsers.particleSubParsers.values.setters.SetterBase;
import openfl.geom.Matrix3D;
import openfl.geom.Vector3D;

class ThreeDCylinderSetter extends SetterBase
{
    private var _innerRadius : Float;
    private var _outerRadius : Float;
    private var _height : Float;
    private var _centerX : Float;
    private var _centerY : Float;
    private var _centerZ : Float;
    private var _matrix : Matrix3D;
    
    public function new(propName : String, innerRadius : Float, outerRadius : Float, height : Float, centerX : Float, centerY : Float, centerZ : Float, dX : Float, dY : Float, dZ : Float)
    {
        super(propName);
        _innerRadius = innerRadius;
        _outerRadius = outerRadius;
        _height = height;
        _centerX = centerX;
        _centerY = centerY;
        _centerZ = centerZ;
        var direction : Vector3D = new Vector3D(dX, dY, dZ);
        if (direction.length > 0)
        {
            direction.normalize();
            var flag : Int = (direction.dotProduct(Vector3D.Y_AXIS) > 0) ? 1 : -1;
            var degree : Float = flag * Vector3D.angleBetween(Vector3D.Y_AXIS, direction) * MathConsts.RADIANS_TO_DEGREES;
            if (degree != 0)
            {
                var rotationAxis : Vector3D = Vector3D.Y_AXIS.crossProduct(direction);
                _matrix = new Matrix3D();
                _matrix.appendRotation(degree, rotationAxis);
            }
        }
    }
    
    override public function setProps(prop : ParticleProperties) : Void
    {
        prop.nodes.set(_propName , generateOneValue(prop.index, prop.total));
    }
    
    override public function generateOneValue(index : Int = 0, total : Int = 1) : Dynamic
    {
        var h : Float = Math.random() * _height;  // - _height / 2;  
        var r : Float = _outerRadius * Math.pow(Math.random() * (1 - _innerRadius / _outerRadius) + _innerRadius / _outerRadius, 1 / 2);
        var degree1 : Float = Math.random() * Math.PI * 2;
        var point : Vector3D = new Vector3D(r * Math.cos(degree1), h, r * Math.sin(degree1));
        if (_matrix != null)
        {
            point = _matrix.deltaTransformVector(point);
        }
        point.x += _centerX;
        point.y += _centerY;
        point.z += _centerZ;
        return point;
    }
}


