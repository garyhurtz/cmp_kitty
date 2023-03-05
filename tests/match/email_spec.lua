local Match = require("cmp_kitty.match")

local dut = Match.new()
describe("emails", function()
	it("should match simple emails", function()
		assert.is_true(dut:email("test@example.com"))
	end)

	it("should allow dots in username", function()
		assert.is_true(dut:email("other.test@example.com"))
	end)

	it("should allow dashes in username", function()
		assert.is_true(dut:email("other-test@example.com"))
	end)

	it("should allow underscores in username", function()
		assert.is_true(dut:email("other_test@example.com"))
	end)

	it("should allow dashes in domain", function()
		assert.is_true(dut:email("test@other-example.com"))
	end)

	it("should allow underscores in domain", function()
		assert.is_true(dut:email("test@other_example.com"))
	end)

	it("should match tlds", function()
		assert.is_true(dut:email("test@example.com.uk"))
	end)

	it("should not match words", function()
		assert.is_false(dut:email("test"))
		assert.is_false(dut:email("example"))
		assert.is_false(dut:email("com"))
	end)
	it("should not match numbers", function()
		assert.is_false(dut:email("123"))
	end)
end)
