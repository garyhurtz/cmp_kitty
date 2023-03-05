local Match = require("cmp_kitty.match")
local dut = Match.new()

describe("upper_case", function()
	it("should match upper_case words", function()
		assert.is_true(dut:upper_case("WORD"))
	end)

	it("should not match other case words", function()
		assert.is_false(dut:upper_case("word"))
	end)

	it("should not match numbers", function()
		assert.is_false(dut:upper_case("123"))
	end)
end)
