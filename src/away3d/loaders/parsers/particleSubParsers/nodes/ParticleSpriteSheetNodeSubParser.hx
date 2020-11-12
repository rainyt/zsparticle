package away3d.loaders.parsers.particleSubParsers.nodes;

import openfl.Lib;
import away3d.animators.data.ParticlePropertiesMode;
import away3d.animators.nodes.ParticleSpriteSheetNode;
import away3d.loaders.parsers.particleSubParsers.AllIdentifiers;
import away3d.loaders.parsers.particleSubParsers.AllSubParsers;
import away3d.loaders.parsers.particleSubParsers.utils.MatchingTool;
import away3d.loaders.parsers.particleSubParsers.values.ValueSubParserBase;
import openfl.geom.Vector3D;

class ParticleSpriteSheetNodeSubParser extends ParticleNodeSubParserBase
{
    public static var identifier(get, never) : Dynamic;

    private var _durationValue : ValueSubParserBase;
    
    private var _numColumns : Int;
    private var _numRows : Int;
    private var _total : Int;
    
    private var _usesCycle : Bool;
    private var _usesPhase : Bool;
    
    
    public function new()
    {
        super();
    }
    
    override private function proceedParsing() : Bool
    {
        if (_isFirstParsing)
        {
            _numColumns = _data.numColumns;
            _numRows = _data.numRows;
            _total = _data.total;
            
            _usesCycle = _data.usesCycle;
            _usesPhase = _data.usesPhase;
            
            var object : Dynamic = _data.scale;
            var Id : Dynamic = object.id;
            var subData : Dynamic = object.data;
            
            var valueCls : Class<Dynamic> = MatchingTool.getMatchedClass(Id, AllSubParsers.ALL_FOURD_VALUES);
            if (valueCls == null)
            {
                dieWithError("Unknown value");
            }
            _durationValue = Type.createInstance(valueCls, [ParticleSpriteSheetNode.UV_VECTOR3D]);
            addSubParser(_durationValue);
            _durationValue.parseAsync(subData);
        }
        
        if (super.proceedParsing() == ParserBase.PARSING_DONE)
        {
            initProps();
            return ParserBase.PARSING_DONE;
        }
        else
        {
            return ParserBase.MORE_TO_PARSE;
        }
    }
    
    private function initProps() : Void
    {
        if (_total == 0)
        {
            _total = 2147483647;
            // _total = as3hx.Compat.INT_MAX;
            // _total = Lib.in
        }
        if (_durationValue.valueType == ValueSubParserBase.CONST_VALUE)
        {
            var value : Vector3D = _durationValue.setter.generateOneValue();
            _particleAnimationNode = new ParticleSpriteSheetNode(ParticlePropertiesMode.GLOBAL, _usesCycle, _usesPhase, _numColumns, _numRows, value.x, value.y, _total);
        }
        else
        {
            _particleAnimationNode = new ParticleSpriteSheetNode(ParticlePropertiesMode.LOCAL_STATIC, _usesCycle, _usesPhase, _numColumns, _numRows, 1, 0, _total);
            _setters.push(_durationValue.setter);
        }
    }
    
    private static function get_identifier() : Dynamic
    {
        return AllIdentifiers.ParticleSpriteSheetNodeSubParser;
    }
}

