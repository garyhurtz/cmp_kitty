local Match = require("cmp_kitty.match")
local dut = Match.new()

describe("camel_case", function()
	it("should not match words", function()
		assert.is_false(dut:camel_case("word"))
	end)

	it("should match camel-case words with leading lower-case", function()
		assert.is_true(dut:camel_case("oneTwo"))
		assert.is_true(dut:camel_case("oneTwoThree"))
	end)

	it("should match camel-case words with leading upper-case", function()
		assert.is_true(dut:camel_case("OneTwo"))
		assert.is_true(dut:camel_case("OneTwoThree"))
	end)

	it("should not match numbers", function()
		assert.is_false(dut:camel_case("123"))
	end)
end)
