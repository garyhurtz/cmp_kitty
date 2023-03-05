local Match = require("cmp_kitty.match")

local dut = Match.new()
describe("alphanumeric", function()
	it("should not match words", function()
		assert.is_false(dut:alphanumeric("word"))
	end)

	it("should match alphanumerics", function()
		assert.is_true(dut:alphanumeric("word123"))
	end)

	it("should not match numbers", function()
		assert.is_false(dut:alphanumeric("123"))
	end)
end)
