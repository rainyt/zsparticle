package away3d.animators.data;

import away3d.animators.ParticleAnimator;
import away3d.entities.Mesh;
import openfl.geom.Vector3D;

class ParticleInstanceProperty
{
    public var timeOffset(get, never) : Float;

    private static var DEFAULT_ZERO : Vector3D = new Vector3D();
    private static var DEFAULT_ONE : Vector3D = new Vector3D(1, 1, 1);
    
    private var _position : Vector3D;
    private var _rotation : Vector3D;
    private var _scale : Vector3D;
    private var _playSpeed : Float;
    
    //Todo:this property can't be set to the _particleMesh.animator
    private var _timeOffset : Float;
    
    private function get_timeOffset() : Float
    {
        return _timeOffset;
    }
    
    
    public function new(position : Vector3D, rotation : Vector3D, scale : Vector3D, timeOffset : Float, playSpeed : Float)
    {
        _position = (position != null) ? position : DEFAULT_ZERO;
        _rotation = (rotation != null) ? rotation : DEFAULT_ZERO;
        _scale = (scale != null) ? scale : DEFAULT_ONE;
        _timeOffset = timeOffset;
        _playSpeed = playSpeed;
    }
    
    public function apply(_particleMesh : Mesh) : Void
    {
        _particleMesh.position = _position.clone();
        _particleMesh.eulers = _rotation.clone();
        _particleMesh.scaleX = _scale.x;
        _particleMesh.scaleY = _scale.y;
        _particleMesh.scaleZ = _scale.z;
        cast((_particleMesh.animator), ParticleAnimator).playbackSpeed = _playSpeed;
    }
}

