local Completions = require("cmp_kitty.completions")

describe("clear", function()
	local dut = Completions.new()
	dut:set_item_lifetime(60)

	dut:add("a")
	dut:add("b")
	dut:add("c")

	it("should initially have 3 items", function()
		assert.same(3, dut:len())
	end)

	it("should clear all items", function()
		dut:clear()
		assert.same(0, dut:len())
	end)
end)
