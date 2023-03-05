local Set = {}

Set.new = function()
	local inst = {
		items = {},
	}

	setmetatable(inst, Set)

	return inst
end

function Set.is_set(other)
	return getmetatable(other) == Set
end

function Set:__index(key)
	if self ~= Set then
		local field = Set[key]

		if field then
			return field
		end
	end
end

function Set:__tostring()
	local elements = self:join(", ")
	return "set(" .. elements .. ")"
end

function Set:add(item)
	self.items[item] = true
end

function Set:discard(item)
	self.items[item] = nil
end

function Set:contains(item)
	return self.items[item] ~= nil
end

function Set:len()
	local result = 0

	for _, _ in pairs(self.items) do
		result = result + 1
	end

	return result
end

function Set:clear()
	for item, _ in pairs(self.items) do
		self:discard(item)
	end
end

function Set:update(other)
	assert(Set.is_set(other))

	for item, _ in pairs(other.items) do
		self:add(item)
	end
end

function Set:difference(other)
	assert(Set.is_set(other))

	local result = Set.new()

	for item in pairs(self.items) do
		if not other:contains(item) then
			result:add(item)
		end
	end

	return result
end

function Set:join(sep)
	sep = sep or ","
	local result = ""
	for k, _ in pairs(self.items) do
		result = result .. tostring(k) .. sep
	end
	return result
end

function Set:filter(fn)
	local result = Set.new()

	for item in pairs(self.items) do
		if fn(item) then
			result:add(item)
		end
	end

	return result
end

return Set
