local Match = require("cmp_kitty.match")
local dut = Match.new()
local cmp = require("cmp")

describe("lower_case", function()
	it("should match lower_case words", function()
		local label = "word"
		local result = dut:lower_case({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Text, result.kind)
	end)

	it("should not match other case words", function()
		assert.is_nil(dut:lower_case({ label = "WORD" }))
	end)

	it("should not match numbers", function()
		assert.is_nil(dut:lower_case({ label = "123" }))
	end)
end)
