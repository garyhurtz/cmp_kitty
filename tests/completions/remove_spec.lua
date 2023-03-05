local Completions = require("cmp_kitty.completions")

describe("remove", function()
	local dut = Completions.new()
	dut:set_item_lifetime(60)

	it("should remove item", function()
		dut:add("a")
		assert.same(true, dut:contains("a"))
		dut:remove("a")
		assert.same(false, dut:contains("a"))
	end)
end)
