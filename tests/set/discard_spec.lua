local Set = require("cmp_kitty.set")

describe("discard", function()
	local dut = Set.new()

	it("should discard item", function()
		dut:add(1)
		assert.same(true, dut:contains(1))
		dut:discard(1)
		assert.same(false, dut:contains(1))
	end)
end)
