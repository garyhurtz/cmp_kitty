local Completions = require("cmp_kitty.completions")

describe("clear", function()
	local dut = Completions.new()
	dut:set_item_lifetime(60)

	dut:add({ label = "a" })
	dut:add({ label = "b" })
	dut:add({ label = "c" })

	it("should initially have 3 items", function()
		assert.equal(3, dut:len())
	end)

	it("should clear all items", function()
		dut:clear()
		assert.equal(0, dut:len())
	end)
end)
