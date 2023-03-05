local Set = require("cmp_kitty.set")

describe("difference", function()
	local dut = Set.new()
	dut:add(1)
	dut:add(2)

	local other = Set.new()
	other:add(2)
	other:add(3)
	other:add(4)

	it("should return 1", function()
		local result = dut:difference(other)
		assert.same(1, result:len())
		assert.is_true(result:contains(1))
	end)

	it("should return 3, 4", function()
		local result = other:difference(dut)
		assert.same(2, result:len())
		assert.is_true(result:contains(3))
		assert.is_true(result:contains(4))
	end)
end)