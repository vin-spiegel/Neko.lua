local callbacks = {
    Add = function(self, _func)
        assert(type(_func) == "function")
        self[self.type].list[tostring(_func)] = _func
    end,
    Remove = function(self, _func)
        assert(type(_func) == "function")
        assert(self[self.type].list[tostring(_func)])
        self[self.type].list[tostring(_func)] = nil
    end,
    execute = function(self, ...)
        local list = self[self.type].list
        for _, callback in pairs(list) do
            if type(callback) == "function" then
                callback(...)
            end
        end
    end
}
callbacks.__index = callbacks

return callbacks
