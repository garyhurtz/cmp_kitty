local Match = require("cmp_kitty.match")
local dut = Match.new()

describe("kebab_case", function()
	it("should not match words", function()
		assert.is_false(dut:kebab_case("word"))
	end)

	it("should match kebab-case words", function()
		assert.is_true(dut:kebab_case("one-two"))
		assert.is_true(dut:kebab_case("one-two-three"))
	end)

	it("should not match words starting or ending with hyphens", function()
		assert.is_false(dut:kebab_case("-word"))
		assert.is_false(dut:kebab_case("word-"))
	end)

	it("should not match words with underscores", function()
		assert.is_false(dut:kebab_case("text_word"))
	end)

	it("should not match numbers", function()
		assert.is_false(dut:kebab_case("123"))
	end)
end)
