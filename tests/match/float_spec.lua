local Match = require("cmp_kitty.match")
local dut = Match.new()
describe("float", function()
	it("should not match words", function()
		assert.is_false(dut:float("word"))
	end)

	it("should not match integers", function()
		assert.is_false(dut:float("123"))
	end)

	it("should match floats", function()
		assert.is_true(dut:float("1.23"))
	end)

	it("should support negative floats", function()
		assert.is_true(dut:float("-1.23"))
	end)

	it("should support explicitly-positive floats", function()
		assert.is_true(dut:float("+1.23"))
	end)
end)
