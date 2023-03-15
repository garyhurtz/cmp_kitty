local Match = require("cmp_kitty.match")
local dut = Match.new()
local cmp = require("cmp")

describe("ip", function()
	it("should match ip addresses ", function()
		local label = "1.1.1.1"
		local result = dut:ip({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Value, result.kind)
	end)

	it("should match ip addresses 2", function()
		local label = "12.12.12.12"
		local result = dut:ip({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Value, result.kind)
	end)

	it("should match ip addresses 3", function()
		local label = "123.123.123.123"
		local result = dut:ip({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Value, result.kind)
	end)

	it("should not match numbers", function()
		assert.is_nil(dut:ip({ label = "123" }))
		assert.is_nil(dut:ip({ label = "123.123" }))
	end)
end)
