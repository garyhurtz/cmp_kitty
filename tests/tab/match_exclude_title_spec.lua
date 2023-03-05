local Tab = require("cmp_kitty.tab")

describe("exclude_title=string", function()
	local matching_title_data = {
		is_active_tab = false,
		is_focused = false,
		title = "cmp-exclude",
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
				exclude_active = false,
				exclude_inactive = false,

				exclude_focused = false,
				exclude_unfocused = false,

				exclude_title = "cmp-exclude",
			},
		},
	}

	it("should match matching title", function()
		local dut = Tab.new(config, matching_title_data)
		assert.is_true(dut:match_exclude_title())
	end)

	it("should not match not other title", function()
		local dut = Tab.new(config, other_title_data)
		assert.is_false(dut:match_exclude_title())
	end)
end)

describe("exclude_title=pattern", function()
	local matching_title_data = {
		is_active_tab = false,
		is_focused = false,
		title = "cmp-exclude",
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
				exclude_active = false,
				exclude_inactive = false,

				exclude_focused = false,
				exclude_unfocused = false,

				exclude_title = "exc",
			},
		},
	}

	it("should match matching title", function()
		local dut = Tab.new(config, matching_title_data)
		assert.is_true(dut:match_exclude_title())
	end)

	it("should not match not other title", function()
		local dut = Tab.new(config, other_title_data)
		assert.is_false(dut:match_exclude_title())
	end)
end)

describe("exclude_title=nil", function()
	local matching_title_data = {
		is_active_tab = false,
		is_focused = false,
		title = "cmp-exclude",
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
				exclude_active = false,
				exclude_inactive = false,

				exclude_focused = false,
				exclude_unfocused = false,

				exclude_title = nil,
			},
		},
	}

	it("should not match matching title", function()
		local dut = Tab.new(config, matching_title_data)
		assert.is_false(dut:match_exclude_title())
	end)

	it("should not match not other title", function()
		local dut = Tab.new(config, other_title_data)
		assert.is_false(dut:match_exclude_title())
	end)
end)
