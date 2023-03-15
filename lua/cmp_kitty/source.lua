local Kitty = require("cmp_kitty.kitty")

local cmp_config = require("cmp.config")

local source_name = "kitty"

local Source = {}

function Source:new()
	local default_config = require("cmp_kitty.config")
	local user_config = cmp_config.get_source_config(source_name) or {}

	user_config.option = user_config.option or {}

	if user_config.option ~= nil then
		self.config = vim.tbl_deep_extend("force", default_config, user_config.option)
	end

	self.kitty = Kitty:new(self.config)

	return self
end

function Source:setup()
	require("cmp").register_source(source_name, Source)
end

function Source.get_debug_name()
	return source_name
end

function Source:is_available()
	return self.kitty:is_available()
end

function Source:get_keyword_pattern()
	return self.config.keyword_pattern
end

function Source:resolve(completion_item, callback)
	callback(completion_item)
end

function Source:execute(completion_item, callback)
	callback(completion_item)
end

function Source:complete(request, callback)
	local input = string.sub(request.context.cursor_before_line, request.offset)
	callback(self.kitty:get_completion_items(input))
end

return Source
