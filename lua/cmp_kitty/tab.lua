local Logger = require("cmp_kitty.logger")
local Set = require("cmp_kitty.set")
local Window = require("cmp_kitty.window")

local Tab = {}

Tab.new = function(config, data)
    local inst = setmetatable({

        config = config.os_window.tab,
        data = data,
        windows = Set.new(),
    }, { __index = Tab })

    for _, window_data in ipairs(data.windows) do
        inst.windows:add(Window.new(config, window_data))
    end

    return inst
end

function Tab:__tostring()
    return "Tab: " .. self.data.id .. ": " .. self.data.title
end

function Tab:match_active_state()
    -- implement logic to match tab state
    -- return true if any state satisfies the current config

    local match_active = self.config.include_active and self.data.is_active_tab
    local match_inactive = self.config.include_inactive and not self.data.is_active_tab

    local result = match_active or match_inactive

    Logger:debug("tab active", self.data.title .. ": " .. tostring(result))

    return result
end

function Tab:match_focus_state()
    -- implement logic to match tab state
    -- return true if any state satisfies the current config

    local match_focused = self.config.include_focused and self.data.is_focused
    local match_unfocused = self.config.include_unfocused and not self.data.is_focused

    local result = match_focused or match_unfocused

    Logger:debug("tab focus", self.data.title .. ": " .. tostring(result))

    return result
end

function Tab:match_include_title()
    local result = (type(self.config.include_title) == "string")
        -- first check for an exact match so that pattern-like strings match as expected
        and ((self.data.title == self.config.include_title) or (self.data.title:find(self.config.include_title) ~= nil))

    Logger:debug("tab include title", self.data.title .. ": " .. tostring(result))

    return result
end

function Tab:match_exclude_title()
    local result = (type(self.config.exclude_title) == "string")
        -- first check for an exact match so that pattern-like strings match as expected
        and ((self.data.title == self.config.exclude_title) or (self.data.title:find(self.config.exclude_title) ~= nil))

    Logger:debug("tab exclude title", self.data.title .. ": " .. tostring(result))

    return result
end

function Tab:match()
    local result = (
        (self:match_active_state() or self:match_focus_state() or self:match_include_title())
        and not self:match_exclude_title()
    )

    Logger:debug("tab ->", self.data.title .. ": " .. tostring(result) .. "\n")

    return result
end

return Tab
