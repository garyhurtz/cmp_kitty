local Logger = require("cmp_kitty.logger")
local Tab = require("cmp_kitty.tab")
local Set = require("cmp_kitty.set")

local OSWindow = {}

OSWindow.new = function(config, data)
	local inst = setmetatable({
		config = config.os_window,
		data = data,
		tabs = Set.new(),
	}, { __index = OSWindow })

	for _, tab_data in ipairs(data.tabs) do
		inst.tabs:add(Tab.new(config, tab_data))
	end

	return inst
end

function OSWindow:__tostring()
	return "OSWindow: " .. self.data.id
end

function OSWindow:match_active_state()
	-- implement logic to match tab state
	-- return true if any state satisfies the current config

	local match_active = self.config.include_active and self.data.is_active
	local match_inactive = self.config.include_inactive and not self.data.is_active

	local result = match_active or match_inactive

	Logger:debug("os_win active", self.data.id .. ": " .. tostring(result))

	return result
end

function OSWindow:match_focus_state()
	-- implement logic to match tab state
	-- return true if any state satisfies the current config

	local match_focused = self.config.include_focused and (self.data.is_focused or self.data.last_focused)
	local match_unfocused = self.config.include_unfocused and not self.data.is_focused

	local result = match_focused or match_unfocused

	Logger:debug("os_win focus", self.data.id .. ": " .. tostring(result))

	return result
end

function OSWindow:match()
	local result = self:match_active_state() or self:match_focus_state()

	Logger:debug("os_win ->", self.data.id .. ": " .. tostring(result))

	return result
end

return OSWindow
