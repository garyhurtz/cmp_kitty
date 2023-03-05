local Match = require("cmp_kitty.match")

local dut = Match.new()
describe("urls", function()
	it("should match http urls", function()
		assert.is_true(dut:url("http://example.com"))
	end)

	it("should match https urls", function()
		assert.is_true(dut:url("https://example.com"))
	end)

	it("should allow dashes in domain", function()
		assert.is_true(dut:url("https://one-two.com"))
	end)

	it("should match tlds", function()
		assert.is_true(dut:url("http://example.com.uk"))
	end)

	it("should not match numbers", function()
		assert.is_false(dut:email("123"))
	end)
end)
