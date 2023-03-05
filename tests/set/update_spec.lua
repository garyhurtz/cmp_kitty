local Set = require("cmp_kitty.set")

describe("update", function()
	local dut = Set.new()
	dut:add(1)
	dut:add(2)

	local other = Set.new()
	other:add(2)
	other:add(3)
	other:add(4)

	it("should add the other items", function()
		dut:update(other)
		assert.same(4, dut:len())
	end)
end)
