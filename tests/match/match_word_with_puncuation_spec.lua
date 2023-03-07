local Match = require("cmp_kitty.match")
local dut = Match.new()

describe("words with punctuation", function()
	it("should match words with one trailing punctuation character", function()
		assert.is_true(dut:word_with_punctuation("word:"))
	end)

	it("should not match words with more than one trailing punctuation character", function()
		assert.is_false(dut:word_with_punctuation("word::"))
	end)

	it("should not match words with punctuation in the middle", function()
		assert.is_false(dut:word_with_punctuation("text:word"))
	end)

	it("should not match words with punctuation at the start", function()
		assert.is_false(dut:word_with_punctuation(":text"))
	end)

	it("should not match single punctuation", function()
		assert.is_false(dut:word_with_punctuation(":"))
	end)
end)
