local Match = require("cmp_kitty.match")
local dut = Match.new()

describe("snake_case", function()
	it("should not match words", function()
		assert.is_false(dut:snake_case("word"))
	end)

	it("should match snake-case words", function()
		assert.is_true(dut:snake_case("one_two"))
		assert.is_true(dut:snake_case("one_two_three"))
	end)

	it("should not match words starting or ending with underscores", function()
		assert.is_false(dut:snake_case("_word"))
		assert.is_false(dut:snake_case("word_"))
	end)

	it("should not match words with hyphens", function()
		assert.is_false(dut:snake_case("text-word"))
	end)

	it("should not match numbers", function()
		assert.is_false(dut:snake_case("123"))
	end)
end)
