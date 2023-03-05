local Match = require("cmp_kitty.match")
local dut = Match.new()

describe("word", function()
	it("should match words", function()
		assert.is_true(dut:word("word"))
	end)

	it("should not match words with hyphens", function()
		assert.is_false(dut:word("text-word"))
	end)

	it("should not match words with underscores", function()
		assert.is_false(dut:word("text_word"))
	end)

	it("should not match numbers", function()
		assert.is_false(dut:word("123"))
	end)
end)
