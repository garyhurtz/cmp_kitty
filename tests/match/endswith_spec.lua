local Match = require("cmp_kitty.match")
local dut = Match.new()

describe("endswith", function()
	it("should return true if word ends with", function()
		assert.is_true(dut:endswith("word", "d"))
	end)

	it("should return false if word does not end with", function()
		assert.is_false(dut:endswith("word", "x"))
	end)
end)
