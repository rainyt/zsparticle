package away3d.loaders.parsers;

import openfl.errors.Error;
import away3d.animators.data.ParticleGroupEventProperty;
import away3d.animators.data.ParticleInstanceProperty;
import away3d.entities.Mesh;
import away3d.entities.ParticleGroup;
import away3d.loaders.misc.ResourceDependency;
import away3d.loaders.parsers.particleSubParsers.values.property.InstancePropertySubParser;
import openfl.net.URLRequest;

class ParticleGroupParser extends CompositeParserBase
{
    public var particleGroup(get, never) : ParticleGroup;

    
    private var _particleGroup : ParticleGroup;
    private var _animationParsers : Array<ParticleAnimationParser>;
    private var _instancePropertyParsers : Array<InstancePropertySubParser>;
    private var _customParameters : Dynamic;
    private var _particleEvents : Array<ParticleGroupEventProperty>;
    
    public function new()
    {
        super();
    }
    
    public static function supportsType(extension : String) : Bool
    {
        extension = extension.toLowerCase();
        return extension == "awp";
    }
    
    public static function supportsData(data : Dynamic) : Bool
    {
        var serializedData : Dynamic;
        
        if(!Std.is(data,String))
        {
            return false;
        }
        
        try
        {
            serializedData = haxe.Json.parse(data);
        }
        catch (e : Error)
        {
            return false;
        }
        
        return serializedData.exists("animationDatas");
    }
    
    
    override private function proceedParsing() : Bool
    {
        if (_isFirstParsing)
        {
            _customParameters = _data.customParameters;
            var animationDatas : Array<Dynamic> = _data.animationDatas;
            _animationParsers = new Array<ParticleAnimationParser>();
            _instancePropertyParsers = new Array<InstancePropertySubParser>();
            
            var particleEventsData : Array<Dynamic> = try cast(_data.particleEvents, Array<Dynamic>) catch(e:Dynamic) null;
            if (particleEventsData != null)
            {
                _particleEvents = new Array<ParticleGroupEventProperty>();
                for (event in particleEventsData)
                {
                    _particleEvents.push(new ParticleGroupEventProperty(event.occurTime, event.name));
                }
            }
            
            for (index in 0...animationDatas.length)
            {
                var animationData : Dynamic = animationDatas[index];
                var propertyData : Dynamic = animationData.property;
                if (propertyData != null)
                {
                    var instancePropertyParser : InstancePropertySubParser = new InstancePropertySubParser(null);
                    addSubParser(instancePropertyParser);
                    instancePropertyParser.parseAsync(propertyData.data);
                    _instancePropertyParsers[index] = instancePropertyParser;
                }
                if (animationData.embed)
                {
                    var animationParser : ParticleAnimationParser = new ParticleAnimationParser();
                    addSubParser(animationParser);
                    animationParser.parseAsync(animationData.data);
                    _animationParsers[index] = animationParser;
                }
                else
                {
                    addDependency(Std.string(index), new URLRequest(animationData.url), true);
                }
            }
        }
        
        if (super.proceedParsing() == ParserBase.PARSING_DONE)
        {
            generateGroup();
            finalizeAsset(_particleGroup);
            return ParserBase.PARSING_DONE;
        }
        else
        {
            return ParserBase.MORE_TO_PARSE;
        }
    }
    
    override private function resolveDependency(resourceDependency : ResourceDependency) : Void
    {
        var index : Int = Std.parseInt(resourceDependency.id);
        var animationParser : ParticleAnimationParser = new ParticleAnimationParser();
        addSubParser(animationParser);
        animationParser.parseAsync(resourceDependency.data);
        _animationParsers[index] = animationParser;
    }
    
    override private function resolveDependencyFailure(resourceDependency : ResourceDependency) : Void
    {
        dieWithError("resolveDependencyFailure");
    }
    
    private function generateGroup() : Void
    {
        var len : Int = _animationParsers.length;
        var particleMeshes : Array<Mesh> = new Array<Mesh>();
        var instanceProperties : Array<ParticleInstanceProperty> = new Array<ParticleInstanceProperty>();
        
        for (index in 0..._animationParsers.length)
        {
            var animationParser : ParticleAnimationParser = _animationParsers[index];
            if (_instancePropertyParsers[index] != null)
            {
                instanceProperties[index] = cast((_instancePropertyParsers[index].setter.generateOneValue()), ParticleInstanceProperty);
            }
            particleMeshes.push(animationParser.particleMesh);
        }
        _particleGroup = new ParticleGroup(particleMeshes, instanceProperties, _customParameters, _particleEvents);
    }
    
    private function get_particleGroup() : ParticleGroup
    {
        return _particleGroup;
    }
}

