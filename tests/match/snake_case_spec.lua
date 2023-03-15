local Match = require("cmp_kitty.match")
local dut = Match.new()
local cmp = require("cmp")

describe("snake_case", function()
	it("should not match words", function()
		assert.is_nil(dut:snake_case({ label = "word" }))
	end)

	it("should match snake-case words 1", function()
		local label = "one_two"
		local result = dut:snake_case({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Text, result.kind)
	end)

	it("should match snake-case words 2", function()
		local label = "one_two_three"
		local result = dut:snake_case({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Text, result.kind)
	end)

	it("should not match words starting or ending with underscores", function()
		assert.is_nil(dut:snake_case({ label = "_word" }))
		assert.is_nil(dut:snake_case({ label = "word_" }))
	end)

	it("should not match words with hyphens", function()
		assert.is_nil(dut:snake_case({ label = "text-word" }))
	end)

	it("should not match numbers", function()
		assert.is_nil(dut:snake_case({ label = "123" }))
	end)
end)
