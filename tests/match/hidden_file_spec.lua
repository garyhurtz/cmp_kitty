local Match = require("cmp_kitty.match")
local dut = Match.new()
local cmp = require("cmp")

describe("hidden_file", function()
	it("should match text that looks like hidden files 1", function()
		local label = ".filename.txt"
		local result = dut:hidden_file({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.File, result.kind)
	end)

	it("should match text that looks like hidden files 2", function()
		local label = "/.filename.txt"
		local result = dut:hidden_file({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.File, result.kind)
	end)

	it("should match hidden files in directories with only leading slashes 1", function()
		local label = "/one/.filename.txt"
		local result = dut:hidden_file({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.File, result.kind)
	end)

	it("should match hidden files in directories with only leading slashes 2", function()
		local label = "/one/two/.filename.txt"
		local result = dut:hidden_file({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.File, result.kind)
	end)

	it("should match hidden files in directories with only leading slashes 3", function()
		local label = "/one/two/three/.filename.txt"
		local result = dut:hidden_file({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.File, result.kind)
	end)

	it("should match hidden files in directories with leading tilde 1", function()
		local label = "~/one/.filename.txt"
		local result = dut:hidden_file({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.File, result.kind)
	end)

	it("should match hidden files in directories with leading tilde 2", function()
		local label = "~/one/two/.filename.txt"
		local result = dut:hidden_file({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.File, result.kind)
	end)

	it("should match hidden files in directories with leading tilde 3", function()
		local label = "~/one/two/three/.filename.txt"
		local result = dut:hidden_file({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.File, result.kind)
	end)

	it("should match hidden files in directories with only trailing slashes 1", function()
		local label = "one/.filename.txt"
		local result = dut:hidden_file({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.File, result.kind)
	end)

	it("should match hidden files in directories with only trailing slashes 2", function()
		local label = "one/two/.filename.txt"
		local result = dut:hidden_file({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.File, result.kind)
	end)

	it("should match hidden files in directories with only trailing slashes 3", function()
		local label = "one/two/three/.filename.txt"
		local result = dut:hidden_file({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.File, result.kind)
	end)

	it("should match hidden files in directories with leading and trailing slashes 1", function()
		local label = "/one/.filename.txt"
		local result = dut:hidden_file({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.File, result.kind)
	end)

	it("should match hidden files in directories with leading and trailing slashes 2", function()
		local label = "/one/two/.filename.txt"
		local result = dut:hidden_file({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.File, result.kind)
	end)

	it("should match hidden files in directories with leading and trailing slashes 3", function()
		local label = "/one/two/three/.filename.txt"
		local result = dut:hidden_file({ label = label })

		assert.equal(label, result.label)
		assert.equal(cmp.lsp.CompletionItemKind.File, result.kind)
	end)
end)
