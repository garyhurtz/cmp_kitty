local Match = {}
local cmp = require("cmp")

Match.new = function(config)
    local inst = {
        config = config,
    }

    setmetatable(inst, { __index = Match })

    return inst
end

function Match:contains(text, c)
    return (text:find(c) ~= nil) or (text:match(c) ~= nil)
end

function Match:startswith(text, c)
    return text:sub(1, #c) == c
end

function Match:endswith(text, c)
    return c == "" or text:sub(- #c) == c
end

function Match:word(obj)
    if obj.label:match("^%a+$") ~= nil then
        obj.kind = cmp.lsp.CompletionItemKind.Text
        return obj
    end
end

function Match:word_with_punctuation(obj)
    local match = obj.label:match("^(%a+)%p$")

    if match ~= nil then
        obj.label = match
        obj.kind = cmp.lsp.CompletionItemKind.Text
        return obj
    end
end

function Match:upper_case(obj)
    if obj.label:match("^%u+$") ~= nil then
        obj.kind = cmp.lsp.CompletionItemKind.Text
        return obj
    end
end

function Match:lower_case(obj)
    if obj.label:match("^%l+$") ~= nil then
        obj.kind = cmp.lsp.CompletionItemKind.Text
        return obj
    end
end

function Match:capitalized(obj)
    if obj.label:match("^%u%l+$") ~= nil then
        obj.kind = cmp.lsp.CompletionItemKind.Text
        return obj
    end
end

function Match:kebab_case(obj)
    if (obj.label:match("^%a[%a-]+%a$") ~= nil) and self:contains(obj.label, "-") then
        obj.kind = cmp.lsp.CompletionItemKind.Text
        return obj
    end
end

function Match:snake_case(obj)
    if (obj.label:match("^%a[%a_]+%a$") ~= nil) and self:contains(obj.label, "_") then
        obj.kind = cmp.lsp.CompletionItemKind.Text
        return obj
    end
end

function Match:camel_case(obj)
    if obj.label:match("^%u?%l+%u%l[%u%l]*$") ~= nil then
        obj.kind = cmp.lsp.CompletionItemKind.Text
        return obj
    end
end

function Match:alphanumeric(obj)
    if
        (obj.label:match("^%w+$") ~= nil)
        -- must have at least one letter and one digit
        and self:contains(obj.label, "%a")
        and self:contains(obj.label, "%d")
    then
        obj.kind = cmp.lsp.CompletionItemKind.Text
        return obj
    end
end

function Match:integer(obj)
    if obj.label:match("^[+-]?%d+$") ~= nil then
        obj.kind = cmp.lsp.CompletionItemKind.Value
        return obj
    end
end

function Match:float(obj)
    if obj.label:match("^[+-]?%d+[.]%d+$") ~= nil then
        obj.kind = cmp.lsp.CompletionItemKind.Value
        return obj
    end
end

function Match:hex(obj)
    if (obj.label:match("^#?%x+$") ~= nil) or (obj.label:match("^0x%x+$") ~= nil) then
        obj.kind = cmp.lsp.CompletionItemKind.Value
        return obj
    end
end

function Match:binary(obj)
    if #obj.label >= 4 and (obj.label:match("^[01]+$") ~= nil) then
        obj.kind = cmp.lsp.CompletionItemKind.Value
        return obj
    end
end

function Match:email(obj)
    if obj.label:match("^[%w%._-]+@[%w_-]+%.[%a%d]+") ~= nil then
        obj.kind = cmp.lsp.CompletionItemKind.Text
        return obj
    end
end

function Match:url(obj)
    for _, scheme in ipairs(self.config.match_urls) do
        if obj.label:match("^"..scheme .."://[%w-]+%.%w+") ~= nil then
            obj.kind = cmp.lsp.CompletionItemKind.Text
            return obj
        end
    end
end

function Match:ip(obj)
    if obj.label:match("^%d+%.%d+%.%d+%.%d+") ~= nil then
        obj.kind = cmp.lsp.CompletionItemKind.Value
        return obj
    end
end

function Match:uuid(obj)
    if obj.label:match("%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x") ~= nil then
        obj.kind = cmp.lsp.CompletionItemKind.Value
        return obj
    end
end

function Match:directory(obj)
    if
        obj.label:match("^~/[%w_/-]+/?$") ~= nil
        or (
        obj.label:match("^/?[%w_/-]+/?$") ~= nil
        and (self:startswith(obj.label, "/") or self:endswith(obj.label, "/"))
        )
    then
        obj.kind = cmp.lsp.CompletionItemKind.Folder
        return obj
    end
end

function Match:file(obj)
    if
        obj.label:match("^~/[%w_/-]+/[%w_-]+%.%w+$") ~= nil
        or obj.label:match("^/?[%w_/-]+/[%w_-]+%.%w+$") ~= nil
        or obj.label:match("^/?[%w_-]+%.%w+$") ~= nil
    then
        obj.kind = cmp.lsp.CompletionItemKind.File
        return obj
    end
end

function Match:file_by_suffix(obj)
    for _, suffix in ipairs(self.config.match_files_by_suffix) do
        if obj.label:match("%." .. suffix .. "$") then
            obj.kind = cmp.lsp.CompletionItemKind.File
            return obj
        end
    end
end

function Match:hidden_file(obj)
    if
        obj.label:match("^~/[%w_/-]+/%.[%w_-]+%.%w+$") ~= nil
        or obj.label:match("^/?[%w_/-]+/%.[%w_-]+%.%w+$") ~= nil
        or obj.label:match("^/?%.[%w_-]+%.%w+$") ~= nil
    then
        obj.kind = cmp.lsp.CompletionItemKind.File
        return obj
    end
end

function Match:match_text(obj)
    -- if it doesn't contain a letter it isn't a word
    if not self:contains(obj.label, "%a") then
        return
    end

    return (self.config.match_words and self:word(obj))
        or (self.config.match_words_with_punctuation and self:word_with_punctuation(obj))
        or (self.config.match_upper_case and self:upper_case(obj))
        or (self.config.match_lower_case and self:lower_case(obj))
        or (self.config.match_camel_case and self:camel_case(obj))
        or (self.config.match_kebab_case and self:kebab_case(obj))
        or (self.config.match_snake_case and self:snake_case(obj))
end

function Match:match_number(obj)
    -- if it doesn't contain a digit it isn't a number
    if not self:contains(obj.label, "%d") then
        return
    end

    return (self.config.match_integers and self:integer(obj))
        or (self.config.match_floats and self:float(obj))
        or (self.config.match_hex_strings and self:hex(obj))
        or (self.config.match_binary_strings and self:binary(obj))
end

function Match:match_path(obj)
    if not self:contains(obj.label, "/") then
        return
    end

    return (next(self.config.match_urls) ~= nil and self:url(obj))
        or (next(self.config.match_files_by_suffix) ~= nil and self:file_by_suffix(obj))
        or (self.config.match_directories and self:directory(obj))
        or (self.config.match_files and self:file(obj))
        or (self.config.match_hidden_files and self:hidden_file(obj))
end

function Match:match_computing(obj)
    return (self.config.match_emails and self:email(obj))
        or (self.config.match_ip_addrs and self:ip(obj))
        or (self.config.match_uuids and self:uuid(obj))
end

function Match:match(obj)
    return (self.config.match_alphanumeric and self:alphanumeric(obj))
        or self:match_text(obj)
        or self:match_number(obj)
        or self:match_path(obj)
        or self:match_computing(obj)
end

return Match
