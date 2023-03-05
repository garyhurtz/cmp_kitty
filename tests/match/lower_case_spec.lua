local Match = require("cmp_kitty.match")
local dut = Match.new()

describe("lower_case", function()
	it("should match lower_case words", function()
		assert.is_true(dut:lower_case("word"))
	end)

	it("should not match other case words", function()
		assert.is_false(dut:lower_case("WORD"))
	end)

	it("should not match numbers", function()
		assert.is_false(dut:lower_case("123"))
	end)
end)
