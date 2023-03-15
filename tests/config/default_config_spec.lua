local config = require("cmp_kitty.config")

describe("root level", function()
	local dut = config

	it("should have a log_level attribute", function()
		assert.is_string(dut.log_level)
		assert.equal("warning", dut.log_level)
	end)

	-- cmp

	it("should have a trigger_characters attribute", function()
		assert.is_table(dut.trigger_characters)
	end)

	it("should have a trigger_characters_ft attribute", function()
		assert.is_table(dut.trigger_characters_ft)
	end)

	it("should have a keyword_pattern attribute", function()
		assert.is_string(dut.keyword_pattern)
	end)

	-- matching config

	--- words

	it("should have a match_words attribute", function()
		assert.is_boolean(dut.match_words)
		assert.is_true(dut.match_words)
	end)

	it("should have a match_words_with_punctuation attribute", function()
		assert.is_boolean(dut.match_words_with_punctuation)
		assert.is_true(dut.match_words_with_punctuation)
	end)

	it("should have a match_upper_case attribute", function()
		assert.is_boolean(dut.match_upper_case)
		assert.is_false(dut.match_upper_case)
	end)

	it("should have a match_lower_case attribute", function()
		assert.is_boolean(dut.match_lower_case)
		assert.is_false(dut.match_lower_case)
	end)

	it("should have a match_alphanumerics attribute", function()
		assert.is_boolean(dut.match_alphanumerics)
		assert.is_true(dut.match_alphanumerics)
	end)

	it("should have a match_camel_case attribute", function()
		assert.is_boolean(dut.match_camel_case)
		assert.is_true(dut.match_camel_case)
	end)

	it("should have a match_kebab_case attribute", function()
		assert.is_boolean(dut.match_kebab_case)
		assert.is_true(dut.match_kebab_case)
	end)

	it("should have a match_snake_case attribute", function()
		assert.is_boolean(dut.match_snake_case)
		assert.is_true(dut.match_snake_case)
	end)

	--- internet

	it("should have a match_emails attribute", function()
		assert.is_boolean(dut.match_emails)
		assert.is_true(dut.match_emails)
	end)

	it("should have a match_hex_strings attribute", function()
		assert.is_boolean(dut.match_hex_strings)
		assert.is_true(dut.match_hex_strings)
	end)

	it("should have a match_ip_addrs attribute", function()
		assert.is_boolean(dut.match_ip_addrs)
		assert.is_true(dut.match_ip_addrs)
	end)

	it("should have a match_urls attribute", function()
		assert.is_boolean(dut.match_urls)
		assert.is_true(dut.match_urls)
	end)

	it("should have a match_uuids attribute", function()
		assert.is_boolean(dut.match_uuids)
		assert.is_true(dut.match_uuids)
	end)

	--- filesystem

	it("should have a match_directories attribute", function()
		assert.is_boolean(dut.match_directories)
		assert.is_true(dut.match_directories)
	end)

	it("should have a match_files attribute", function()
		assert.is_boolean(dut.match_files)
		assert.is_true(dut.match_files)
	end)

	it("should have a match_hidden_files attribute", function()
		assert.is_boolean(dut.match_hidden_files)
		assert.is_true(dut.match_hidden_files)
	end)

	--- other

	it("should have a extent attribute", function()
		assert.is_string(dut.extent)
		assert.equal("all", dut.extent)
	end)

	it("should have a strict_matching attribute", function()
		assert.is_boolean(dut.strict_matching)
		assert.is_false(dut.strict_matching)
	end)

	it("should have a os_window attribute", function()
		assert.is_table(dut.os_window)
	end)
end)

describe("os_window", function()
	local dut = config.os_window

	it("should have include_active attribute", function()
		assert.is_boolean(dut.include_active)
	end)

	it("should have a include_inactive attribute", function()
		assert.is_boolean(dut.include_inactive)
	end)

	it("should have a include_focused attribute", function()
		assert.is_boolean(dut.include_focused)
	end)

	it("should have a include_unfocused attribute", function()
		assert.is_boolean(dut.include_unfocused)
	end)

	it("should have a tab attribute", function()
		assert.is_table(dut.tab)
	end)
end)

describe("os_window.tab", function()
	local dut = config.os_window.tab

	it("should have a include_active attribute", function()
		assert.is_boolean(dut.include_active)
	end)

	it("should have a include_inactive attribute", function()
		assert.is_boolean(dut.include_inactive)
	end)

	it("should have a include_focused attribute", function()
		assert.is_boolean(dut.include_focused)
	end)

	it("should have a include_unfocused attribute", function()
		assert.is_boolean(dut.include_unfocused)
	end)

	it("should have a include_title attribute", function()
		assert.is_function(dut.include_title)
	end)

	it("should have a exclude_title attribute", function()
		assert.is_function(dut.exclude_title)
	end)

	it("should have a window attribute", function()
		assert.is_table(dut.window)
	end)
end)

describe("os_window.tab.window", function()
	local dut = config.os_window.tab.window

	it("should have a include_active attribute", function()
		assert.is_boolean(dut.include_active)
	end)

	it("should have a include_inactive attribute", function()
		assert.is_boolean(dut.include_inactive)
	end)

	it("should have a include_unfocused attribute", function()
		assert.is_boolean(dut.include_focused)
	end)

	it("should have a include_unfocused attribute", function()
		assert.is_boolean(dut.include_unfocused)
	end)

	it("should have a include_title attribute", function()
		assert.is_function(dut.include_title)
	end)

	it("should have a exclude_title attribute", function()
		assert.is_function(dut.exclude_title)
	end)

	it("should have a include_cwd attribute", function()
		assert.is_function(dut.include_cwd)
	end)

	it("should have a exclude_cwd attribute", function()
		assert.is_function(dut.exclude_cwd)
	end)

	it("should have a include_env attribute", function()
		assert.is_function(dut.include_env)
	end)

	it("should have a exclude_env attribute", function()
		assert.is_function(dut.exclude_env)
	end)

	it("should have a include_foreground_processes attribute", function()
		assert.is_function(dut.include_foreground_process)
	end)

	it("should have a exclude_foreground_processes attribute", function()
		assert.is_function(dut.exclude_foreground_process)
	end)
end)
