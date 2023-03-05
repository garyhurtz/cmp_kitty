local Kitty = require("cmp_kitty.kitty")
local defaults = require("cmp_kitty.config")
local Set = require("cmp_kitty.set")

describe("get_completion_items", function()
	local dut = Kitty:new(defaults)

	local result = dut:get_completion_items()

	it("should return a set", function()
		assert.is_true(Set.is_set(result))
	end)
end)
