local Completions = require("cmp_kitty.completions")

describe("filter", function()
	local dut = Completions.new()
	dut:set_item_lifetime(60)

	dut:add({ label = "apples" })
	dut:add({ label = "bananas" })
	dut:add({ label = "cabbage" })

	local result = dut:filter("an")

	it("should return a list", function()
		assert.is_table(result)
		assert.is_true(vim.tbl_islist(result))
	end)

	it("should filter the items", function()
		assert.equal(#result, 1)
		assert.equal(result[1].label, "bananas")
	end)
end)
