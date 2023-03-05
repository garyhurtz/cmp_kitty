local Completions = require("cmp_kitty.completions")

describe("completions", function()
	local dut = Completions.new()
	dut:set_item_lifetime(60)

	it("is a Completions", function()
		assert.equals(true, Completions.is_completions(dut))
	end)

	it("is empty", function()
		assert.equals(0, dut:len())
	end)

	it("sets lifetime", function()
		assert.same(60, dut.lifetime)
	end)

	it("sets expiration", function()
		assert.is_true(dut.expiration > os.time() + 59)
		assert.is_true(dut.expiration < os.time() + 61)
	end)
end)
