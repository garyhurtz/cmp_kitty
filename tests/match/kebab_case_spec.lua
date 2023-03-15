local Match = require("cmp_kitty.match")
local dut = Match.new()
local cmp = require("cmp")

describe("kebab_case", function()
	it("should not match words", function()
		assert.is_nil(dut:kebab_case({ label = "word" }))
	end)

	it("should match kebab-case words 1", function()
		local label = "one-two"
		local result = dut:kebab_case({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Text, result.kind)
	end)

	it("should match kebab-case words 2", function()
		local label = "one-two-three"
		local result = dut:kebab_case({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Text, result.kind)
	end)

	it("should not match words starting or ending with hyphens", function()
		assert.is_nil(dut:kebab_case({ label = "-word" }))
		assert.is_nil(dut:kebab_case({ label = "word-" }))
	end)

	it("should not match words with underscores", function()
		assert.is_nil(dut:kebab_case({ label = "text_word" }))
	end)

	it("should not match numbers", function()
		assert.is_nil(dut:kebab_case({ label = "123" }))
	end)
end)
