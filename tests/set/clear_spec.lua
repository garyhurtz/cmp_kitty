local Set = require("cmp_kitty.set")

describe("clear", function()
	local dut = Set.new()

	it("should clear all items", function()
		dut:add(1)
		dut:add(2)

		assert.same(2, dut:len())
		dut:clear()
		assert.same(0, dut:len())
	end)
end)
