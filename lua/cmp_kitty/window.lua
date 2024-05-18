local Logger = require("cmp_kitty.logger")

local Window = {}

Window.new = function(config, data)
    --
    local inst = setmetatable({
        config = config.os_window.tab.window,
        data = data,
        id = data.id,
    }, { __index = Window })

    return inst
end

function Window:__tostring()
    return "Window: " .. self.id .. ": " .. self.data.title
end

function Window:match_active_state()
    local match_active = self.config.include_active and self.data.is_active_window
    local match_inactive = self.config.include_inactive and not self.data.is_active_window

    local result = match_active or match_inactive

    Logger:debug("    window active", self.id .. ": " .. tostring(result))

    return result
end

function Window:match_focus_state()
    local match_focused = self.config.include_focused and self.data.is_focused
    local match_unfocused = self.config.include_unfocused and not self.data.is_focused

    local result = match_focused or match_unfocused

    Logger:debug("    window focus", self.id .. ": " .. tostring(result))

    return result
end

function Window:match_title(config_func)
    local result = config_func(self.data.title)
    Logger:debug("    window match title", self.id .. ": " .. tostring(result))
    return result
end

function Window:match_cwd(config_func)
    local result = config_func(self.data.cwd)
    Logger:debug("    window match cwd", self.id .. ": " .. tostring(result))
    return result
end

function Window:match_env(config_func)
    local result = config_func(self.data.env)
    Logger:debug("    window match env", self.id .. ": " .. tostring(result))
    return result
end

function Window:match_foreground_processes(config_func)
    -- step through each process
    for _, process in ipairs(self.data.foreground_processes) do
        if config_func(process) == true then
            return true
        end
    end
    return false
end

function Window:match()
    local result = (
        self:match_active_state()
        or self:match_focus_state()
        or self:match_title(self.config.include_title)
        or self:match_cwd(self.config.include_cwd)
        or self:match_env(self.config.include_env)
        or self:match_foreground_processes(self.config.include_foreground_process)
    )
        and not (
            self:match_cwd(self.config.exclude_cwd)
            or self:match_title(self.config.exclude_title)
            or self:match_env(self.config.exclude_env)
            or self:match_foreground_processes(self.config.exclude_foreground_process)
        )

    Logger:debug("    window ->", self.id .. ": " .. tostring(result) .. "\n")

    return result
end

return Window
