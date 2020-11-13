package away3d.loaders.parsers;

import openfl.errors.Error;
import away3d.library.assets.IAsset;
import away3d.loaders.parsers.particleSubParsers.utils.SingleResourceDependency;
import openfl.events.TimerEvent;
import openfl.net.URLRequest;
import openfl.utils.ByteArray;
import openfl.Vector;

class CompositeParserBase extends ParserBase
{
    public var childParsingComplete(get, set) : Bool;
    public var root(get, set) : CompositeParserBase;

    private var _loadedAssetCache : Dynamic = { };
    
    private var _root : CompositeParserBase;
    
    private var _children : Array<CompositeParserBase>;
    
    private var _childParsingComplete : Bool;
    
    private var _isFirstParsing : Bool;
    
    private var _numProcessed : Int;
    
    public function new()
    {
        super(ParserDataFormat.PLAIN_TEXT);
        _root = this;
    }
    
    private function get_childParsingComplete() : Bool
    {
        return _childParsingComplete;
    }
    
    private function set_childParsingComplete(value : Bool) : Bool
    {
        _childParsingComplete = value;
        return value;
    }
    
    public function addSubParser(subParser : CompositeParserBase) : Void
    {
        _children = (_children != null) ? _children : new Array<CompositeParserBase>();
        if (Lambda.indexOf(_children, subParser) != -1)
        {
            throw (new Error("Duplicated add"));
        }
        _children.push(subParser);
        subParser.root = _root;
    }
    
    override public function parseAsync(data : Dynamic, frameLimit : Float = 15) : Void
    {
        // if (Std.is(data, String) || Std.is(data, ByteArray))
        if (Std.is(data, String))
        {
            data = haxe.Json.parse(data);
        }
        _numProcessed = 0;
        _isFirstParsing = true;
        if (_root == this)
        {
            super.parseAsync(data, frameLimit);
            //speed up
            onInterval();
        }
        else
        {
            _data = data;
        }
    }
    
    override private function onInterval(event : TimerEvent = null) : Void
    {
        // Debug.trace("important for debug ", this);
        super.onInterval(event);
    }
    
    override private function proceedParsing() : Bool
    {
        _isFirstParsing = false;
        if (_root.dependencies.length > 0)
        {
            pauseAndRetrieveDependencies();
            return ParserBase.MORE_TO_PARSE;
        }
        if (_children == null)
        {
            return ParserBase.PARSING_DONE;
        }
        
        while (_numProcessed < _children.length)
        {
            if (_children[_numProcessed].proceedParsing() == ParserBase.PARSING_DONE)
            {
                _numProcessed++;
            }
            else
            {
                return ParserBase.MORE_TO_PARSE;
            }
        }
        return ParserBase.PARSING_DONE;
    }
    
    
    override private function addDependency(id : String, req : URLRequest, retrieveAsRawData : Bool = false, data : Dynamic = null, suppressErrorEvents : Bool = false) : Void
    {
        _root.dependencies.push(new SingleResourceDependency(id, req, data, this, retrieveAsRawData, suppressErrorEvents));
    }
    
    override private function finalizeAsset(asset : IAsset, name : String = null) : Void
    {
        (_root == this) ? super.finalizeAsset(asset, name) : _root.finalizeAsset(asset, name);
    }
    
    override private function hasTime() : Bool
    {
        return (_root == this) ? super.hasTime() : _root.hasTime();
    }
    
    override private function set_parsingFailure(b : Bool) : Bool
    {
        _root.parsingFailure = b;
        (_root == this) ? super.parsingFailure = b : _root.parsingFailure = b;
        return b;
    }
    
    override private function get_parsingFailure() : Bool
    {
        return (_root == this) ? super.parsingFailure : _root.parsingFailure;
    }
    
    override private function finishParsing() : Void
    {
        (_root == this) ? super.finishParsing() : null;
    }
    
    override private function dieWithError(message : String = "Unknown parsing error") : Void
    //throw(new Error(message));
    {
        
        (_root == this) ? super.dieWithError(message) : _root.dieWithError(message);
    }
    
    override private function pauseAndRetrieveDependencies() : Void
    {
        (_root == this) ? super.pauseAndRetrieveDependencies() : null;
    }
    
    override private function get_parsingPaused() : Bool
    {
        return (_root == this) ? super.parsingPaused : _root.parsingPaused;
    }
    
    private function get_root() : CompositeParserBase
    {
        return _root;
    }
    
    private function set_root(value : CompositeParserBase) : CompositeParserBase
    {
        _root = value;
        if (_children != null)
        {
            for (child in _children)
            {
                child.root = value;
            }
        }
        return value;
    }
    
    private function addAssets(url : String, assets : Vector<IAsset>) : Void
    {
        Reflect.setField(_loadedAssetCache, url, assets);
    }
    
    private function getAssets(url : String) : Vector<IAsset>
    {
        return Reflect.field(_loadedAssetCache, url);
    }
}


