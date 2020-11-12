package away3d.entities;

import openfl.errors.Error;
import away3d.animators.ParticleAnimator;
import away3d.animators.nodes.ParticleFollowNode;
import away3d.animators.states.ParticleFollowState;

import away3d.bounds.BoundingSphere;
import away3d.containers.ObjectContainer3D;
import openfl.geom.Matrix3D;
import openfl.geom.Vector3D;

import away3d.entities.FollowParticleContainer;



class FollowParticleContainer extends ObjectContainer3D
{
    public var originalSceneTransform(get, never) : Matrix3D;

    
    private var _identityTransform : Matrix3D = new Matrix3D();
    private var _followTarget : TargetObject3D;
    private var _updateBoundMeshes : Array<Mesh> = new Array<Mesh>();
    private var _updatePositionMeshes : Array<Mesh> = new Array<Mesh>();
    private var _tempCenter : Vector3D = new Vector3D();
    
    public function new()
    {
        super();
        _followTarget = new TargetObject3D(this);
        addChild(_followTarget);
    }
    
    
    public function addFollowParticle(mesh : Mesh) : Void
    {
        var animator : ParticleAnimator = try cast(mesh.animator, ParticleAnimator) catch(e:Dynamic) null;
        if (animator == null)
        {
            throw (new Error("not a particle mesh"));
        }
        var followState : ParticleFollowState = try cast(animator.getAnimationStateByName("ParticleFollowLocalDynamic"), ParticleFollowState) catch(e:Dynamic) null;
        if (followState == null)
        {
            throw (new Error("not a follow particle"));
        }
        followState.followTarget = _followTarget;
        addChild(mesh);
        if ((try cast(animator.animationSet.getAnimation("ParticleFollowLocalDynamic"), ParticleFollowNode) catch(e:Dynamic) null)._usesPosition)
        {
            _updateBoundMeshes.push(mesh);
        }
        else
        {
            _updatePositionMeshes.push(mesh);
        }
    }
    
    public function removeFollowParticle(mesh : Mesh) : Void
    {
        var animator : ParticleAnimator = try cast(mesh.animator, ParticleAnimator) catch(e:Dynamic) null;
        if (animator == null)
        {
            throw (new Error("not a particle mesh"));
        }
        var followState : ParticleFollowState = try cast(animator.getAnimationStateByName("ParticleFollowLocalDynamic"), ParticleFollowState) catch(e:Dynamic) null;
        if (followState == null)
        {
            throw (new Error("not a follow particle"));
        }
        followState.followTarget = null;
        removeChild(mesh);
        var index : Int = Lambda.indexOf(_updateBoundMeshes, mesh);
        if (index != -1)
        {
            _updateBoundMeshes.splice(index, 1);
        }
        else
        {
            _updatePositionMeshes.splice(Lambda.indexOf(_updatePositionMeshes, mesh), 1);
        }
    }
    
    private function get_originalSceneTransform() : Matrix3D
    {
        return super.sceneTransform;
    }
    
    override private function get_sceneTransform() : Matrix3D
    {
        if (_sceneTransformDirty)
        {
            var comps = super.sceneTransform.decompose();
            var rawData  = _identityTransform.rawData;
            rawData[0] = comps[2].x;
            rawData[5] = comps[2].y;
            rawData[10] = comps[2].z;
            _identityTransform.copyRawDataFrom(rawData);
        }
        if (_followTarget.sceneTransformDirty)
        {
            updateBounds(_followTarget.position);
        }
        return _identityTransform;
    }
    
    private function updateBounds(center : Vector3D) : Void
    {
        var mesh : Mesh;
        for (mesh in _updateBoundMeshes)
        {
            _tempCenter.copyFrom(center);
            _tempCenter.x /= mesh.scaleX;
            _tempCenter.y /= mesh.scaleY;
            _tempCenter.z /= mesh.scaleZ;
            var bounds : BoundingSphere = try cast(mesh.bounds, BoundingSphere) catch(e:Dynamic) null;
            bounds.fromSphere(_tempCenter, bounds.radius);
        }
        for (mesh in _updatePositionMeshes)
        {
            mesh.position = _followTarget.specificPos;
        }
    }
}



class TargetObject3D extends ObjectContainer3D
{
    public var sceneTransformDirty(get, never) : Bool;

    private var _container : FollowParticleContainer;
    private var _helpTransform : Matrix3D = new Matrix3D();
    
    public var specificPos : Vector3D = new Vector3D();
    private var specificEulers : Vector3D = new Vector3D();
    
    public function new(container : FollowParticleContainer)
    {
        super();
        _container = container;
    }
    
    private function get_sceneTransformDirty() : Bool
    {
        return _sceneTransformDirty;
    }
    
    private function validateTransform() : Void
    {
        if (_sceneTransformDirty)
        {
            _helpTransform.copyFrom(_container.originalSceneTransform);
            var comps = _helpTransform.decompose();
            this.specificPos = comps[0];
            specificPos.x /= comps[2].x;
            specificPos.y /= comps[2].y;
            specificPos.z /= comps[2].z;
            //TODO: find a better way to implement it
            specificEulers.x = 0;
            specificEulers.y = 0;
            specificEulers.z = 0;
            var parent : ObjectContainer3D = _container;
            while (parent != null)
            {
                specificEulers.x += parent.rotationX;
                specificEulers.y += parent.rotationY;
                specificEulers.z += parent.rotationZ;
                parent = parent.parent;
            }
            _sceneTransformDirty = false;
        }
    }
    
    override private function get_x() : Float
    {
        if (_sceneTransformDirty)
        {
            validateTransform();
        }
        return specificPos.x;
    }
    
    override private function get_y() : Float
    {
        if (_sceneTransformDirty)
        {
            validateTransform();
        }
        return specificPos.y;
    }
    
    override private function get_z() : Float
    {
        if (_sceneTransformDirty)
        {
            validateTransform();
        }
        return specificPos.z;
    }
    
    override private function get_position() : Vector3D
    {
        if (_sceneTransformDirty)
        {
            validateTransform();
        }
        return specificPos;
    }
    
    override private function get_rotationX() : Float
    {
        if (_sceneTransformDirty)
        {
            validateTransform();
        }
        return specificEulers.x;
    }
    
    override private function get_rotationY() : Float
    {
        if (_sceneTransformDirty)
        {
            validateTransform();
        }
        return specificEulers.y;
    }
    
    override private function get_rotationZ() : Float
    {
        if (_sceneTransformDirty)
        {
            validateTransform();
        }
        return specificEulers.z;
    }
}
