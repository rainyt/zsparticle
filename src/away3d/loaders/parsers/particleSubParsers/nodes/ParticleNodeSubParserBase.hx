package away3d.loaders.parsers.particleSubParsers.nodes;

import away3d.animators.nodes.ParticleNodeBase;
import away3d.loaders.parsers.CompositeParserBase;
import away3d.loaders.parsers.particleSubParsers.values.setters.SetterBase;

class ParticleNodeSubParserBase extends CompositeParserBase
{
    public var setters(get, never) : Array<SetterBase>;
    public var particleAnimationNode(get, never) : ParticleNodeBase;

    private var _setters : Array<SetterBase> = new Array<SetterBase>();
    private var _particleAnimationNode : ParticleNodeBase;
    
    public function new()
    {
        super();
    }
    
    private function get_setters() : Array<SetterBase>
    {
        return _setters;
    }
    
    private function get_particleAnimationNode() : ParticleNodeBase
    {
        return _particleAnimationNode;
    }
}


