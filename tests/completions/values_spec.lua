local Completions = require("cmp_kitty.completions")
local Set = require("cmp_kitty.set")

describe("values", function()
	local dut = Completions.new()
	dut:set_item_lifetime(60)

	dut:add("a")
	dut:add("b")
	dut:add("c")

	local values = dut:values()

	it("should return a set", function()
		assert.is_true(Set.is_set(values))
	end)

	it("should have 3 values", function()
		assert.same(3, values:len())
	end)

	it("should have the correct 3 values", function()
		assert.is_true(values:contains("a"))
		assert.is_true(values:contains("b"))
		assert.is_true(values:contains("c"))
	end)
end)
