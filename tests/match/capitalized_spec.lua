local Match = require("cmp_kitty.match")
local dut = Match.new()
local cmp = require("cmp")

describe("capitalized", function()
	it("should match capitalized words", function()
		local label = "Word"
		local result = dut:capitalized({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Text, result.kind)
	end)

	it("should not match capital letters", function()
		assert.is_nil(dut:capitalized({ label = "I" }))
	end)
	it("should not match lower_case words", function()
		assert.is_nil(dut:capitalized({ label = "word" }))
	end)

	it("should not match upper case words", function()
		assert.is_nil(dut:capitalized({ label = "WORD" }))
	end)

	it("should not match numbers", function()
		assert.is_nil(dut:capitalized({ label = "123" }))
	end)
end)
