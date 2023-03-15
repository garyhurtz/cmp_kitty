local Kitty = require("cmp_kitty.kitty")
local defaults = require("cmp_kitty.config")

describe("get_completion_items", function()
	local dut = Kitty:new(defaults)

	local result = dut:get_completion_items()

	it("should return a list", function()
		assert.is_true(vim.tbl_islist(result))
	end)
end)
