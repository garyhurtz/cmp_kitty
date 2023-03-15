local Match = require("cmp_kitty.match")
local dut = Match.new()
local cmp = require("cmp")

describe("words with punctuation", function()
	it("should match words with one trailing punctuation character", function()
		local label = "word:"
		local result = dut:word_with_punctuation({ label = label })

		-- punctuation got stripped
		assert.equal("word", result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Text, result.kind)
	end)

	it("should not match words with more than one trailing punctuation character", function()
		assert.is_nil(dut:word_with_punctuation({ label = "word::" }))
	end)

	it("should not match words with punctuation in the middle", function()
		assert.is_nil(dut:word_with_punctuation({ label = "text:word" }))
	end)

	it("should not match words with punctuation at the start", function()
		assert.is_nil(dut:word_with_punctuation({ label = ":text" }))
	end)

	it("should not match single punctuation", function()
		assert.is_nil(dut:word_with_punctuation({ label = ":" }))
	end)
end)
