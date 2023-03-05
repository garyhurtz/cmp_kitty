local OSWindow = require("cmp_kitty.os_window")

local active_os_window_data = {
	id = 1,

	is_active = true,
	is_focused = false,
	last_focused = false,

	tabs = {},
}

local inactive_os_window_data = {
	id = 1,

	is_active = false,
	is_focused = false,
	last_focused = false,

	tabs = {},
}

describe("include_active=true", function()
	local config = {
		os_window = {

			include_active = true,
			include_inactive = false,

			include_focused = false,
			include_unfocused = false,
		},
	}

	it("should match active window", function()
		local dut = OSWindow.new(config, active_os_window_data)
		assert.is_true(dut:match_active_state())
	end)

	it("should not match inactive window", function()
		local dut = OSWindow.new(config, inactive_os_window_data)
		assert.is_false(dut:match_active_state())
	end)
end)

describe("include_active=false", function()
	local config = {
		os_window = {

			include_active = false,
			include_inactive = false,

			include_focused = false,
			include_unfocused = false,
		},
	}

	it("should not match active window", function()
		local dut = OSWindow.new(config, active_os_window_data)
		assert.is_false(dut:match_active_state())
	end)

	it("should not match inactive window", function()
		local dut = OSWindow.new(config, inactive_os_window_data)
		assert.is_false(dut:match_active_state())
	end)
end)

describe("include_inactive=true", function()
	local config = {
		os_window = {

			include_active = false,
			include_inactive = true,

			include_focused = false,
			include_unfocused = false,
		},
	}

	it("should not match active window", function()
		local dut = OSWindow.new(config, active_os_window_data)
		assert.is_false(dut:match_active_state())
	end)

	it("should match inactive window", function()
		local dut = OSWindow.new(config, inactive_os_window_data)
		assert.is_true(dut:match_active_state())
	end)
end)
