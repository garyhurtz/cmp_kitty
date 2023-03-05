local Tab = require("cmp_kitty.tab")
local Set = require("cmp_kitty.set")

describe("constructor", function()
	local config = {
		os_window = {
			tab = {},
		},
	}

	local data = {
		windows = {},
	}

	local dut = Tab.new(config, data)

	it("should have a config attribute", function()
		assert.is_table(dut.config)
	end)

	it("should have a data attribute", function()
		assert.is_table(dut.data)
	end)

	it("should have a windows attribute", function()
		assert.is_truthy(Set.is_set(dut.windows))
	end)
end)
