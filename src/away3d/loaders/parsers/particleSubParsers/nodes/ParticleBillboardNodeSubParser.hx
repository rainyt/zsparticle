package away3d.loaders.parsers.particleSubParsers.nodes;

import away3d.animators.nodes.ParticleBillboardNode;
import away3d.loaders.parsers.particleSubParsers.AllIdentifiers;
import openfl.geom.Vector3D;

class ParticleBillboardNodeSubParser extends ParticleNodeSubParserBase
{
    public static var identifier(get, never) : Dynamic;

    public function new()
    {
        super();
        _particleAnimationNode = new ParticleBillboardNode();
    }
    
    override private function proceedParsing() : Bool
    {
        if (_isFirstParsing)
        {
            if (_data && _data.usesAxis)
            {
                _particleAnimationNode = new ParticleBillboardNode(new Vector3D(_data.axisX, _data.axisY, _data.axisZ));
            }
            else
            {
                _particleAnimationNode = new ParticleBillboardNode();
            }
        }
        return super.proceedParsing();
    }
    
    private static function get_identifier() : Dynamic
    {
        return AllIdentifiers.ParticleBillboardNodeSubParser;
    }
}

