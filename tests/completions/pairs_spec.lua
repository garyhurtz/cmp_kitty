local Completions = require("cmp_kitty.completions")

describe("pairs", function()
	local dut = Completions.new()
	dut:set_item_lifetime(60)

	dut:add("a")
	dut:add("b")
	dut:add("c")

	it("should support pairs", function()
		local result = 0

		for key, value in pairs(dut) do
			result = result + 1
		end

		assert.same(3, result)
	end)
end)
