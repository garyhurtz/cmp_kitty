local Completions = require("cmp_kitty.completions")
local Logger = require("cmp_kitty.logger")
local OSWindow = require("cmp_kitty.os_window")
local Set = require("cmp_kitty.set")
local Match = require("cmp_kitty.match")

local Kitty = {
	-- cache of completion items
	items = Completions.new(),
}

function Kitty:new(config)
	--
	local inst = setmetatable({
		config = config,
		-- env
		is_executable = vim.fn.executable("kitty") == 1,
	}, { __index = Kitty })

	-- configure the common logger
	Logger:set_level(config.log_level)

	self.items:set_item_lifetime(config.completion_item_lifetime)

	-- flag for update timeout
	inst.update_hold = false

	return inst
end

-- cmp interface

function Kitty:is_available()
	if self.is_kitty_terminal == false then
		Logger:warning("[cmp_kitty] Kitty is not executable")
		return false
	end

	if os.getenv("KITTY_WINDOW_ID") == nil then
		Logger:warning("[cmp_kitty] not a Kitty window.")
		return false
	end

	if os.getenv("KITTY_LISTEN_ON") == nil then
		Logger:warning("[cmp_kitty] Kitty listen_on is nil.")
		return false
	end

	return true
end

function Kitty:get_completion_items(input)
	-- filter the completion candidates
	local result = self.items:filter(input)
	Logger:debug("get_completion_items: returning ", result:len())

	-- if we are not on update hold, start an update now
	if self.update_hold == false then
		self:update()
	end

	-- return the completions
	return result
end

-- kitty interface

function Kitty:build_kitty_command(command, args)
	local cmd = {
		"kitty",
		"@",
	}

	local kitty_listen_on = os.getenv("KITTY_LISTEN_ON")

	if kitty_listen_on ~= nil then
		table.insert(cmd, "--to")
		table.insert(cmd, kitty_listen_on)
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
		Logger:error("[cmp_kitty] Kitty communication error")
		return nil
	end

	local resp = handle:read("*all")

	handle:close()

	-- return nil on empty response
	if resp == "" then
		resp = nil
		Logger:error("[cmp_kitty] Kitty communication error - is listen_on correct?")
	end

	return resp
end

function Kitty:update()
	Logger:debug("starting update: ", os.time())

	-- hold other updates
	self.update_hold = true

	-- call kitty ls and get the result
	local command = self:build_kitty_command("ls")

	-- on empty response return empty table
	local resp = self:execute_kitty_command(command) or "{}"

	local ls_data = vim.json.decode(resp)

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
								self.config.window_polling_period * (counter + 1),
								0,
								function()
									self:get_text(window.id)
								end
							)

							counter = counter + 1
						end
					end
				end
			end
		end
	end

	local timer = vim.loop.new_timer()

	timer:start(
		1000 * self.config.min_update_restart_period,
		0,
		vim.schedule_wrap(function()
			self.update_hold = false
		end)
	)

	-- now check for items to prune
	local count = self.items:check()

	if count then
		Logger:debug("pruning: ", count)
	end
end

function Kitty:get_text(wid)
	local cmd = self:build_kitty_command("get-text", {
		"--match",
		"id:" .. wid,
		"--extent",
		self.config.extent,
	})

	local resp = self:execute_kitty_command(cmd)

	if resp == nil then
		return
	end

	local results = Set.new()

	-- split each line and add it to temp
	-- this eliminates duplicate entries
	for word in resp:gmatch("%S+") do
		results:add(word)
	end

	local matcher = Match.new(self.config)

	local filter = function(text)
		return matcher:match(text)
	end

	local filtered = results:filter(filter)

	-- filter the remaining items and return
	self.items:update(filtered)
end

return Kitty
