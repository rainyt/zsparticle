package away3d.loaders.parsers.particleSubParsers.nodes;

import away3d.animators.data.ColorSegmentPoint;
import away3d.animators.data.ParticlePropertiesMode;
import away3d.animators.nodes.ParticleSegmentedColorNode;
import away3d.loaders.parsers.particleSubParsers.AllIdentifiers;
import away3d.loaders.parsers.particleSubParsers.values.ValueSubParserBase;
import away3d.loaders.parsers.particleSubParsers.values.color.CompositeColorValueSubParser;
import away3d.loaders.parsers.particleSubParsers.values.color.ConstColorValueSubParser;
import away3d.loaders.parsers.particleSubParsers.values.oneD.OneDConstValueSubParser;

class ParticleSegmentedColorNodeSubParser extends ParticleNodeSubParserBase
{
    public static var identifier(get, never) : Dynamic;

    private var _startColorValue : ConstColorValueSubParser;
    private var _endColorValue : ConstColorValueSubParser;
    private var _segmentPoints : Array<Dynamic>;
    private var _usesMultiplier : Bool;
    private var _usesOffset : Bool;
    
    
    public function new()
    {
        super();
    }
    
    override private function proceedParsing() : Bool
    {
        if (_isFirstParsing)
        {
            _usesMultiplier = _data.usesMultiplier;
            _usesOffset = _data.usesOffset;
            
            
            var object : Dynamic;
            var Id : Dynamic;
            var subData : Dynamic;
            
            object = _data.startColor;
            //Id = object.id;
            subData = object.data;
            _startColorValue = new ConstColorValueSubParser(null);
            addSubParser(_startColorValue);
            _startColorValue.parseAsync(subData);
            
            object = _data.endColor;
            //Id = object.id;
            subData = object.data;
            _endColorValue = new ConstColorValueSubParser(null);
            addSubParser(_endColorValue);
            _endColorValue.parseAsync(subData);
            
            _segmentPoints = new Array<Dynamic>();
            var pointsData : Array<Dynamic> = _data.segmentPoints;
            for (i in 0...pointsData.length)
            {
                var colorValue : ConstColorValueSubParser = new ConstColorValueSubParser(null);
                addSubParser(colorValue);
                _segmentPoints.push({
                            life : pointsData[i].life,
                            color : colorValue
                        });
                colorValue.parseAsync(pointsData[i].color.data);
            }
            //TODO 未实现
            _segmentPoints.sort(function(a,b){
                return a.life < a.life ? 1 : -1;
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
        var segmentPoints : openfl.Vector<ColorSegmentPoint> = new openfl.Vector<ColorSegmentPoint>();
        var len : Int = _segmentPoints.length;
        var i : Int = 0;
        while (i < len)
        {
            segmentPoints.push(new ColorSegmentPoint(_segmentPoints[i].life,cast(_segmentPoints[i].color,ConstColorValueSubParser).setter.generateOneValue()));
            i++;
        }
        _particleAnimationNode = new ParticleSegmentedColorNode(_usesMultiplier, _usesOffset, len, _startColorValue.setter.generateOneValue(), _endColorValue.setter.generateOneValue(), segmentPoints);
    }
    
    private static function get_identifier() : Dynamic
    {
        return AllIdentifiers.ParticleSegmentedColorNodeSubParser;
    }
}

