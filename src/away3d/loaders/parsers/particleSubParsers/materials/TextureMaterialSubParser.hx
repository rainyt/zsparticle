package away3d.loaders.parsers.particleSubParsers.materials;


import away3d.library.assets.Asset3DType;
import away3d.library.assets.IAsset;
import away3d.loaders.misc.ResourceDependency;
import away3d.loaders.parsers.particleSubParsers.AllIdentifiers;
import away3d.materials.MaterialBase;
import away3d.materials.TextureMaterial;
import away3d.textures.Texture2DBase;
import openfl.net.URLRequest;

class TextureMaterialSubParser extends MaterialSubParserBase
{
    public static var identifier(get, never) : Dynamic;

    private var _texture : TextureMaterial;
    
    private var _repeat : Bool;
    private var _smooth : Bool;
    private var _alphaBlending : Bool;
    private var _alphaThreshold : Float = 0;
    
    public function new()
    {
        super();
    }
    
    
    override private function proceedParsing() : Bool
    {
        if (_isFirstParsing)
        {
            _repeat = _data.repeat;
            _smooth = _data.smooth;
            _alphaBlending = _data.alphaBlending;
            _alphaThreshold = _data.alphaThreshold;
            if (_data.url)
            {
                var url : URLRequest = new URLRequest(_data.url);
                addDependency("default1", url);
            }
            else
            {
                dieWithError("no texture url");
                return ParserBase.MORE_TO_PARSE;
            }
        }
        return super.proceedParsing();
    }
    
    override private function resolveDependency(resourceDependency : ResourceDependency) : Void
    {
        var assets : openfl.Vector<IAsset> = resourceDependency.assets;
        var len : Int = assets.length;
        for (i in 0...len)
        {
            var asset : IAsset = assets[i];
            if (asset.assetType == Asset3DType.TEXTURE)
            
            //retire the first bitmapTexture
            {
                
                _texture = new TextureMaterial(try cast(asset, Texture2DBase) catch(e:Dynamic) null, _smooth, _repeat);
                _texture.bothSides = _bothSide;
                _texture.alphaBlending = _alphaBlending;
                _texture.blendMode = _blendMode;
                _texture.alphaThreshold = _alphaThreshold;
                finalizeAsset(_texture);
                return;
            }
        }
        dieWithError("resolveDependencyFailure");
    }
    
    override private function resolveDependencyFailure(resourceDependency : ResourceDependency) : Void
    {
        dieWithError("resolveDependencyFailure");
    }
    
    override private function get_material() : MaterialBase
    {
        return _texture;
    }
    
    private static function get_identifier() : Dynamic
    {
        return AllIdentifiers.TextureMaterialSubParser;
    }
}


