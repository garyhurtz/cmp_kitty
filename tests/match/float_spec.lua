local Match = require("cmp_kitty.match")
local dut = Match.new()
local cmp = require("cmp")

describe("float", function()
	it("should not match words", function()
		assert.is_nil(dut:float({ label = "word" }))
	end)

	it("should not match integers", function()
		assert.is_nil(dut:float({ label = "123" }))
	end)

	it("should match floats", function()
		local label = "1.23"
		local result = dut:float({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Value, result.kind)
	end)

	it("should support negative floats", function()
		local label = "-1.23"
		local result = dut:float({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Value, result.kind)
	end)

	it("should support explicitly-positive floats", function()
		local label = "+1.23"
		local result = dut:float({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Value, result.kind)
	end)
end)
