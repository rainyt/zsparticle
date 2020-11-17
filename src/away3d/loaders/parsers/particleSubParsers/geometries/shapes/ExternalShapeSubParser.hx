package away3d.loaders.parsers.particleSubParsers.geometries.shapes;


import away3d.core.base.Geometry;
import away3d.library.assets.Asset3DType;
import away3d.library.assets.IAsset;
import away3d.loaders.misc.ResourceDependency;
import away3d.loaders.parsers.particleSubParsers.AllIdentifiers;
import openfl.net.URLRequest;

class ExternalShapeSubParser extends ShapeSubParserBase
{
    public static var identifier(get, never) : Dynamic;

    private var _geometry : Geometry;
    
    public function new()
    {
        super();
    }
    
    override public function getGeometry() : Geometry
    {
        return _geometry;
    }
    
    override private function resolveDependency(resourceDependency : ResourceDependency) : Void
    {
        var assets : openfl.Vector<IAsset> = resourceDependency.assets;
        var len : Int = assets.length;
        for (i in 0...len)
        {
            var asset : IAsset = assets[i];
            if (asset.assetType == Asset3DType.GEOMETRY)
            
            //retire the first geometry
            {
                
                _geometry = try cast(asset, Geometry) catch(e:Dynamic) null;
                return;
            }
        }
        dieWithError("resolveDependencyFailure");
    }
    
    override private function resolveDependencyFailure(resourceDependency : ResourceDependency) : Void
    {
        dieWithError("resolveDependencyFailure");
    }
    
    
    override private function proceedParsing() : Bool
    {
        if (_isFirstParsing)
        {
            if (_data.url != null)
            {
                addDependency("default", new URLRequest(_data.url));
            }
            else
            {
                dieWithError("no external geometry url");
                return ParserBase.MORE_TO_PARSE;
            }
        }
        return super.proceedParsing();
    }
    
    private static function get_identifier() : Dynamic
    {
        return AllIdentifiers.ExternalShapeSubParser;
    }
}


