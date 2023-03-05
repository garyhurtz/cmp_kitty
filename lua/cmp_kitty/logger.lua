local Logger = {}

function Logger.new()
	local inst = setmetatable({
		level = {
			debug = 0,
			info = 1,
			warning = 2,
			error = 3,
			off = 99,
		},
		enabled = false,
		current_level = nil,
	}, { __index = Logger })

	return inst
end

function Logger:set_level(level)
	-- logger is enabled if set to a valid level

	if level == nil or self.level[level] == nil then
		print("logger: ignoring invalid level " .. tostring(level))
		return
	else
		self.enabled = true

		self.current_level = self.level[level]
	end
end

function Logger:log(prefix, msg, level)
	if not self.enabled then
		return
	end

	level = level or self.level.debug

	if level >= self.current_level then
		print(prefix .. ": " .. tostring(msg))
	end
end

function Logger:debug(prefix, msg)
	if msg == nil then
		msg = prefix
		prefix = "debug"
	end
	self:log(prefix, msg, self.level.debug)
end

function Logger:info(prefix, msg)
	if msg == nil then
		msg = prefix
		prefix = "info"
	end

	self:log(prefix, msg, self.level.info)
end

function Logger:warning(prefix, msg)
	if msg == nil then
		msg = prefix
		prefix = "warning"
	end

	self:log(prefix, msg, self.level.warning)
end

function Logger:error(prefix, msg)
	if msg == nil then
		msg = prefix
		prefix = "error"
	end

	self:log(prefix, msg, self.level.error)
end

return Logger.new()
