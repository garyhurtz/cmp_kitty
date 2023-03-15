local Match = require("cmp_kitty.match")
local dut = Match.new()
local cmp = require("cmp")

describe("directory", function()
	it("should match directories with only leading slashes 1", function()
		local label = "/one"
		local result = dut:directory({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Folder, result.kind)
	end)

	it("should match directories with only leading slashes 2", function()
		local label = "/one/two"
		local result = dut:directory({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Folder, result.kind)
	end)

	it("should match directories with only leading slashes 3", function()
		local label = "/one/two/three"
		local result = dut:directory({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Folder, result.kind)
	end)

	it("should match directories with leading tilde 1", function()
		local label = "~/one"
		local result = dut:directory({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Folder, result.kind)
	end)

	it("should match directories with leading tilde 2", function()
		local label = "~/one/two"
		local result = dut:directory({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Folder, result.kind)
	end)

	it("should match directories with leading tilde 3", function()
		local label = "~/one/two/three"
		local result = dut:directory({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Folder, result.kind)
	end)

	it("should match directories with only trailing slashes 1", function()
		local label = "one/"
		local result = dut:directory({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Folder, result.kind)
	end)

	it("should match directories with only trailing slashes 2", function()
		local label = "one/two/"
		local result = dut:directory({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Folder, result.kind)
	end)

	it("should match directories with only trailing slashes 3", function()
		local label = "one/two/three/"
		local result = dut:directory({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Folder, result.kind)
	end)

	it("should match directories with leading and trailing slashes 1", function()
		local label = "/one/"
		local result = dut:directory({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Folder, result.kind)
	end)

	it("should match directories with leading and trailing slashes 2", function()
		local label = "/one/two/"
		local result = dut:directory({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Folder, result.kind)
	end)

	it("should match directories with leading and trailing slashes 3", function()
		local label = "/one/two/three/"
		local result = dut:directory({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.Folder, result.kind)
	end)
end)
