local Tab = require("cmp_kitty.tab")

local active_tab_data = {
	is_active_tab = true,
	is_focused = false,
	title = "title",
	windows = {},
}

local inactive_tab_data = {
	is_active_tab = false,
	is_focused = false,
	title = "title",
	windows = {},
}

describe("include_active=true", function()
	local config = {
		os_window = {

			include_active = true,
			include_inactive = false,

			include_focused = false,
			include_unfocused = false,

			tab = {
				include_active = true,
				include_inactive = false,

				include_focused = false,
				include_unfocused = false,
			},
		},
	}

	it("should match active tab", function()
		local dut = Tab.new(config, active_tab_data)
		assert.is_true(dut:match_active_state())
	end)

	it("should not match inactive tab", function()
		local dut = Tab.new(config, inactive_tab_data)
		assert.is_false(dut:match_active_state())
	end)
end)

describe("include_active=false", function()
	local config = {
		os_window = {

			include_active = true,
			include_inactive = false,

			include_focused = false,
			include_unfocused = false,

			tab = {

				include_active = false,
				include_inactive = false,

				include_focused = false,
				include_unfocused = false,
			},
		},
	}

	it("should not match active tab", function()
		local dut = Tab.new(config, active_tab_data)
		assert.is_false(dut:match_active_state())
	end)

	it("should not match inactive tab", function()
		local dut = Tab.new(config, inactive_tab_data)
		assert.is_false(dut:match_active_state())
	end)
end)

describe("include_inactive=true", function()
	local config = {
		os_window = {
			include_active = true,
			include_inactive = false,

			include_focused = false,
			include_unfocused = false,

			tab = {

				include_active = false,
				include_inactive = true,

				include_focused = false,
				include_unfocused = false,
			},
		},
	}

	it("should not match active tab", function()
		local dut = Tab.new(config, active_tab_data)
		assert.is_false(dut:match_active_state())
	end)

	it("should match inactive tab", function()
		local dut = Tab.new(config, inactive_tab_data)
		assert.is_true(dut:match_active_state())
	end)
end)
