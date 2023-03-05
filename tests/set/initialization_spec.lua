local Set = require("cmp_kitty.set")

describe("set", function()
	local dut = Set.new()

	it("is a set", function()
		assert.equals(true, Set.is_set(dut))
	end)

	it("is empty", function()
		assert.equals(0, dut:len())
	end)
end)
