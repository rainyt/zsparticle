package away3d.loaders.parsers.particleSubParsers.values.setters.matrix;

import away3d.animators.data.ParticleProperties;
import away3d.loaders.parsers.particleSubParsers.values.setters.SetterBase;
import openfl.geom.Matrix;

class Matrix2DUVCompositeSetter extends SetterBase
{
    private var _numColumns : Int;
    private var _numRows : Int;
    private var _selectedValue : SetterBase;
    
    public function new(propName : String, numColumns : Int, numRows : Int, selectedValue : SetterBase)
    {
        super(propName);
        _numColumns = numColumns;
        _numRows = numRows;
        _selectedValue = selectedValue;
    }
    
    override public function setProps(prop : ParticleProperties) : Void
    {
        if(Reflect.hasField(prop,_propName)){
            Reflect.setProperty(prop,_propName,generateOneValue(prop.index, prop.total));
        }
        else
            prop.nodes.set(_propName,  generateOneValue(prop.index, prop.total));
    }
    
    override public function generateOneValue(index : Int = 0, total : Int = 1) : Dynamic
    {
        var matrix : Matrix = new Matrix();
        matrix.scale(1 / _numColumns, 1 / _numRows);
        var selectedIndex : Int = Std.int(_selectedValue.generateOneValue(index, total) % (_numColumns * _numRows));
        //index %= _numColumns * _numRows;
        var row : Int = Std.int(selectedIndex / _numColumns);
        var column : Int = Std.int(selectedIndex % _numColumns);
        matrix.translate(column / _numColumns, row / _numRows);
        return matrix;
    }
    
    override public function startPropsGenerating(prop : ParticleProperties) : Void
    {
        _selectedValue.startPropsGenerating(prop);
    }
    
    override public function finishPropsGenerating(prop : ParticleProperties) : Void
    {
        _selectedValue.finishPropsGenerating(prop);
    }
}

