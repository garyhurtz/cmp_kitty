local Match = require("cmp_kitty.match")
local dut = Match.new()

describe("uuid", function()
	it("should match uuids", function()
		assert.is_true(dut:uuid("123e4567-e89b-12d3-a456-426614174000"))
	end)

	it("should match uuids in bracktes", function()
		assert.is_true(dut:uuid("{123e4567-e89b-12d3-a456-426614174000}"))
		assert.is_true(dut:uuid("[123e4567-e89b-12d3-a456-426614174000]"))
	end)

	it("should not match words with hyphens", function()
		assert.is_false(dut:word("text-word"))
	end)

	it("should not match numbers", function()
		assert.is_false(dut:word("123"))
	end)
end)
