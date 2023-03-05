local Match = require("cmp_kitty.match")
local dut = Match.new()

describe("capitalized", function()
	it("should match capitalized words", function()
		assert.is_true(dut:capitalized("Word"))
	end)

	it("should not match capital letters", function()
		assert.is_false(dut:capitalized("I"))
	end)
	it("should not match lower_case words", function()
		assert.is_false(dut:capitalized("word"))
	end)

	it("should not match upper case words", function()
		assert.is_false(dut:capitalized("WORD"))
	end)

	it("should not match numbers", function()
		assert.is_false(dut:capitalized("123"))
	end)
end)
