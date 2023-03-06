local Completions = require("cmp_kitty.completions")
local Logger = require("cmp_kitty.logger")
local OSWindow = require("cmp_kitty.os_window")
local Set = require("cmp_kitty.set")
local math = require("math")
local Match = require("cmp_kitty.match")

local Kitty = {
	-- cache of completion items
	items = Completions.new(),
}

function Kitty:new(config)
	--
	local inst = setmetatable({
		-- receive config from source
		config = config,
		-- environment
		can_execute = vim.fn.executable("kitty") == 1,
		is_kitty_terminal = os.getenv("KITTY_WINDOW_ID") ~= nil,
	}, { __index = Kitty })

	-- configure the common logger
	Logger:set_level(config.log_level)

	self.items:set_item_lifetime(config.completion_item_lifetime)

	-- start the update loop
	inst:update()

	return inst
end

-- cmp interface

-- the plugin is available if:
-- 1) kitty executable is present
-- 2) this is a kitty terminal
-- 3) we know how to contact kitty
function Kitty:is_available()
	return self.can_execute and self.is_kitty_terminal and self.config.listen_on
end

function Kitty:get_completion_items(input)
	local result = self.items:filter(input)
	Logger:debug("get_completion_items: returning ", result:len())
	return result
end

-- kitty interface

function Kitty:build_kitty_command(command, args)
	local cmd = {
		"kitty",
		"@",
	}

	if self.config.listen_on ~= nil then
		table.insert(cmd, "--to")
		table.insert(cmd, self.config.listen_on)
	end

	table.insert(cmd, command)

	if type(args) == "table" then
		for _, chunk in ipairs(args) do
			table.insert(cmd, chunk)
		end
	end

	return table.concat(cmd, " ")
end

function Kitty:execute_kitty_command(cmd)
	local handle = io.popen(cmd)

	if handle == nil then
		return ""
	end

	local resp = handle:read("*all")

	handle:close()

	return resp
end

-- loop over target windows, then call
-- for each window to parse
function Kitty:update()
	Logger:debug("starting update: ", os.time())

	-- call kitty ls and get the result
	local command = self:build_kitty_command("ls")
	local resp = self:execute_kitty_command(command)
	local ls_data = vim.json.decode(resp or "{}")

	-- keep track of how many windows are currently matched
	-- each window to parse will be scheduled so that one window is parsed per second
	local counter = 0

	-- for each os-window in the result
	for _, os_win_data in ipairs(ls_data) do
		-- instantiate the os-window and its children
		local os_win = OSWindow.new(self.config, os_win_data)

		if os_win:match() then
			for tab, _ in pairs(os_win.tabs.items) do
				if tab:match() then
					for window, _ in pairs(tab.windows.items) do
						if window:match() then
							local timer = vim.loop.new_timer()

							-- update one window per polling period
							timer:start(
								-- schedule this window to be parsed
								1000 * self.config.window_polling_period * (counter + 1),
								0,
								vim.schedule_wrap(function()
									self:get_text(window.id, function(values)
										self.items:update(values)
									end, function() end)
								end)
							)

							counter = counter + 1
						end
					end
				end
			end
		end
	end

	-- schedule an update cycle to start again 1 base period after all windows have been updated
	-- but not less than config.completion_min_polling_period

	local schedule_update = 1000
		* self.config.window_polling_period
		* math.max(self.config.min_update_restart_period, counter + 1)

	local timer = vim.loop.new_timer()

	-- schedule the next update cycle
	timer:start(
		schedule_update,
		0,
		vim.schedule_wrap(function()
			self:update()
		end)
	)

	-- now check for items to prune
	local count = self.items:check()

	if count then
		Logger:debug("pruning: ", count)
	end
end

function Kitty:get_text(wid, on_data, on_exit)
	local cmd = self:build_kitty_command("get-text", {
		"--match",
		"id:" .. wid,
		"--extent",
		self.config.extent,
	})

	return vim.fn.jobstart(cmd, {
		on_exit = on_exit,
		on_stderr = nil,
		on_stdout = function(_, data)
			local results = Set.new()

			-- split each line and add it to temp
			-- this eliminates duplicate entries
			for _, line in ipairs(data) do
				for word in line:gmatch("%S+") do
					results:add(word)
				end
			end

			local matcher = Match.new(self.config)

			local filter = function(text)
				return matcher:match(text)
			end

			-- filter the remaining items and return
			on_data(results:filter(filter))
		end,
	})
end

return Kitty
