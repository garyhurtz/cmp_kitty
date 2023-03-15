local Match = require("cmp_kitty.match")
local dut = Match.new()
local cmp = require("cmp")

describe("emails", function()
	it("should match simple emails", function()
		local label = "test@example.com"
		local result = dut:email({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Text, result.kind)
	end)

	it("should allow dots in username", function()
		local label = "other.test@example.com"
		local result = dut:email({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Text, result.kind)
	end)

	it("should allow dashes in username", function()
		local label = "other-test@example.com"
		local result = dut:email({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Text, result.kind)
	end)

	it("should allow underscores in username", function()
		local label = "other_test@example.com"
		local result = dut:email({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Text, result.kind)
	end)

	it("should allow dashes in domain", function()
		local label = "test@other-example.com"
		local result = dut:email({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Text, result.kind)
	end)

	it("should allow underscores in domain", function()
		local label = "test@other_example.com"
		local result = dut:email({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Text, result.kind)
	end)

	it("should match tlds", function()
		local label = "test@example.com.uk"
		local result = dut:email({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Text, result.kind)
	end)

	it("should not match words", function()
		assert.is_nil(dut:email({ label = "test" }))
		assert.is_nil(dut:email({ label = "example" }))
		assert.is_nil(dut:email({ label = "com" }))
	end)
	it("should not match numbers", function()
		assert.is_nil(dut:email({ label = "123" }))
	end)
end)
