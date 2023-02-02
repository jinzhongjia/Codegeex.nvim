local request = require("Codegeex.core.request")
local lib = require("Codegeex.lib")
local source = {}

---Return whether this source is available in the current context or not (optional).
-- -@return boolean
function source:is_available()
	return true
end

---Return the debug name of this source (optional).
-- -@return string
-- function source:get_debug_name()
-- 	return "debug name"
-- end

---Return LSP's PositionEncodingKind.
-- -@NOTE: If this method is ommited, the default value will be `utf-16`.
-- -@return lsp.PositionEncodingKind
-- function source:get_position_encoding_kind()
-- 	return "utf-16"
-- end

---Return the keyword pattern for triggering completion (optional).
---If this is ommited, nvim-cmp will use a default keyword pattern. See |cmp-config.completion.keyword_pattern|.
-- -@return string
-- function source:get_keyword_pattern()
-- 	return [[\k\+]]
-- end

---Return trigger characters for triggering completion (optional).
-- function source:get_trigger_characters()
-- 	return { "*" }
-- end

local function filter(content)
	local contents = vim.split(content, "\n")
	for _, val in pairs(contents) do
		if string.gsub(val, " ", "") ~= "" then
			return true
		end
	end

	return false
end

---Invoke completion (required).
-- -@param params cmp.SourceCompletionApiParams
-- -@param callback fun(response: lsp.CompletionResponse|nil)
function source:complete(params, callback)
	local context = params.context
	local offset = params.offset
	local cursor = context.cursor
	local bufnr = context.bufnr
	local filetype = context.filetype or "text"

	local input = string.sub(params.context.cursor_before_line, params.offset - 1)
	local prefix = string.sub(params.context.cursor_before_line, 1, params.offset - 1)

	local codes = vim.api.nvim_buf_get_text(bufnr, 0, 0, cursor.line, cursor.character, {})

	local lang = lib.util.filetype_to_lang(filetype)

	if lang == nil then
		return
	end
	request.request(codes, lang, function(prompts)
		local list = {}
		-- lib.util.debug(prompts)
		for _, val in pairs(prompts) do
			-- this logic must be rewrited!!!!
			if filter(val) then
				table.insert(list, {
					-- code
					filterText = lib.util.get_label(params.context.cursor_before_line),
					-- type = 1,
					detail = val, --here is code
					-- this is header
					-- documentation = "January+documentation",
					-- this is body
					label = lib.util.get_label(val),
					-- this is lable
					insertText = val,
					-- this inserttext
					cmp = {
						kind_text = "Suggestion",
						-- this is for kind_text
					},
				})
			end
		end
		callback(list)
	end)
end

---Resolve completion item (optional). This is called right before the completion is about to be displayed.
---Useful for setting the text shown in the documentation window (`completion_item.documentation`).
-- -@param completion_item lsp.CompletionItem
-- -@param callback fun(completion_item: lsp.CompletionItem|nil)
-- function source:resolve(completion_item, callback)
-- 	callback(completion_item)
-- end

---Executed after the item was selected.
-- -@param completion_item lsp.CompletionItem
-- -@param callback fun(completion_item: lsp.CompletionItem|nil)
function source:execute(completion_item, callback)
	-- callback(completion_item)
end

local M = {}

M.init = function()
	---Register your source to nvim-cmp.
	require("cmp").register_source("Codegeex", source)
end

return M
