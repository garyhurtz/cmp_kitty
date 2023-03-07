local Source = require("cmp_kitty.source"):new()

local kitty_ls = function()
	local cmd = Source.kitty:build_kitty_command("ls")
	local content = Source.kitty:execute_kitty_command(cmd)
	local lines = {}

	for line in content:gmatch("[^\n]+") do
		table.insert(lines, line)
	end

	-- open a new buffer
	vim.cmd("edit ls.json")
	-- get a reference to the new buffer
	local buf = vim.api.nvim_get_current_buf()
	-- set buffer text
	vim.api.nvim_buf_set_text(buf, 0, 0, 0, 0, lines)
	vim.api.nvim_win_set_cursor(0, { 1, 0 })
end

local kitty_select_window = function()
	local cmd = Source.kitty:build_kitty_command("select-window")
	return Source.kitty:execute_kitty_command(cmd):gsub("[\n]", "")
end

local kitty_include_window = function()
	local which = kitty_select_window()
	local cmd = Source.kitty:build_kitty_command("set-window-title", {
		"--match",
		"id:" .. which,
		"cmp-include",
	})
	Source.kitty:execute_kitty_command(cmd)
end

local kitty_exclude_window = function()
	local which = kitty_select_window()
	local cmd = Source.kitty:build_kitty_command("set-window-title", {
		"--match",
		"id:" .. which,
		"cmp-exclude",
	})
	Source.kitty:execute_kitty_command(cmd)
end

vim.api.nvim_create_user_command("CmpKittyLs", kitty_ls, { nargs = 0, desc = "Kitty @ ls" })

vim.api.nvim_create_user_command(
	"CmpKittyIncludeWindow",
	kitty_include_window,
	{ nargs = 0, desc = "Include Kitty window" }
)
vim.api.nvim_create_user_command(
	"CmpKittyExcludeWindow",
	kitty_exclude_window,
	{ nargs = 0, desc = "Exclude Kitty window" }
)

return Source
