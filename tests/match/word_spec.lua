local Match = require("cmp_kitty.match")
local dut = Match.new()
local cmp = require("cmp")

describe("word", function()
    it("should match words", function()
        local label = "word"
        local result = dut:word({ label = label })

        assert.equal(label, result.label)
        assert.equal(cmp.lsp.CompletionItemKind.Text, result.kind)
    end)

    it("should not match words with hyphens", function()
        assert.is_nil(dut:word({ label = "text-word" }))
    end)

    it("should not match words with underscores", function()
        assert.is_nil(dut:word({ label = "text_word" }))
    end)

    it("should not match numbers", function()
        assert.is_nil(dut:word({ label = "123" }))
    end)
end)
