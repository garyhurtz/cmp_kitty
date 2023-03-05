local Window = require("cmp_kitty.window")
local config = require("cmp_kitty.config")

describe("include_title", function()
	local matching_title_data = {
		is_active_window = false,
		is_focused = false,
		title = "cmp-include",
		id = 123,
	}

	local other_title_data = {
		is_active_window = false,
		is_focused = false,
		title = "other-title",
		id = 123,
	}

	-- overrides
	config.os_window.tab.window.include_active = false
	config.os_window.tab.window.include_inactive = false
	config.os_window.tab.window.include_focused = false
	config.os_window.tab.window.include_unfocused = false

	it("should not match state", function()
		local dut = Window.new(config, matching_title_data)
		assert.is_false(dut:match_active_state())
		assert.is_false(dut:match_focus_state())
	end)

	it("should match matching title", function()
		local dut = Window.new(config, matching_title_data)
		assert.is_true(dut:match_title(config.os_window.tab.window.include_title))
	end)

	it("should not match not other title", function()
		local dut = Window.new(config, other_title_data)
		assert.is_false(dut:match_title(config.os_window.tab.window.include_title))
	end)
end)

describe("exclude_title", function()
	local matching_title_data = {
		is_active_window = false,
		is_focused = false,
		title = "cmp-exclude",
		id = 123,
	}

	local other_title_data = {
		is_active_window = false,
		is_focused = false,
		title = "other-title",
		id = 123,
	}

	-- overrides
	config.os_window.tab.window.include_active = false
	config.os_window.tab.window.include_inactive = false
	config.os_window.tab.window.include_focused = false
	config.os_window.tab.window.include_unfocused = false

	it("should not match state", function()
		local dut = Window.new(config, matching_title_data)
		assert.is_false(dut:match_active_state())
		assert.is_false(dut:match_focus_state())
	end)

	it("should match matching title", function()
		local dut = Window.new(config, matching_title_data)
		assert.is_true(dut:match_title(config.os_window.tab.window.exclude_title))
	end)

	it("should not match not other title", function()
		local dut = Window.new(config, other_title_data)
		assert.is_false(dut:match_title(config.os_window.tab.window.exclude_title))
	end)
end)
