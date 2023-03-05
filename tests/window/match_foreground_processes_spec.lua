local Window = require("cmp_kitty.window")
local config = require("cmp_kitty.config")

describe("include_foreground_processes", function()
	local matching_foreground_processes_data = {
		is_active_window = false,
		is_focused = false,
		foreground_processes = {
			{
				cmdline = { "/the/cmd" },
			},
		},
		id = 123,
	}

	local other_foreground_processes_data = {
		is_active_window = false,
		is_focused = false,
		foreground_processes = {
			{
				cmdline = { "/other/cmd" },
			},
		},
		id = 123,
	}

	-- overrides
	config.os_window.tab.window.include_active = false
	config.os_window.tab.window.include_inactive = false
	config.os_window.tab.window.include_focused = false
	config.os_window.tab.window.include_unfocused = false

	config.os_window.tab.window.include_foreground_process = function(process)
		local match_cmd = function(cmd)
			return cmd == "/the/cmd"
		end

		for _, cmd in ipairs(process.cmdline) do
			if match_cmd(cmd) == true then
				return true
			end
		end
		return false
	end

	it("should not match state", function()
		local dut = Window.new(config, matching_foreground_processes_data)
		assert.is_false(dut:match_active_state())
		assert.is_false(dut:match_focus_state())
	end)

	it("should match matching foreground_processes", function()
		local dut = Window.new(config, matching_foreground_processes_data)
		assert.is_true(dut:match_foreground_processes(config.os_window.tab.window.include_foreground_process))
	end)

	it("should not match not other foreground_processes", function()
		local dut = Window.new(config, other_foreground_processes_data)
		assert.is_false(dut:match_foreground_processes(config.os_window.tab.window.include_foreground_process))
	end)
end)

describe("exclude_foreground_processes", function()
	local matching_foreground_processes_data = {
		is_active_window = false,
		is_focused = false,
		foreground_processes = {
			{
				cmdline = { "/the/cmd" },
			},
		},
		id = 123,
	}

	local other_foreground_processes_data = {
		is_active_window = false,
		is_focused = false,
		foreground_processes = {
			{
				cmdline = { "/other/cmd" },
			},
		},
		id = 123,
	}

	-- overrides
	config.os_window.tab.window.include_active = false
	config.os_window.tab.window.include_inactive = false
	config.os_window.tab.window.include_focused = false
	config.os_window.tab.window.include_unfocused = false

	config.os_window.tab.window.exclude_foreground_process = function(process)
		local match_cmd = function(cmd)
			return cmd == "/the/cmd"
		end

		for _, cmd in ipairs(process.cmdline) do
			if match_cmd(cmd) == true then
				return true
			end
		end
		return false
	end

	it("should not match state", function()
		local dut = Window.new(config, matching_foreground_processes_data)
		assert.is_false(dut:match_active_state())
		assert.is_false(dut:match_focus_state())
	end)

	it("should match matching foreground_processes", function()
		local dut = Window.new(config, matching_foreground_processes_data)
		assert.is_true(dut:match_foreground_processes(config.os_window.tab.window.exclude_foreground_process))
	end)

	it("should not match not other foreground_processes", function()
		local dut = Window.new(config, other_foreground_processes_data)
		assert.is_false(dut:match_foreground_processes(config.os_window.tab.window.exclude_foreground_process))
	end)
end)
