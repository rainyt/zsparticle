package away3d.animators;

import away3d.animators.data.ParticleGroupEventProperty;
import away3d.animators.data.ParticleInstanceProperty;
import away3d.entities.Mesh;
import away3d.events.ParticleGroupEvent;
import away3d.loaders.parsers.ParticleGroupParser;

/**
	 * ...
	 * @author
	 */
class ParticleGroupAnimator extends AnimatorBase
{
    private var animators : Array<ParticleAnimator> = new Array<ParticleAnimator>();
    private var animatorTimeOffset : Array<Int>;
    private var numAnimator : Int;
    private var eventList : Array<ParticleGroupEventProperty>;
    
    public function new(particleAnimationMeshes : Array<Mesh>, instanceProperties : Array<ParticleInstanceProperty>, eventList : Array<ParticleGroupEventProperty>)
    {
        super(null);
        numAnimator = particleAnimationMeshes.length;
        animatorTimeOffset = new Array<Int>();
        for (index in 0...numAnimator)
        {
            var mesh : Mesh = particleAnimationMeshes[index];
            var animator : ParticleAnimator = try cast(mesh.animator, ParticleAnimator) catch(e:Dynamic) null;
            animators.push(animator);
            animator.autoUpdate = false;
            if (instanceProperties[index] != null)
            {
                animatorTimeOffset[index] = Std.int(instanceProperties[index].timeOffset * 1000);
            }
        }
        
        this.eventList = eventList;
    }
    
    override public function start() : Void
    {
        super.start();
        _absoluteTime = 0;
        for (index in 0...numAnimator)
        {
            var animator : ParticleAnimator = animators[index];
            //cause the animator.absoluteTime to be 0
            animator.update(Std.int(-animator.absoluteTime / animator.playbackSpeed + animator.time));
            
            animator.resetTime(_absoluteTime + animatorTimeOffset[index]);
        }
    }
    
    override private function updateDeltaTime(dt : Float) : Void
    {
        _absoluteTime += Std.int(dt);
        for (animator in animators)
        {
            animator.time = _absoluteTime;
        }
        if (eventList != null)
        {
            for (eventProperty in eventList)
            {
                if (dt != 0 && (eventProperty.occurTime * 1000 - _absoluteTime) * (eventProperty.occurTime * 1000 - (_absoluteTime - dt)) <= 0)
                {
                    if (hasEventListener(ParticleGroupEvent.OCCUR))
                    {
                        dispatchEvent(new ParticleGroupEvent(ParticleGroupEvent.OCCUR, eventProperty));
                    }
                }
            }
        }
    }
    
    public function resetTime(offset : Int = 0) : Void
    {
        for (index in 0...numAnimator)
        {
            var animator : ParticleAnimator = animators[index];
            animator.resetTime(offset + animatorTimeOffset[index]);
        }
    }
}


