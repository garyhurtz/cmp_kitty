local OSWindow = require("cmp_kitty.os_window")
local Set = require("cmp_kitty.set")

describe("constructor", function()
	-- config skeleton
	local config = {
		os_window = {},
	}

	-- data skeleton
	local data = {
		tabs = {},
	}

	local dut = OSWindow.new(config, data)

	it("should have a config attribute", function()
		assert.is_table(dut.config)
	end)

	it("should have a data attribute", function()
		assert.is_table(dut.data)
	end)

	it("should have a tabs attribute", function()
		assert.is_truthy(Set.is_set(dut.tabs))
	end)
end)
