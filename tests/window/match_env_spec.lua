local Window = require("cmp_kitty.window")
local config = require("cmp_kitty.config")

describe("include_env", function()
	local matching_env_data = {
		is_active_window = false,
		is_focused = false,
		env = {
			CMP_INCLUDE = "1",
		},
		id = 123,
	}

	local other_env_data = {
		is_active_window = false,
		is_focused = false,
		env = {
			OTHER = "1",
		},
		id = 123,
	}

	-- overrides
	config.os_window.tab.window.include_active = false
	config.os_window.tab.window.include_inactive = false
	config.os_window.tab.window.include_focused = false
	config.os_window.tab.window.include_unfocused = false

	it("should not match state", function()
		local dut = Window.new(config, matching_env_data)
		assert.is_false(dut:match_active_state())
		assert.is_false(dut:match_focus_state())
	end)

	it("should match matching env", function()
		local dut = Window.new(config, matching_env_data)
		assert.is_true(dut:match_env(config.os_window.tab.window.include_env))
	end)

	it("should not match not other env", function()
		local dut = Window.new(config, other_env_data)
		assert.is_false(dut:match_env(config.os_window.tab.window.include_env))
	end)
end)

describe("exclude_env", function()
	local matching_env_data = {
		is_active_window = false,
		is_focused = false,
		env = {
			CMP_EXCLUDE = "1",
		},
		id = 123,
	}

	local other_env_data = {
		is_active_window = false,
		is_focused = false,
		env = {
			OTHER = "1",
		},
		id = 123,
	}

	-- overrides
	config.os_window.tab.window.include_active = false
	config.os_window.tab.window.include_inactive = false
	config.os_window.tab.window.include_focused = false
	config.os_window.tab.window.include_unfocused = false

	it("should not match state", function()
		local dut = Window.new(config, matching_env_data)
		assert.is_false(dut:match_active_state())
		assert.is_false(dut:match_focus_state())
	end)

	it("should match matching env", function()
		local dut = Window.new(config, matching_env_data)
		assert.is_true(dut:match_env(config.os_window.tab.window.exclude_env))
	end)

	it("should not match not other env", function()
		local dut = Window.new(config, other_env_data)
		assert.is_false(dut:match_env(config.os_window.tab.window.exclude_env))
	end)
end)
