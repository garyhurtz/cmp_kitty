local Window = require("cmp_kitty.window")

local focused_window_data = {
	is_active_window = false,
	is_focused = true,
	title = "title",
	id = 123,
}

local unfocused_window_data = {
	is_active_window = false,
	is_focused = false,
	title = "title",
	id = 123,
}

describe("include_focused=false include_unfocused=false", function()
	local config = {
		os_window = {
			tab = {
				window = {
					include_active = false,
					include_inactive = false,

					include_focused = false,
					include_unfocused = false,
				},
			},
		},
	}

	it("should not match focused window", function()
		local dut = Window.new(config, focused_window_data)
		assert.is_false(dut:match_focus_state())
	end)

	it("should not match unfocused window", function()
		local dut = Window.new(config, unfocused_window_data)
		assert.is_false(dut:match_focus_state())
	end)
end)

describe("include_focused=true include_unfocused=false", function()
	local config = {
		os_window = {
			tab = {
				window = {
					include_active = false,
					include_inactive = false,

					include_focused = true,
					include_unfocused = false,
				},
			},
		},
	}

	it("should match focused window", function()
		local dut = Window.new(config, focused_window_data)
		assert.is_true(dut:match_focus_state())
	end)

	it("should not match unfocused window", function()
		local dut = Window.new(config, unfocused_window_data)
		assert.is_false(dut:match_focus_state())
	end)
end)

describe("include_focused=false include_unfocused=true", function()
	local config = {
		os_window = {
			tab = {
				window = {
					include_active = false,
					include_inactive = false,

					include_focused = false,
					include_unfocused = true,
				},
			},
		},
	}

	it("should not match focused window", function()
		local dut = Window.new(config, focused_window_data)
		assert.is_false(dut:match_focus_state())
	end)

	it("should match unfocused window", function()
		local dut = Window.new(config, unfocused_window_data)
		assert.is_true(dut:match_focus_state())
	end)
end)

describe("include_unfocused=true include_unfocused=true", function()
	local config = {
		os_window = {
			tab = {
				window = {
					include_active = false,
					include_inactive = false,

					include_focused = true,
					include_unfocused = true,
				},
			},
		},
	}

	it("should match focused window", function()
		local dut = Window.new(config, focused_window_data)
		assert.is_true(dut:match_focus_state())
	end)

	it("should match unfocused window", function()
		local dut = Window.new(config, unfocused_window_data)
		assert.is_true(dut:match_focus_state())
	end)
end)
