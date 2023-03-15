local Completions = require("cmp_kitty.completions")

describe("update", function()
	local dut = Completions.new()
	dut:set_item_lifetime(60)
	dut:add({ label = "a" })
	dut:add({ label = "b" })

	local other = Completions.new()
	other:set_item_lifetime(60)
	other:add({ label = "b" })
	other:add({ label = "c" })
	other:add({ label = "d" })

	dut:update(other)

	it("should add the other items", function()
		assert.equal(4, dut:len())
	end)
end)
