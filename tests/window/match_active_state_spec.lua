local Window = require("cmp_kitty.window")

local active_window_data = {
	is_active_window = true,
	is_focused = false,
	title = "title",
	id = 123,
}

local inactive_window_data = {
	is_active_window = false,
	is_focused = false,
	title = "title",
	id = 123,
}

describe("include_active=false include_inactive=false", function()
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

	it("should not match active window", function()
		local dut = Window.new(config, active_window_data)
		assert.is_false(dut:match_active_state())
	end)

	it("should not match inactive window", function()
		local dut = Window.new(config, inactive_window_data)
		assert.is_false(dut:match_active_state())
	end)
end)

describe("include_active=true include_inactive=false", function()
	local config = {
		os_window = {

			tab = {
				window = {
					include_active = true,
					include_inactive = false,

					include_focused = false,
					include_unfocused = false,
				},
			},
		},
	}

	it("should match active window", function()
		local dut = Window.new(config, active_window_data)
		assert.is_true(dut:match_active_state())
	end)

	it("should not match inactive window", function()
		local dut = Window.new(config, inactive_window_data)
		assert.is_false(dut:match_active_state())
	end)
end)

describe("include_active=false include_inactive=true", function()
	local config = {
		os_window = {

			tab = {
				window = {

					include_active = false,
					include_inactive = true,

					include_focused = false,
					include_unfocused = false,
				},
			},
		},
	}

	it("should not match active window", function()
		local dut = Window.new(config, active_window_data)
		assert.is_false(dut:match_active_state())
	end)

	it("should match inactive window", function()
		local dut = Window.new(config, inactive_window_data)
		assert.is_true(dut:match_active_state())
	end)
end)

describe("include_active=true include_inactive=true", function()
	local config = {
		os_window = {

			tab = {
				window = {
					include_active = true,
					include_inactive = true,

					include_focused = false,
					include_unfocused = false,
				},
			},
		},
	}

	it("should match active window", function()
		local dut = Window.new(config, active_window_data)
		assert.is_true(dut:match_active_state())
	end)

	it("should not match inactive window", function()
		local dut = Window.new(config, inactive_window_data)
		assert.is_true(dut:match_active_state())
	end)
end)
