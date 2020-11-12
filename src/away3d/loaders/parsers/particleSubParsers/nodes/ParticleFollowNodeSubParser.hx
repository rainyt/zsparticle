package away3d.loaders.parsers.particleSubParsers.nodes;

import away3d.animators.nodes.ParticleFollowNode;
import away3d.loaders.parsers.particleSubParsers.AllIdentifiers;

class ParticleFollowNodeSubParser extends ParticleNodeSubParserBase
{
    public static var identifier(get, never) : Dynamic;

    public function new()
    {
        super();
    }
    
    override private function proceedParsing() : Bool
    {
        if (_isFirstParsing)
        {
            _particleAnimationNode = new ParticleFollowNode(_data.usesPosition, _data.usesRotation);
        }
        return super.proceedParsing();
    }
    
    private static function get_identifier() : Dynamic
    {
        return AllIdentifiers.ParticleFollowNodeSubParser;
    }
}

