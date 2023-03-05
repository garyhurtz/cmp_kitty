local Match = require("cmp_kitty.match")
local dut = Match.new()

describe("contains", function()
	it("should return true if word contains letter", function()
		assert.is_true(dut:contains("word", "o"))
	end)

	it("should return true if word contains pattern", function()
		assert.is_true(dut:contains("word", "%a"))
	end)

	it("should return true if number contains pattern", function()
		assert.is_true(dut:contains("123", "%d"))
	end)

	it("should return false if word does not contain", function()
		assert.is_false(dut:contains("word", "x"))
	end)

	it("should return false if word does not contain pattern", function()
		assert.is_false(dut:contains("word", "%d"))
	end)

	it("should return false if number does not contain pattern", function()
		assert.is_false(dut:contains("123", "%a"))
	end)
end)
