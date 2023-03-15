local Match = require("cmp_kitty.match")
local dut = Match.new()
local cmp = require("cmp")

describe("upper_case", function()
	it("should match upper_case words", function()
		local label = "WORD"
		local result = dut:upper_case({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Text, result.kind)
	end)

	it("should not match other case words", function()
		assert.is_nil(dut:upper_case({ label = "word" }))
	end)

	it("should not match numbers", function()
		assert.is_nil(dut:upper_case({ label = "123" }))
	end)
end)
