package away3d.entities;

import away3d.animators.ParticleAnimator;
import away3d.animators.ParticleGroupAnimator;
import away3d.animators.data.ParticleGroupEventProperty;
import away3d.animators.data.ParticleInstanceProperty;
import away3d.animators.nodes.ParticleFollowNode;
import away3d.animators.states.ParticleFollowState;
import away3d.bounds.BoundingSphere;
import away3d.containers.ObjectContainer3D;
import away3d.core.base.Object3D;
import openfl.geom.Vector3D;

class ParticleGroup extends ObjectContainer3D
{
    public var customParamters(get, never) : Dynamic;
    public var particleMeshes(get, never) : Array<Mesh>;
    public var showBounds(get, set) : Bool;
    public var animator(get, never) : ParticleGroupAnimator;

    private var _animator : ParticleGroupAnimator;
    private var _particleMeshes : Array<Mesh>;
    private var _instanceProperties : Array<ParticleInstanceProperty>;
    
    private var _followParticleContainer : FollowParticleContainer;
    
    private var _showBounds : Bool;
    
    private var _customParamters : Dynamic;
    private var _eventList : Array<ParticleGroupEventProperty>;
    
    public function new(particleMeshes : Array<Mesh>, instanceProperties : Array<ParticleInstanceProperty>, customParameters : Dynamic = null, eventList : Array<ParticleGroupEventProperty> = null)
    {
        super();
        _followParticleContainer = new FollowParticleContainer();
        addChild(_followParticleContainer);
        
        if (customParameters != null)
        {
            
            //TODO: find a better way
            _customParamters = haxe.Json.parse(haxe.Json.stringify(customParameters));
        }
        else
        {
            _customParamters = { };
        }
        
        _particleMeshes = particleMeshes;
        _instanceProperties = instanceProperties;
        _eventList = eventList;
        
        _animator = new ParticleGroupAnimator(particleMeshes, instanceProperties, _eventList);
        
        for (index in 0...particleMeshes.length)
        {
            var mesh : Mesh = particleMeshes[index];
            var instanceProperty : ParticleInstanceProperty = instanceProperties[index];
            if (instanceProperty != null)
            {
                instanceProperty.apply(mesh);
            }
            if (isFollowParticle(mesh))
            {
                _followParticleContainer.addFollowParticle(mesh);
            }
            else
            {
                addChild(mesh);
            }
        }
    }
    
    override private function get_zOffset() : Int
    {
        return super.zOffset;
    }
    
    override private function set_zOffset(value : Int) : Int
    {
        super.zOffset = value;
        
        for (i in 0...particleMeshes.length)
        {
            particleMeshes[i].zOffset = value;
        }
        return value;
    }
    
    private function get_customParamters() : Dynamic
    {
        return _customParamters;
    }
    
    private function get_particleMeshes() : Array<Mesh>
    {
        return _particleMeshes;
    }
    
    private function get_showBounds() : Bool
    {
        return _showBounds;
    }
    
    private function set_showBounds(value : Bool) : Bool
    {
        _showBounds = value;
        for (mesh in _particleMeshes)
        {
            mesh.showBounds = _showBounds;
        }
        return value;
    }
    
    private function get_animator() : ParticleGroupAnimator
    {
        return _animator;
    }
    
    private function isFollowParticle(mesh : Mesh) : Bool
    {
        var animator : ParticleAnimator = try cast(mesh.animator, ParticleAnimator) catch(e:Dynamic) null;
        if (animator != null)
        {
            var followNode : ParticleFollowNode = try cast(animator.animationSet.getAnimation("ParticleFollowLocalDynamic"), ParticleFollowNode) catch(e:Dynamic) null;
            if (followNode != null)
            {
                return true;
            }
        }
        return false;
    }
    
    override public function clone() : Object3D
    {
        var len : Int = _particleMeshes.length;
        var newMeshes : Array<Mesh> = new Array<Mesh>();
        var i : Int;
        for (i in 0...len)
        {
            newMeshes[i] = try cast(_particleMeshes[i].clone(), Mesh) catch(e:Dynamic) null;
            //TODO: the Away3D doesn't allow to disable the bounds' update, need to change it in next cycle
            var bounds : BoundingSphere = try cast(_particleMeshes[i].bounds, BoundingSphere) catch(e:Dynamic) null;
            newMeshes[i].bounds = new BoundingSphere();
            newMeshes[i].bounds.fromSphere(new Vector3D(), bounds.radius);
        }
        var clone : ParticleGroup = new ParticleGroup(newMeshes, _instanceProperties, customParamters, _eventList);
        clone.pivotPoint = pivotPoint;
        clone.transform = transform;
        clone.partition = partition;
        clone.name = name;
        clone.showBounds = showBounds;
        
        len = numChildren;
        for (i in 0...len)
        {
            var child : ObjectContainer3D = getChildAt(i);
            if (_followParticleContainer != child && Lambda.indexOf(_particleMeshes, try cast(child, Mesh) catch(e:Dynamic) null) == -1)
            {
                clone.addChild(cast((child.clone()), ObjectContainer3D));
            }
        }
        
        return clone;
    }
    
    override public function dispose() : Void
    {
        super.dispose();
        _animator.stop();
        for (mesh in _particleMeshes)
        {
            mesh.dispose();
        }
    }
}


