package away3d.loaders.parsers.particleSubParsers.values.setters.oneD;

import away3d.animators.data.ParticleProperties;
import away3d.loaders.parsers.particleSubParsers.values.setters.SetterBase;

class LuaExtractSetter extends SetterBase
{
    private var _varName : String;
    private var _luaState : Int;
    
    public function new(propName : String, varName : String)
    {
        super(propName);
        _varName = varName;
    }
    
    override public function startPropsGenerating(prop : ParticleProperties) : Void
    {
        _luaState = prop.luaState;
    }
    
    override public function setProps(prop : ParticleProperties) : Void
    {
        if (_luaState != 0 && _varName != null)
        {
            var luaState : Int = prop.luaState;
            Lua.lua_getglobal(luaState, _varName);
            prop[_propName] = Lua.lua_tonumberx(luaState, -1, 0);
        }
        else
        {
            prop[_propName] = 0;
        }
    }
    
    override public function generateOneValue(index : Int = 0, total : Int = 1) : Dynamic
    {
        if (_luaState != 0 && _varName != null)
        {
            Lua.lua_getglobal(_luaState, _varName);
            return Lua.lua_tonumberx(_luaState, -1, 0);
        }
        else
        {
            return 0;
        }
    }
}

