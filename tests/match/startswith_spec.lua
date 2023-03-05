local Match = require("cmp_kitty.match")
local dut = Match.new()

describe("startswith", function()
	it("should return true if word starts with", function()
		assert.is_true(dut:startswith("word", "w"))
	end)

	it("should return false if word does not start with", function()
		assert.is_false(dut:startswith("word", "x"))
	end)
end)
