local Tab = require("cmp_kitty.tab")

local focused_tab_data = {
	is_active_tab = false,
	is_focused = true,
	title = "title",
	windows = {},
}

local unfocused_tab_data = {
	is_active_tab = false,
	is_focused = false,
	title = "title",
	windows = {},
}

describe("include_focused=true", function()
	local config = {
		os_window = {

			tab = {
				include_active = false,
				include_inactive = false,

				include_focused = true,
				include_unfocused = false,
			},
		},
	}

	it("should match focused tab", function()
		local dut = Tab.new(config, focused_tab_data)
		assert.is_true(dut:match_focus_state())
	end)

	it("should not match unfocused tab", function()
		local dut = Tab.new(config, unfocused_tab_data)
		assert.is_false(dut:match_focus_state())
	end)
end)

describe("include_focused=false", function()
	local config = {
		os_window = {

			tab = {
				include_active = false,
				include_inactive = false,

				include_focused = false,
				include_unfocused = false,
			},
		},
	}

	it("should not match focused tab", function()
		local dut = Tab.new(config, focused_tab_data)
		assert.is_false(dut:match_focus_state())
	end)

	it("should not match unfocused tab", function()
		local dut = Tab.new(config, unfocused_tab_data)
		assert.is_false(dut:match_focus_state())
	end)
end)

describe("include_unfocused=true", function()
	local config = {
		os_window = {

			tab = {
				include_active = false,
				include_inactive = false,

				include_focused = false,
				include_unfocused = true,
			},
		},
	}

	it("should not match focused tab", function()
		local dut = Tab.new(config, focused_tab_data)
		assert.is_false(dut:match_focus_state())
	end)

	it("should match unfocused tab", function()
		local dut = Tab.new(config, unfocused_tab_data)
		assert.is_true(dut:match_focus_state())
	end)
end)
