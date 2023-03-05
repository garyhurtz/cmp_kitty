local Window = require("cmp_kitty.window")
local config = require("cmp_kitty.config")

describe("constructor", function()
	-- data skeleton
	local data = {}

	local dut = Window.new(config, data)

	it("should have a config attribute", function()
		assert.is_table(dut.config)
	end)

	it("should have a config.include_active", function()
		assert.is_true(type(dut.config.include_active) == "boolean")
	end)

	it("should have a config.include_inactive", function()
		assert.is_true(type(dut.config.include_inactive) == "boolean")
	end)

	it("should have a config.include_focused", function()
		assert.is_true(type(dut.config.include_focused) == "boolean")
	end)

	it("should have a config.include_unfocused", function()
		assert.is_true(type(dut.config.include_unfocused) == "boolean")
	end)

	it("should have a config.include_title", function()
		assert.is_true(type(dut.config.include_title) == "function")
	end)

	it("should have a config.exclude_title", function()
		assert.is_true(type(dut.config.exclude_title) == "function")
	end)

	it("should have a config.include_cwd", function()
		assert.is_true(type(dut.config.include_cwd) == "function")
	end)

	it("should have a config.exclude_cwd", function()
		assert.is_true(type(dut.config.exclude_cwd) == "function")
	end)

	it("should have a config.include_env", function()
		assert.is_true(type(dut.config.include_env) == "function")
	end)

	it("should have a config.exclude_env", function()
		assert.is_true(type(dut.config.exclude_env) == "function")
	end)

	it("should have a config.include_foreground_process", function()
		assert.is_true(type(dut.config.include_foreground_process) == "function")
	end)

	it("should have a config.exclude_foreground_process", function()
		assert.is_true(type(dut.config.exclude_foreground_process) == "function")
	end)

	it("should have a data attribute", function()
		assert.is_table(dut.data)
	end)
end)
