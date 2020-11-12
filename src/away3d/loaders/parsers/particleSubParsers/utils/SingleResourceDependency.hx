package away3d.loaders.parsers.particleSubParsers.utils;

import away3d.library.assets.IAsset;
import away3d.loaders.misc.ResourceDependency;
import away3d.loaders.parsers.CompositeParserBase;
import openfl.net.URLRequest;

/**
	 * ...
	 * @author
     */
@:access(away3d.loaders.parsers.CompositeParserBase)
class SingleResourceDependency extends ResourceDependency
{
    private var _resolved : Bool;
    private var _hasLoaded : Bool;
    private var _originalUrl : String;
    public function new(id : String, req : URLRequest, data : Dynamic, parentParser : CompositeParserBase, retrieveAsRawData : Bool = false, suppressAssetEvents : Bool = false)
    {
        _originalUrl = req.url;
        var loadedAssets = parentParser.root.getAssets(req.url);
        if (loadedAssets != null)
        {
            _hasLoaded = true;
            retrieveAsRawData = true;
            data = true;
        }
        super(id, req, data, parentParser, retrieveAsRawData, suppressAssetEvents);
        if (_hasLoaded)
        {
            trace("shared resource");
            for (asset in loadedAssets)
            {
                assets.push(asset);
            }
        }
    }
    
    override public function resolve() : Void
    {
        if (!_resolved)
        {
            if (!_hasLoaded)
            {
                cast((parentParser), CompositeParserBase).root.addAssets(_originalUrl, assets);
            }
            _resolved = true;
            super.resolve();
        }
    }
}


