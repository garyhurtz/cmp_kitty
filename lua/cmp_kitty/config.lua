return {

	-- cmp
	label = "[kitty]",
	trigger_characters = {},
	trigger_characters_ft = {},
	keyword_pattern = [[\w\+]],

	-- logger
	log_level = "warning",

	-- what information to collect
	match_words = true,
	match_upper_case = false,
	match_lower_case = false,
	match_capitalized = false,
	match_alphanumerics = true,
	match_camel_case = true,
	match_kebab_case = true,
	match_snake_case = true,
	match_words_with_punctuation = true,

	-- numbers
	match_integers = true,
	match_floats = true,
	match_hex_strings = true,
	match_binary_strings = true,

	--- computing
	match_emails = true,
	match_ip_addrs = true,
	match_urls = true,
	match_uuids = true,

	--- filesystem
	match_directories = true,
	match_files = true,
	match_hidden_files = true,

	--
	-- os window config
	--

	os_window = {
		include_active = true,
		include_inactive = true,

		include_focused = true,
		include_unfocused = true,

		--
		-- tab config
		--
		tab = {
			include_active = true,
			include_inactive = true,

			include_focused = true,
			include_unfocused = true,

			include_title = function(title)
				return title == "cmp-include"
			end,
			exclude_title = function(title)
				return title == "cmp-exclude"
			end,

			--
			-- window config
			--
			window = {

				include_active = true,
				include_inactive = true,

				include_focused = true,
				include_unfocused = true,

				include_title = function(title)
					return title == "cmp-include"
				end,
				exclude_title = function(title)
					return title == "cmp-exclude"
				end,

				include_cwd = function(path)
					return false
				end,
				exclude_cwd = function(path)
					return false
				end,

				include_env = function(env)
					return vim.tbl_contains(vim.tbl_keys(env), "CMP_INCLUDE")
				end,
				exclude_env = function(env)
					return vim.tbl_contains(vim.tbl_keys(env), "CMP_EXCLUDE")
				end,

				include_foreground_process = function(process)
					-- process = {cmd={str}, pid=int, cwd = str}
					-- match the command name
					local match_cmd = function(cmd)
						return false
					end

					for _, cmd in ipairs(process.cmdline) do
						if match_cmd(cmd) == true then
							return true
						end
					end

					return false
				end,
				exclude_foreground_process = function(process)
					-- process = {cmd={str}, pid=int, cwd = str}
					-- match the command name
					local match_cmd = function(cmd)
						return false
					end

					for _, cmd in ipairs(process.cmdline) do
						if match_cmd(cmd) == true then
							return true
						end
					end

					return false
				end,
			},
		},
	},

	-- the extent of the content to extract from each matched window
	-- this is passed directly to Kitty and accepts any value that Kitty accepts
	extent = "all",

	-- timing
	window_polling_period = 100, -- msec_
	min_update_restart_period = 5, -- sec
	completion_item_lifetime = 60, -- sec
}
