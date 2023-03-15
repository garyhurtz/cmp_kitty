local Match = require("cmp_kitty.match")
local cmp = require("cmp")
local dut = Match.new()

describe("urls", function()
	it("should match http urls", function()
		local label = "http://example.com"
		local result = dut:url({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Text, result.kind)
	end)

	it("should match https urls", function()
		local label = "https://example.com"
		local result = dut:url({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Text, result.kind)
	end)

	it("should allow dashes in domain", function()
		local label = "https://one-two.com"
		local result = dut:url({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Text, result.kind)
	end)

	it("should match tlds", function()
		local label = "http://example.com.uk"
		local result = dut:url({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Text, result.kind)
	end)

	it("should not match numbers", function()
		assert.is_nil(dut:url({ label = "123" }))
	end)
end)
