local Match = require("cmp_kitty.match")
local dut = Match.new()

describe("integer", function()
	it("should not match words", function()
		assert.is_false(dut:integer("word"))
	end)

	it("should match integers", function()
		assert.is_true(dut:integer("123"))
	end)

	it("should support negative integers", function()
		assert.is_true(dut:integer("-123"))
	end)

	it("should support explicitly-positive integers", function()
		assert.is_true(dut:integer("+123"))
	end)

	it("should not match floats", function()
		assert.is_false(dut:integer("1.23"))
	end)
end)
