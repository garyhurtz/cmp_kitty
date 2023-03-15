local Completions = require("cmp_kitty.completions")

describe("remove", function()
	local dut = Completions.new()
	dut:set_item_lifetime(60)

	it("should with the correct items", function()
		dut:add({ label = "a" })
		dut:add({ label = "b" })
		assert.is_true(dut:contains("a"))
		assert.is_true(dut:contains("b"))
	end)

	it("should remove item", function()
		dut:remove("a")
		assert.is_false(dut:contains("a"))
		assert.is_true(dut:contains("b"))
	end)
end)
