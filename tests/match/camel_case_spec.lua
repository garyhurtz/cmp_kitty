local Match = require("cmp_kitty.match")
local dut = Match.new()
local cmp = require("cmp")

describe("camel_case", function()
	it("should not match words", function()
		assert.is_nil(dut:camel_case({ label = "word" }))
	end)

	it("should match camel-case words with leading lower-case 1", function()
		local label = "oneTwo"
		local result = dut:camel_case({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Text, result.kind)
	end)

	it("should match camel-case words with leading lower-case 2", function()
		local label = "oneTwoThree"
		local result = dut:camel_case({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Text, result.kind)
	end)

	it("should match camel-case words with leading upper-case 1", function()
		local label = "OneTwo"
		local result = dut:camel_case({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Text, result.kind)
	end)

	it("should match camel-case words with leading upper-case 2", function()
		local label = "OneTwoThree"
		local result = dut:camel_case({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Text, result.kind)
	end)

	it("should not match numbers", function()
		assert.is_nil(dut:camel_case({ label = "123" }))
	end)
end)
