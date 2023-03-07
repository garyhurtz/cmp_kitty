local Match = {}

Match.new = function(config)
	local inst = {
		config = config,
	}

	setmetatable(inst, { __index = Match })

	return inst
end

function Match:contains(text, c)
	return text:find(c) ~= nil or text:match(c) ~= nil
end

function Match:startswith(text, c)
	return text:sub(1, #c) == c
end

function Match:endswith(text, c)
	return c == "" or text:sub(-#c) == c
end

function Match:word(text)
	return text:match("^%a+$") ~= nil
end

function Match:word_with_punctuation(text)
	return text:match("^%a+%p$") ~= nil
end

function Match:upper_case(text)
	return text:match("^%u+$") ~= nil
end

function Match:lower_case(text)
	return text:match("^%l+$") ~= nil
end

function Match:capitalized(text)
	return text:match("^%u%l+$") ~= nil
end

function Match:kebab_case(text)
	-- match kebab pattern
	if text:match("^%a[%a-]+%a$") == nil then
		return false
	end
	-- must have at least one hyphen
	-- return text:find("-") ~= nil
	return self:contains(text, "-")
end

function Match:snake_case(text)
	-- match snake pattern
	if text:match("^%a[%a_]+%a$") == nil then
		return false
	end
	-- must have at least one underscore
	return self:contains(text, "_")
	-- return text:find("_") ~= nil
end

function Match:camel_case(text)
	return text:match("^%u?%l+%u%l[%u%l]*$") ~= nil
end

function Match:alphanumeric(text)
	-- match alphanumeric pattern
	if text:match("^%w+$") == nil then
		return false
	end

	-- must have at least one letter and one digit
	return self:contains(text, "%a") and self:contains(text, "%d")
end

function Match:integer(text)
	return text:match("^[+-]?%d+$") ~= nil
end

function Match:float(text)
	return text:match("^[+-]?%d+[.]%d+$") ~= nil
end

function Match:hex(text)
	return text:match("^#?%x+$") ~= nil or text:match("^0x%x+$") ~= nil
end

function Match:binary(text)
	return #text >= 4 and text:match("^[01]+$") ~= nil
end

function Match:email(text)
	return text:match("^[%w%._-]+@[%w_-]+%.[%a%d]+") ~= nil
end

function Match:url(text)
	return text:match("^https?://[%w-]+%.%w+") ~= nil
end

function Match:ip(text)
	return text:match("^%d+%.%d+%.%d+%.%d+") ~= nil
end

function Match:uuid(text)
	-- allow brackets, etc
	return text:match("%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x") ~= nil
end

function Match:directory(text)
	if text:match("^~/[%w_/-]+/?$") ~= nil then
		return true
	elseif text:match("^/?[%w_/-]+/?$") ~= nil then
		return self:startswith(text, "/") or self:endswith(text, "/")
	else
		return false
	end
end

function Match:file(text)
	if text:match("^~/[%w_/-]+/[%w_-]+%.%w+$") ~= nil then
		return true
	elseif text:match("^/?[%w_/-]+/[%w_-]+%.%w+$") ~= nil then
		return true
	elseif text:match("^/?[%w_-]+%.%w+$") ~= nil then
		return true
	else
		return false
	end
end

function Match:hidden_file(text)
	if text:match("^~/[%w_/-]+/%.[%w_-]+%.%w+$") ~= nil then
		return true
	elseif text:match("^/?[%w_/-]+/%.[%w_-]+%.%w+$") ~= nil then
		return true
	elseif text:match("^/?%.[%w_-]+%.%w+$") ~= nil then
		return true
	else
		return false
	end
end

function Match:match_word(text)
	-- if it doesn't contain a letter it isn't a word
	if not self:contains(text, "%a") then
		return false
	end

	return (self.config.match_words and self:word(text))
		or (self.config.match_words_with_punctuation and self:word_with_punctuation(text))
		or (self.config.match_upper_case and self:upper_case(text))
		or (self.config.match_lower_case and self:lower_case(text))
		or (self.config.match_camel_case and self:camel_case(text))
		or (self.config.match_kebab_case and self:kebab_case(text))
		or (self.config.match_snake_case and self:snake_case(text))
end

function Match:match_number(text)
	-- if it doesn't contain a digit it isn't a number
	if not self:contains(text, "%d") then
		return false
	end

	return (self.config.match_integers and self:integer(text))
		or (self.config.match_floats and self:float(text))
		or (self.config.match_hex_strings and self:hex(text))
		or (self.config.match_binary_strings and self:binary(text))
end

function Match:match_path(text)
	if not self:contains(text, "/") then
		return false
	end

	return (self.config.match_urls and self:url(text))
		or (self.config.match_directories and self:directory(text))
		or (self.config.match_files and self:file(text))
		or (self.config.match_hidden_files and self:hidden_file(text))
end

function Match:match_computing(text)
	return (self.config.match_emails and self:email(text))
		or (self.config.match_ip_addrs and self:ip(text))
		or (self.config.match_uuids and self:uuid(text))
end

function Match:match(text)
	return (self.config.match_alphanumeric and self:alphanumeric(text))
		or self:match_word(text)
		or self:match_number(text)
		or self:match_path(text)
		or self:match_computing(text)
end

return Match
