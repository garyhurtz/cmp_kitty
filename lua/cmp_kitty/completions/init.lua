local Set = require("cmp_kitty.set")
local Item = require("cmp_kitty.completions.item")

local Completions = {}

Completions.new = function()
	local inst = {
		-- how many second to wait between prunes
		lifetime = nil,
		-- when to do the next prune
		expiration = nil,
		--
		items = {},
	}

	setmetatable(inst, Completions)

	return inst
end

function Completions.is_completions(other)
	return getmetatable(other) == Completions
end

function Completions:__index(key)
	if self ~= Completions then
		local field = Completions[key]

		if field then
			return field
		end
	end
end

function Completions:__tostring()
	local elements = self:join(", ")
	return "{" .. elements .. "}"
end

function Completions:set_item_lifetime(lifetime)
	assert(lifetime ~= nil, "period must be an integer")
	self.lifetime = lifetime
	self.expiration = os.time() + lifetime
end

function Completions:add(value)
	if self:contains(value) then
		self.items[value]:reset()
	else
		self.items[value] = Item.new(value, self.lifetime)
	end
end

function Completions:remove(value)
	self.items[value] = nil
end

function Completions:values()
	local values = Set.new()

	for value, _ in pairs(self.items) do
		values:add(value)
	end

	return values
end

function Completions:contains(value)
	return self.items[value] ~= nil
end

function Completions:len()
	local result = 0

	for _, _ in pairs(self.items) do
		result = result + 1
	end

	return result
end

function Completions:update(other)
	assert(Completions.is_completions(other) or Set.is_set(other))

	for value, _ in pairs(other.items) do
		self:add(value)
	end
end

function Completions:clear()
	for value, _ in pairs(self.items) do
		self:remove(value)
	end
end

function Completions:join(sep)
	sep = sep or ","
	local result = ""
	for value, _ in pairs(self.items) do
		result = result .. value .. sep
	end
	return result
end

function Completions:prune()
	local count = 0

	for value, item in pairs(self.items) do
		if item:expired() then
			count = count + 1
			self:remove(value)
		end
	end

	return count
end

function Completions:check()
	local count = nil

	if os.time() > self.expiration then
		self.expiration = os.time() + self.lifetime
		count = self:prune()
	end

	return count
end

return Completions
