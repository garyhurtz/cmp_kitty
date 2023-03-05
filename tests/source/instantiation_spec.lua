local Source = require("cmp_kitty.source")

describe("instantiation", function()
	local dut = Source:new()

	it("should have a config attribute", function()
		assert.is_table(dut.config)
	end)

	it("should have a kitty attribute", function()
		assert.is_table(dut.kitty)
	end)
end)
