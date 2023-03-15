local Match = require("cmp_kitty.match")
local dut = Match.new()
local cmp = require("cmp")

describe("hex", function()
	it("should not match words", function()
		assert.is_nil(dut:hex({ label = "word" }))
	end)

	it("should match hex 1", function()
		local label = "ff"
		local result = dut:hex({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Value, result.kind)
	end)

	it("should match hex 2", function()
		local label = "ff123"
		local result = dut:hex({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Value, result.kind)
	end)

	it("should support leading hash 1", function()
		local label = "#ff"
		local result = dut:hex({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Value, result.kind)
	end)

	it("should support leading hash 2", function()
		local label = "#ff1234"
		local result = dut:hex({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Value, result.kind)
	end)

	it("should support leading 0x 1", function()
		local label = "0xff"
		local result = dut:hex({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Value, result.kind)
	end)

	it("should support leading 0x 2", function()
		local label = "0xff1234"
		local result = dut:hex({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Value, result.kind)
	end)

	it("should match numbers", function()
		local label = "123"
		local result = dut:hex({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Value, result.kind)
	end)

	it("should match numbers", function()
		local label = "123"
		local result = dut:hex({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Value, result.kind)
	end)
end)
