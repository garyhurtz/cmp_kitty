local Match = require("cmp_kitty.match")
local dut = Match.new()
local cmp = require("cmp")

describe("integer", function()
	it("should not match words", function()
		assert.is_nil(dut:integer({ label = "word" }))
	end)

	it("should match integers", function()
		local label = "123"
		local result = dut:integer({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Value, result.kind)
	end)

	it("should support negative integers", function()
		local label = "-123"
		local result = dut:integer({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Value, result.kind)
	end)

	it("should support explicitly-positive integers", function()
		local label = "+123"
		local result = dut:integer({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Value, result.kind)
	end)

	it("should not match floats", function()
		assert.is_nil(dut:integer({ label = "1.23" }))
	end)
end)
