local Match = require("cmp_kitty.match")
local cmp = require("cmp")

local dut = Match.new()
describe("alphanumeric", function()
	it("should not match words", function()
		assert.is_nil(dut:alphanumeric({ label = "word" }))
	end)

	it("should match alphanumerics", function()
		local label = "word123"
		local result = dut:alphanumeric({ label = label })

		assert.equal(result.label, label)
		assert.equal(result.kind, cmp.lsp.CompletionItemKind.Text)
	end)

	it("should not match numbers", function()
		assert.is_nil(dut:alphanumeric({ label = "123" }))
	end)
end)
