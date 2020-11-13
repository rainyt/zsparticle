package away3d.loaders.parsers.particleSubParsers.nodes;

import away3d.animators.nodes.ParticleSegmentedScaleNode;
import away3d.loaders.parsers.particleSubParsers.AllIdentifiers;
import away3d.loaders.parsers.particleSubParsers.values.threeD.ThreeDConstValueSubParser;
import openfl.geom.Vector3D;
import openfl.Vector;

class ParticleSegmentedScaleNodeSubParser extends ParticleNodeSubParserBase
{
    public static var identifier(get, never) : Dynamic;

    private var _startScaleValue : ThreeDConstValueSubParser;
    private var _endScaleValue : ThreeDConstValueSubParser;
    private var _segmentPoints : Array<{
        life:Dynamic,
        scale:ThreeDConstValueSubParser
    }>;
    
    
    public function new()
    {
        super();
    }
    
    override private function proceedParsing() : Bool
    {
        if (_isFirstParsing)
        {
            var object : Dynamic;
            var Id : Dynamic;
            var subData : Dynamic;
            
            object = _data.startScale;
            //Id = object.id;
            subData = object.data;
            _startScaleValue = new ThreeDConstValueSubParser(null);
            addSubParser(_startScaleValue);
            _startScaleValue.parseAsync(subData);
            
            object = _data.endScale;
            //Id = object.id;
            subData = object.data;
            _endScaleValue = new ThreeDConstValueSubParser(null);
            addSubParser(_endScaleValue);
            _endScaleValue.parseAsync(subData);
            
            _segmentPoints = new Array<{
                life:Dynamic,
                scale:ThreeDConstValueSubParser
            }>();
            var pointsData : Array<Dynamic> = _data.segmentPoints;
            for (i in 0...pointsData.length)
            {
                var scaleValue : ThreeDConstValueSubParser = new ThreeDConstValueSubParser(null);
                addSubParser(scaleValue);
                _segmentPoints.push({
                            life : pointsData[i].life,
                            scale : scaleValue
                        });
                scaleValue.parseAsync(pointsData[i].scale.data);
            }
            //TODO 还没实现修改此方法
            _segmentPoints.sort(function(a,b){
                return a.life < a.life ? -1 : 1;
            });
            // _segmentPoints.sortOn("life", Array.NUMERIC | Array.CASEINSENSITIVE);
            //make sure all life values are different
            for (i in 0...pointsData.length - 1)
            {
                if (_segmentPoints[i].life == _segmentPoints[i + 1].life)
                {
                    _segmentPoints[i].life -= 0.00001 * (pointsData.length - i);
                }
            }
        }
        
        if (super.proceedParsing() == ParserBase.PARSING_DONE)
        {
            initProps();
            return ParserBase.PARSING_DONE;
        }
        else
        {
            return ParserBase.MORE_TO_PARSE;
        }
    }
    
    private function initProps() : Void
    {
        var segmentPoints : Vector<Vector3D> = new Vector<Vector3D>();
        var len : Int = _segmentPoints.length;
        var i : Int = 0;
        while (i < len)
        {
            var scale : Vector3D = _segmentPoints[i].scale.setter.generateOneValue();
            scale.w = _segmentPoints[i].life;
            segmentPoints.push(scale);
            i++;
        }
        _particleAnimationNode = new ParticleSegmentedScaleNode(len, _startScaleValue.setter.generateOneValue(), _endScaleValue.setter.generateOneValue(), segmentPoints);
    }
    
    private static function get_identifier() : Dynamic
    {
        return AllIdentifiers.ParticleSegmentedScaleNodeSubParser;
    }
}

