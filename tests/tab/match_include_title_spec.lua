local Tab = require("cmp_kitty.tab")

describe("include_title=string", function()
	local matching_title_data = {
		is_active_tab = false,
		is_focused = false,
		title = "cmp-include",
		windows = {},
	}

	local other_title_data = {
		is_active_tab = false,
		is_focused = false,
		title = "other-title",
		windows = {},
	}

	local config = {
		os_window = {

			tab = {
				include_active = false,
				include_inactive = false,

				include_focused = false,
				include_unfocused = false,

				include_title = "cmp-include",
			},
		},
	}

	it("should match matching title", function()
		local dut = Tab.new(config, matching_title_data)
		assert.is_true(dut:match_include_title())
	end)

	it("should not match not other title", function()
		local dut = Tab.new(config, other_title_data)
		assert.is_false(dut:match_include_title())
	end)
end)

describe("include_title=pattern", function()
	local matching_title_data = {
		is_active_tab = false,
		is_focused = false,
		title = "cmp-include",
		windows = {},
	}

	local other_title_data = {
		is_active_tab = false,
		is_focused = false,
		title = "other-title",
		windows = {},
	}

	local config = {
		os_window = {

			tab = {
				include_active = false,
				include_inactive = false,

				include_focused = false,
				include_unfocused = false,

				include_title = "inc",
			},
		},
	}

	it("should match matching title", function()
		local dut = Tab.new(config, matching_title_data)
		assert.is_true(dut:match_include_title())
	end)

	it("should not match not other title", function()
		local dut = Tab.new(config, other_title_data)
		assert.is_false(dut:match_include_title())
	end)
end)

describe("include_title=nil", function()
	local matching_title_data = {
		is_active_tab = false,
		is_focused = false,
		title = "cmp-include",
		windows = {},
	}

	local other_title_data = {
		is_active_tab = false,
		is_focused = false,
		title = "other-title",
		windows = {},
	}

	local config = {
		os_window = {

			tab = {
				include_active = false,
				include_inactive = false,

				include_focused = false,
				include_unfocused = false,

				include_title = nil,
			},
		},
	}

	it("should not match matching title", function()
		local dut = Tab.new(config, matching_title_data)
		assert.is_false(dut:match_include_title())
	end)

	it("should not match not other title", function()
		local dut = Tab.new(config, other_title_data)
		assert.is_false(dut:match_include_title())
	end)
end)
