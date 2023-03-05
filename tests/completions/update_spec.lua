local Completions = require("cmp_kitty.completions")

describe("update", function()
	local dut = Completions.new()
	dut:set_item_lifetime(60)
	dut:add("a")
	dut:add("b")

	local other = Completions.new()
	other:set_item_lifetime(60)
	other:add("b")
	other:add("c")
	other:add("d")

	dut:update(other)

	it("should add the other items", function()
		assert.same(4, dut:len())
	end)
end)
