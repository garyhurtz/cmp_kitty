local Match = require("cmp_kitty.match")
local cmp = require("cmp")

describe("files_by_suffix", function()
    it("should not attempt to match by default", function()
        local dut = Match.new({ match_files_by_suffix = {} })
        assert.is_nil(next(dut.config.match_files_by_suffix))
    end)

    it("should attempt to match if suffix added", function()
        local dut = Match.new({ match_files_by_suffix = { "lua" } })
        assert.is_not_nil(next(dut.config.match_files_by_suffix))
    end)

    it("should match text with the specified suffix", function()
        local dut = Match.new({ match_files_by_suffix = { "lua" } })
        local label = "filename.lua"
        local result = dut:file_by_suffix({ label = label })

        assert.equal(label, result.label)
        assert.equal(cmp.lsp.CompletionItemKind.File, result.kind)
    end)

    it("should not match text with a different suffix", function()
        local dut = Match.new({ match_files_by_suffix = { "lua" } })
        local label = "filename.txt"
        local result = dut:file_by_suffix({ label = label })

        assert.is_nil(result)
    end)

    it("should support lua patterns", function()
        local dut = Match.new({ match_files_by_suffix = { "html?" } })

        it("1", function()
            local label = "filename.htm"
            local result = dut:file_by_suffix({ label = label })

            assert.equal(label, result.label)
            assert.equal(cmp.lsp.CompletionItemKind.File, result.kind)
        end)

        it("2", function()
            local label = "filename.html"
            local result = dut:file_by_suffix({ label = label })

            assert.equal(label, result.label)
            assert.equal(cmp.lsp.CompletionItemKind.File, result.kind)
        end)

        it("3", function()
            local label = "filename.htmx"
            local result = dut:file_by_suffix({ label = label })

            assert.is_nil(result)
        end)
    end)

    it("will also match some things that aren't strictly files", function()
        local dut = Match.new({ match_files_by_suffix = { "lua" } })

        it("1", function()
            local label = "FILE=match/files_by_suffix_spec.lua"
            local result = dut:file_by_suffix({ label = label })

            assert.equal(label, result.label)
            assert.equal(cmp.lsp.CompletionItemKind.File, result.kind)
        end)
    end)

end)
