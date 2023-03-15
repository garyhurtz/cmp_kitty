local Match = require("cmp_kitty.match")
local dut = Match.new()
local cmp = require("cmp")

describe("binary", function()
	it("should match binary bits", function()
		local label = "0101"
		local result = dut:binary({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Value, result.kind)
	end)

	it("should match binary byte", function()
		local label = "01010101"
		local result = dut:binary({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Value, result.kind)
	end)

	it("should not match numbers", function()
		assert.is_nil(dut:binary({ label = "123" }))
	end)

	it("should not match numbers that look binary 1", function()
		assert.is_nil(dut:binary({ label = "10" }))
	end)

	it("should not match numbers that look binary 2", function()
		assert.is_nil(dut:binary({ label = "010" }))
	end)
end)
