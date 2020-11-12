package away3d.loaders.parsers.particleSubParsers.nodes;

import away3d.animators.nodes.ParticleRotateToHeadingNode;
import away3d.loaders.parsers.particleSubParsers.AllIdentifiers;

class ParticleRotateToHeadingNodeSubParser extends ParticleNodeSubParserBase
{
    public static var identifier(get, never) : Dynamic;

    public function new()
    {
        super();
        _particleAnimationNode = new ParticleRotateToHeadingNode();
    }
    
    
    private static function get_identifier() : Dynamic
    {
        return AllIdentifiers.ParticleRotateToHeadingNodeSubParser;
    }
}

