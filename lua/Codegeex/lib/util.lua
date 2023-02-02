local M = {}

local emun = require("Codegeex.lib.enum")
M.debug = function(...)
	local date = os.date("%Y-%m-%d %H:%M:%S")
	local args = { ... }
	for _, value in pairs(args) do
		print(date, vim.inspect(value))
	end
end

M.get_newline = function(bufnr)
	return emun.line_endings[vim.api.nvim_buf_get_option(bufnr, "fileformat")] or "\n"
end

M.filetype_to_lang = function(filetype)
	return emun.fileType[filetype] or nil
end

M.get_label = function(content)
	local contents = vim.split(content, "\n")
	for key, value in pairs(contents) do
		if string.gsub(value, " ", "") ~= "" then
			return M.ltrim(value)
		end
    end
	return ""
end

-- trim whitespace from heading and trailing
M.ltrim = function(str)
	return string.match(str, "^%s*(.*)")
end

return M
