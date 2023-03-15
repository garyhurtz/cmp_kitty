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

function Completions:add(obj)
	if self:contains(obj.label) then
		self.items[obj.label]:reset()
	else
		self.items[obj.label] = Item.new(obj, self.lifetime)
	end
end

function Completions:all()
	local result = {}

	for _, item in pairs(self.items) do
		table.insert(result, item.obj)
	end

	return result
end

function Completions:filter(input)
	local result = {}

	for label, item in pairs(self.items) do
		if label:find(input) then
			table.insert(result, item.obj)
		end
	end

	return result
end

function Completions:remove(label)
	self.items[label] = nil
end

function Completions:contains(label)
	return self.items[label] ~= nil
end

function Completions:len()
	local result = 0

	for _, _ in pairs(self.items) do
		result = result + 1
	end

	return result
end

function Completions:update(other)
	assert(Completions.is_completions(other))

	for _, item in pairs(other.items) do
		self:add(item)
	end
end

function Completions:clear()
	for label, _ in pairs(self.items) do
		self:remove(label)
	end
end

function Completions:join(sep)
	sep = sep or ","
	local result = ""
	for label, _ in pairs(self.items) do
		result = result .. label .. sep
	end
	return result
end

function Completions:prune()
	local count = 0

	for label, item in pairs(self.items) do
		if item:expired() then
			count = count + 1
			self:remove(label)
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
