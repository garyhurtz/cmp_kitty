local Source = require("cmp_kitty.source")

describe("transform_item", function()
	local dut = Source:new()

	it("should transform completion items correctly", function()
		local result = dut:transform_item("item")

		assert.is_table(result)
		assert.is_not_nil(result.label)
		assert.same(result.label, "item")
	end)
end)
