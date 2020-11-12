package away3d.loaders.parsers.particleSubParsers.nodes;

import away3d.animators.data.ParticlePropertiesMode;
import away3d.animators.nodes.ParticleOrbitNode;
import away3d.loaders.parsers.particleSubParsers.AllIdentifiers;
import away3d.loaders.parsers.particleSubParsers.AllSubParsers;
import away3d.loaders.parsers.particleSubParsers.utils.MatchingTool;
import away3d.loaders.parsers.particleSubParsers.values.ValueSubParserBase;
import away3d.loaders.parsers.particleSubParsers.values.threeD.ThreeDConstValueSubParser;
import openfl.geom.Vector3D;

class ParticleOrbitNodeSubParser extends ParticleNodeSubParserBase
{
    public static var identifier(get, never) : Dynamic;

    private var _orbitValue : ValueSubParserBase;
    private var _usesCycle : Bool;
    private var _usesPhase : Bool;
    private var _usesEulers : Bool;
    private var _eulersValue : ThreeDConstValueSubParser;
    
    
    public function new()
    {
        super();
    }
    
    override private function proceedParsing() : Bool
    {
        if (_isFirstParsing)
        {
            _usesCycle = _data.usesCycle;
            _usesPhase = _data.usesPhase;
            var object : Dynamic = _data.orbit;
            var Id : Dynamic = object.id;
            var subData : Dynamic = object.data;
            var valueCls : Class<Dynamic> = MatchingTool.getMatchedClass(Id, AllSubParsers.ALL_FOURD_VALUES);
            if (valueCls == null)
            {
                dieWithError("Unknown value");
            }
            _orbitValue = Type.createInstance(valueCls, [ParticleOrbitNode.ORBIT_VECTOR3D]);
            addSubParser(_orbitValue);
            _orbitValue.parseAsync(subData);
            
            object = _data.eulers;
            if (object != null)
            {
                _usesEulers = true;
                Id = object.id;
                subData = object.data;
                _eulersValue = new ThreeDConstValueSubParser(null);
                addSubParser(_eulersValue);
                _eulersValue.parseAsync(subData);
            }
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
        var eulers : Vector3D = (_usesEulers) ? _eulersValue.setter.generateOneValue() : null;
        if (_orbitValue.valueType == ValueSubParserBase.CONST_VALUE)
        {
            var orbit : Vector3D = _orbitValue.setter.generateOneValue();
            _particleAnimationNode = new ParticleOrbitNode(ParticlePropertiesMode.GLOBAL, _usesEulers, _usesCycle, _usesPhase, orbit.x, orbit.y, orbit.z, eulers);
        }
        else
        {
            _particleAnimationNode = new ParticleOrbitNode(ParticlePropertiesMode.LOCAL_STATIC, _usesEulers, _usesCycle, _usesPhase, 100, 1, 0, eulers);
            _setters.push(_orbitValue.setter);
        }
    }
    
    private static function get_identifier() : Dynamic
    {
        return AllIdentifiers.ParticleOrbitNodeSubParser;
    }
}

