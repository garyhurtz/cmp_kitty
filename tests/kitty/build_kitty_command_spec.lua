local Kitty = require("cmp_kitty.kitty")
local defaults = require("cmp_kitty.config")

describe("with socket", function()
	local config = defaults

	local dut = Kitty:new(config)

	local result = dut:build_kitty_command("ls")

	it("should construct correct command", function()
		assert.is_not_nil(result:gmatch("kitty @ --to unix:@kitty-%d+ ls"))
	end)
end)

describe("with args", function()
	local config = defaults

	local dut = Kitty:new(config)

	local result = dut:build_kitty_command("ls", { "plus", "some", "args" })

	it("should construct correct command", function()
		assert.is_not_nil(result:gmatch("kitty @ --to unix:@kitty-%d+ ls plus some args"))
	end)
end)
