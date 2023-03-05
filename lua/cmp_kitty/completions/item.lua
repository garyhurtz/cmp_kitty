local Item = {}

Item.new = function(value, period)
	local inst = {
		value = value,
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
		return self.value .. " [expired]"
	else
		return self.value .. " [" .. (self.expiration - os.time()) .. "]"
	end
end

function Item:expired()
	return os.time() > self.expiration
end

function Item:reset()
	self.expiration = os.time() + self.period
end

return Item
