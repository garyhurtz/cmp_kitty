local OSWindow = require("cmp_kitty.os_window")

local focused_os_window_data = {
	id = 1,

	is_active = false,
	is_focused = true,
	last_focused = false,

	tabs = {},
}

local last_focused_os_window_data = {
	id = 1,

	is_active = false,
	is_focused = false,
	last_focused = true,

	tabs = {},
}

local unfocused_os_window_data = {
	id = 1,

	is_active = false,
	is_focused = false,
	last_focused = false,

	tabs = {},
}

describe("include_focused=true", function()
	local config = {
		os_window = {

			include_active = false,
			include_inactive = false,

			include_focused = true,
			include_unfocused = false,
		},
	}

	it("should match focused window", function()
		local dut = OSWindow.new(config, focused_os_window_data)
		assert.is_true(dut:match_focus_state())
	end)

	it("should match last_focused window", function()
		local dut = OSWindow.new(config, last_focused_os_window_data)
		assert.is_true(dut:match_focus_state())
	end)

	it("should not match unfocused window", function()
		local dut = OSWindow.new(config, unfocused_os_window_data)
		assert.is_false(dut:match_focus_state())
	end)
end)

describe("include_focused=false", function()
	local config = {
		os_window = {

			include_active = false,
			include_inactive = false,

			include_focused = false,
			include_unfocused = false,
		},
	}

	it("should not match focused window", function()
		local dut = OSWindow.new(config, focused_os_window_data)
		assert.is_false(dut:match_focus_state())
	end)

	it("should not match last_focused window", function()
		local dut = OSWindow.new(config, last_focused_os_window_data)
		assert.is_false(dut:match_focus_state())
	end)

	it("should not match unfocused window", function()
		local dut = OSWindow.new(config, unfocused_os_window_data)
		assert.is_false(dut:match_focus_state())
	end)
end)

describe("include_unfocused=true", function()
	local config = {
		os_window = {

			include_active = false,
			include_inactive = false,

			include_focused = false,
			include_unfocused = true,
		},
	}

	it("should not match focused window", function()
		local dut = OSWindow.new(config, focused_os_window_data)
		assert.is_false(dut:match_focus_state())
	end)

	it("should match last_focused window", function()
		local dut = OSWindow.new(config, last_focused_os_window_data)
		assert.is_true(dut:match_focus_state())
	end)

	it("should match unfocused window", function()
		local dut = OSWindow.new(config, unfocused_os_window_data)
		assert.is_true(dut:match_focus_state())
	end)
end)
