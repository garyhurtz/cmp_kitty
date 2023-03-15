local Match = require("cmp_kitty.match")
local dut = Match.new()
local cmp = require("cmp")

describe("uuid", function()
	it("should match uuids", function()
		local label = "123e4567-e89b-12d3-a456-426614174000"
		local result = dut:uuid({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Value, result.kind)
	end)

	it("should match uuids in braces", function()
		local label = "{123e4567-e89b-12d3-a456-426614174000}"
		local result = dut:uuid({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Value, result.kind)
	end)

	it("should match uuids in brackets 2", function()
		local label = "[123e4567-e89b-12d3-a456-426614174000]"
		local result = dut:uuid({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Value, result.kind)
	end)

	it("should not match words with hyphens", function()
		assert.is_nil(dut:uuid({ label = "text-word" }))
	end)

	it("should not match numbers", function()
		assert.is_nil(dut:uuid({ label = "123" }))
	end)
end)
