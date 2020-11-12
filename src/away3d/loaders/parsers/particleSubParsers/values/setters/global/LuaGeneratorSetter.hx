package away3d.loaders.parsers.particleSubParsers.values.setters.global;

import openfl.errors.Error;
import away3d.animators.data.ParticleProperties;
import away3d.loaders.parsers.particleSubParsers.values.setters.SetterBase;

class LuaGeneratorSetter extends SetterBase
{
    private var _luaState : Int;
    private var _code : String;
    
    public function new(propName : String, code : String)
    {
        super(propName);
        _code = code;
    }
    
    override public function startPropsGenerating(prop : ParticleProperties) : Void
    {
        _luaState = Lua.luaL_newstate();
        Lua.luaL_openlibs(_luaState);
        Lua.lua_getglobal(_luaState, "math");
        Lua.lua_getfield(_luaState, -1, "randomseed");
        Lua.lua_remove(_luaState, -2);
        Lua.lua_pushnumber(_luaState, Math.random() * 10000);
        Lua.lua_callk(_luaState, 1, 0, 0, null);
        prop.luaState = _luaState;
        
        var err : Int = Lua.luaL_loadstring(_luaState, _code);
        if (err != 0)
        {
            onError("Lua Parse Error " + err + ": " + Lua.luaL_checklstring(_luaState, 1, 0));
        }
        Lua.lua_setglobal(_luaState, "__main");
    }
    
    private function onError(e : Dynamic) : Void
    {
        trace(e);
        Lua.lua_close(_luaState);
        _luaState = 0;
        throw (new Error(e));
    }
    
    override public function setProps(prop : ParticleProperties) : Void
    {
        Lua.lua_pushnumber(_luaState, prop.index);
        Lua.lua_setglobal(_luaState, "index");
        Lua.lua_pushnumber(_luaState, prop.total);
        Lua.lua_setglobal(_luaState, "total");
        Lua.lua_getglobal(_luaState, "__main");
        var err : Int = Lua.lua_pcallk(_luaState, 0, Lua.LUA_MULTRET, 0, 0, null);
        if (err != 0)
        {
            onError("Lua Execute Error " + err + ": " + Lua.luaL_checklstring(_luaState, 1, 0));
        }
    }
    
    override public function finishPropsGenerating(prop : ParticleProperties) : Void
    {
        Lua.lua_close(_luaState);
        _luaState = 0;
    }
}

