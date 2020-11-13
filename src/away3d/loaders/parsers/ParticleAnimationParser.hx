package away3d.loaders.parsers;

import away3d.animators.ParticleAnimationSet;
import away3d.animators.ParticleAnimator;
import away3d.bounds.BoundingSphere;
import away3d.core.base.ParticleGeometry;
import away3d.entities.Mesh;
import away3d.loaders.misc.ResourceDependency;
import away3d.loaders.parsers.particleSubParsers.AllSubParsers;
import away3d.loaders.parsers.particleSubParsers.materials.MaterialSubParserBase;
import away3d.loaders.parsers.particleSubParsers.nodes.ParticleNodeSubParserBase;
import away3d.loaders.parsers.particleSubParsers.nodes.ParticleTimeNodeSubParser;
import away3d.loaders.parsers.particleSubParsers.utils.MatchingTool;
import away3d.loaders.parsers.particleSubParsers.values.ValueSubParserBase;
import away3d.loaders.parsers.particleSubParsers.values.setters.SetterBase;
import openfl.geom.Vector3D;
import openfl.net.URLRequest;
import away3d.animators.data.ParticleProperties;


class ParticleAnimationParser extends CompositeParserBase
{
    public var particleMesh(get, never) : Mesh;

    private var _particleMesh : Mesh;
    private var _particleAnimator : ParticleAnimator;
    private var _particleAnimationSet : ParticleAnimationSet;
    private var _particleGeometry : ParticleGeometry;
    private var _bounds : Float;
    
    private var _nodeParsers : Array<ParticleNodeSubParserBase>;
    private var _particleMaterialParser : MaterialSubParserBase;
    private var _particlegeometryParser : ParticleGeometryParser;
    private var _globalValues : Array<ValueSubParserBase>;
    
    
    public function new()
    {
        super();
    }
    
    public static function supportsType(extension : String) : Bool
    {
        extension = extension.toLowerCase();
        return extension == "pam";
    }
    
    public static function supportsData(data : Dynamic) : Bool
    {
        return false;
    }
    
    override private function proceedParsing() : Bool
    {
        if (_isFirstParsing)
        //bounds
        {
            
            _bounds = _data.bounds;
            
            //material
            var object : Dynamic = _data.material;
            var id : Dynamic = object.id;
            var subData : Dynamic = object.data;
            var parserCls : Class<Dynamic> = MatchingTool.getMatchedClass(id, AllSubParsers.ALL_MATERIALS);
            if (parserCls == null)
            {
                dieWithError("Unknown matierla parser " + id + AllSubParsers.ALL_MATERIALS);
            }
            
            _particleMaterialParser = Type.createInstance(parserCls, []);
            addSubParser(_particleMaterialParser);
            _particleMaterialParser.parseAsync(subData);
            
            
            //animation nodes:
            _nodeParsers = new Array<ParticleNodeSubParserBase>();
            
            var nodeDatas : Array<Dynamic> = _data.nodes;
            
            for (nodedata in nodeDatas)
            {
                subData = nodedata.data;
                id = nodedata.id;
                parserCls = MatchingTool.getMatchedClass(id, AllSubParsers.ALL_PARTICLE_NODES);
                
                if (parserCls == null)
                {
                    dieWithError("Unknown node parser");
                }
                
                var nodeParser : ParticleNodeSubParserBase = Type.createInstance(parserCls, []);
                addSubParser(nodeParser);
                nodeParser.parseAsync(subData);
                _nodeParsers.push(nodeParser);
            }
            
            var globalValuesDatas : Array<Dynamic> = _data.globalValues;
            if (globalValuesDatas != null)
            {
                _globalValues = new Array<ValueSubParserBase>();
                for (valuedata in globalValuesDatas)
                {
                    subData = valuedata.data;
                    id = valuedata.id;
                    parserCls = MatchingTool.getMatchedClass(id, AllSubParsers.ALL_GLOBAL_VALUES);
                    if (parserCls == null)
                    {
                        dieWithError("Unknown node parser");
                    }
                    var valueParser : ValueSubParserBase = Type.createInstance(parserCls, [null]);
                    addSubParser(valueParser);
                    valueParser.parseAsync(subData);
                    _globalValues.push(valueParser);
                }
            }
            
            
            //geometry:
            var geometryData : Dynamic = _data.geometry;
            if (geometryData.embed)
            {
                _particlegeometryParser = new ParticleGeometryParser();
                addSubParser(_particlegeometryParser);
                _particlegeometryParser.parseAsync(geometryData.data);
            }
            else
            {
                addDependency("geometry", new URLRequest(geometryData.url), true);
            }
        }
        
        
        var bool = super.proceedParsing();
        if (bool == ParserBase.PARSING_DONE)
        {
            generateAnimation();
            return ParserBase.PARSING_DONE;
        }
        else
        {
            return ParserBase.MORE_TO_PARSE;
        }
    }
    
    override private function resolveDependency(resourceDependency : ResourceDependency) : Void
    {
        if (resourceDependency.id == "geometry")
        {
            _particlegeometryParser = new ParticleGeometryParser();
            addSubParser(_particlegeometryParser);
            _particlegeometryParser.parseAsync(resourceDependency.data);
        }
    }
    
    override private function resolveDependencyFailure(resourceDependency : ResourceDependency) : Void
    {
        dieWithError("resolveDependencyFailure");
    }
    
    
    private function generateAnimation() : Void
    //animation Set:
    {
        
        var timeNode : ParticleTimeNodeSubParser = try cast(_nodeParsers[0], ParticleTimeNodeSubParser) catch(e:Dynamic) null;
        _particleAnimationSet = new ParticleAnimationSet(timeNode.usesDuration, timeNode.usesLooping, timeNode.usesDelay);
        var len : Int = _nodeParsers.length;
        var handlers : Array<SetterBase> = new Array<SetterBase>();
        if (_globalValues != null)
        {
            for (valueParser in _globalValues)
            {
                handlers.push(valueParser.setter);
            }
        }
        for (i in 0..._nodeParsers.length)
        {
            if (i != 0)
            {
                _particleAnimationSet.addAnimation(_nodeParsers[i].particleAnimationNode);
            }
            var setters : Array<SetterBase> = _nodeParsers[i].setters;
            for (setter in setters)
            {
                handlers.push(setter);
            }
        }
        var particleInitializer : ParticleInitializer = new ParticleInitializer(handlers);
        _particleAnimationSet.initParticleFunc = particleInitializer.initHandler;
        finalizeAsset(_particleAnimationSet);
        //animator:
        _particleAnimator = new ParticleAnimator(_particleAnimationSet);
        
        //mesh:
        // _particleMesh = new Mesh(_particlegeometryParser.particleGeometry); //_particleMaterialParser.material
        _particleMesh = new Mesh(_particlegeometryParser.particleGeometry,_particleMaterialParser.material); //_particleMaterialParser.material
        _particleMesh.bounds = new BoundingSphere();
        _particleMesh.bounds.fromSphere(new Vector3D(), _bounds);
        if (_data.shareAnimationGeometry != null)
        {
            _particleMesh.shareAnimationGeometry = _data.shareAnimationGeometry;
        }
        if (_data.name != null)
        {
            _particleMesh.name = _data.name;
        }
        _particleMesh.animator = _particleAnimator;
        finalizeAsset(_particleMesh);
    }
    
    private function get_particleMesh() : Mesh
    {
        return _particleMesh;
    }
}






class ParticleInitializer
{
    private var _setters : Array<SetterBase>;
    
    public function new(setters : Array<SetterBase>)
    {
        _setters = setters;
    }
    
    /**
     * TODO，属性可能没有正确赋值
     * @param prop 
     */
    public function initHandler(prop : ParticleProperties) : Void
    {
        var setter : SetterBase;
        if (prop.index == 0)
        {
            for (setter in _setters)
            {
                setter.startPropsGenerating(prop);
            }
        }
        
        for (setter in _setters)
        {
            setter.setProps(prop);
        }
        
        if (prop.index == prop.total - 1)
        {
            for (setter in _setters)
            {
                setter.finishPropsGenerating(prop);
            }
        }
    }
}
