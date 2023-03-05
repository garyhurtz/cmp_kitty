local Window = require("cmp_kitty.window")
local config = require("cmp_kitty.config")

describe("include_cwd", function()
	local matching_cwd_data = {
		is_active_window = false,
		is_focused = false,
		cwd = "/the/path",
		id = 123,
	}

	local other_cwd_data = {
		is_active_window = false,
		is_focused = false,
		cwd = "/other/path",
		id = 123,
	}

	-- overrides
	config.os_window.tab.window.include_active = false
	config.os_window.tab.window.include_inactive = false
	config.os_window.tab.window.include_focused = false
	config.os_window.tab.window.include_unfocused = false

	config.os_window.tab.window.include_cwd = function(path)
		return path == "/the/path"
	end

	it("should not match state", function()
		local dut = Window.new(config, matching_cwd_data)
		assert.is_false(dut:match_active_state())
		assert.is_false(dut:match_focus_state())
	end)

	it("should match matching cwd", function()
		local dut = Window.new(config, matching_cwd_data)
		assert.is_true(dut:match_cwd(config.os_window.tab.window.include_cwd))
	end)

	it("should not match not other cwd", function()
		local dut = Window.new(config, other_cwd_data)
		assert.is_false(dut:match_cwd(config.os_window.tab.window.include_cwd))
	end)
end)

describe("exclude_cwd", function()
	local matching_cwd_data = {
		is_active_window = false,
		is_focused = false,
		cwd = "/the/path",
		id = 123,
	}

	local other_cwd_data = {
		is_active_window = false,
		is_focused = false,
		cwd = "/other/path",
		id = 123,
	}

	-- overrides
	config.os_window.tab.window.include_active = false
	config.os_window.tab.window.include_inactive = false
	config.os_window.tab.window.include_focused = false
	config.os_window.tab.window.include_unfocused = false

	config.os_window.tab.window.exclude_cwd = function(path)
		return path == "/the/path"
	end

	it("should not match state", function()
		local dut = Window.new(config, matching_cwd_data)
		assert.is_false(dut:match_active_state())
		assert.is_false(dut:match_focus_state())
	end)

	it("should match matching cwd", function()
		local dut = Window.new(config, matching_cwd_data)
		assert.is_true(dut:match_cwd(config.os_window.tab.window.exclude_cwd))
	end)

	it("should not match not other cwd", function()
		local dut = Window.new(config, other_cwd_data)
		assert.is_false(dut:match_cwd(config.os_window.tab.window.exclude_cwd))
	end)
end)
