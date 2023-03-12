local Kitty = require("cmp_kitty.kitty")
local defaults = require("cmp_kitty.config")

describe("instantiation", function()
	local dut = Kitty:new(defaults)

	it("should have a is_executable attribute", function()
		assert.is_boolean(dut.is_executable)
	end)

	it("should have a config attribute", function()
		assert.is_table(dut.config)
	end)
end)
