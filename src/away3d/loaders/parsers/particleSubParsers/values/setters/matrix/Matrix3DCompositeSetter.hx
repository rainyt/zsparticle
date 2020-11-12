package away3d.loaders.parsers.particleSubParsers.values.setters.matrix;

import away3d.animators.data.ParticleProperties;
import away3d.loaders.parsers.particleSubParsers.values.setters.SetterBase;
import openfl.geom.Matrix3D;
import openfl.geom.Vector3D;

class Matrix3DCompositeSetter extends SetterBase
{
    
    public static inline var SCALE : Int = 2;
    public static inline var ROTATION : Int = 1;
    public static inline var TANSLATION : Int = 0;
    
    private static var _scaleHelpMatrix : Matrix3D = new Matrix3D();
    private var _transforms : Array<SetterBase>;
    
    public function new(propName : String, transforms : Array<SetterBase>)
    {
        super(propName);
        _transforms = transforms;
    }
    
    override public function setProps(prop : ParticleProperties) : Void
    {
        prop.nodes.set(_propName,  generateOneValue(prop.index, prop.total));
    }
    
    override public function generateOneValue(index : Int = 0, total : Int = 1) : Dynamic
    {
        var matrix3D : Matrix3D = new Matrix3D();
        var value : Vector3D;
        for (setter in _transforms)
        {
            value = setter.generateOneValue(index, total);
            switch (Std.parseInt(setter.propName))
            {
                case SCALE:
                {
                    //this can support zero scale
                    var rawData : openfl.Vector<Float> = _scaleHelpMatrix.rawData;
                    rawData[0] = value.x;
                    rawData[5] = value.y;
                    rawData[10] = value.z;
                    _scaleHelpMatrix.copyRawDataFrom(rawData);
                    matrix3D.append(_scaleHelpMatrix);
                }
                case ROTATION:
                {
                    matrix3D.appendRotation(value.x, Vector3D.X_AXIS);
                    matrix3D.appendRotation(value.y, Vector3D.Y_AXIS);
                    matrix3D.appendRotation(value.z, Vector3D.Z_AXIS);
                }
                default:
                    {
                        matrix3D.appendTranslation(value.x, value.y, value.z);
                        break;
                    }
            }
        }
        return matrix3D;
    }
    
    override public function startPropsGenerating(prop : ParticleProperties) : Void
    {
        for (setterBase in _transforms)
        {
            setterBase.startPropsGenerating(prop);
        }
    }
    
    override public function finishPropsGenerating(prop : ParticleProperties) : Void
    {
        for (setterBase in _transforms)
        {
            setterBase.finishPropsGenerating(prop);
        }
    }
}


