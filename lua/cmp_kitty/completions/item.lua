local Item = {}

Item.new = function(obj, period)
    local inst = {
        label = obj.label,
        obj = obj,
        period = period,
        expiration = os.time() + period,
    }

    setmetatable(inst, Item)

    return inst
end

function Item:__index(key)
    if self ~= Item then
        local field = Item[key]

        if field then
            return field
        end
    end
end

function Item:__tostring()
    if self:expired() then
        return self.label .. " [expired]"
    else
        return self.label .. " [" .. (self.expiration - os.time()) .. "]"
    end
end

function Item.is_item(other)
    return getmetatable(other) == Item
end

function Item:expired()
    return os.time() > self.expiration
end

function Item:reset()
    self.expiration = os.time() + self.period
end

return Item
