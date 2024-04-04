local Match = require("cmp_kitty.match")
local dut = Match.new()
local cmp = require("cmp")

describe("aws_unique_id", function()
    it("should not match words", function()
        assert.is_nil(dut:aws_unique_id({ label = "AIKA" }))
    end)

    -- examples from https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html#identifiers-unique-ids
    it("should match example 1", function()
        local label = "AIDACKCEVSQ6C2EXAMPLE"
        local result = dut:aws_unique_id({ label = label })

        assert.equal(label, result.label)
        assert.equal(cmp.lsp.CompletionItemKind.Value, result.kind)
    end)

    it("should match example 2", function()
        local label = "AROADBQP57FF2AEXAMPLE:role-session-name"
        local result = dut:aws_unique_id({ label = label })

        assert.equal(label, result.label)
        assert.equal(cmp.lsp.CompletionItemKind.Value, result.kind)
    end)

    it("should match example 3", function()
        local label = "AROA1234567890EXAMPLE:*"
        local result = dut:aws_unique_id({ label = label })

        assert.equal(label, result.label)
        assert.equal(cmp.lsp.CompletionItemKind.Value, result.kind)
    end)
end)
