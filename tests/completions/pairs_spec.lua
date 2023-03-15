local Completions = require("cmp_kitty.completions")

describe("pairs", function()
	local dut = Completions.new()
	dut:set_item_lifetime(60)

	dut:add({ label = "a" })
	dut:add({ label = "b" })
	dut:add({ label = "c" })

	it("should support pairs", function()
		local result = 0

		for key, obj in pairs(dut.items) do
			result = result + 1

			assert.is_string(key)
			assert.is_table(obj)
			assert.equal(key, obj.label)
		end

		assert.equal(3, result)
	end)
end)
