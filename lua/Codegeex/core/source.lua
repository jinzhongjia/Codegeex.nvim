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
function source:get_position_encoding_kind()
	return "utf-16"
end

---Return the keyword pattern for triggering completion (optional).
---If this is ommited, nvim-cmp will use a default keyword pattern. See |cmp-config.completion.keyword_pattern|.
-- -@return string
-- function source:get_keyword_pattern()
-- 	return [[\k\+]]
-- end

---Return trigger characters for triggering completion (optional).
-- function source:get_trigger_characters()
-- 	return { "." }
-- end

---Invoke completion (required).
-- -@param params cmp.SourceCompletionApiParams
-- -@param callback fun(response: lsp.CompletionResponse|nil)
function source:complete(params, callback)
	local context = params.context
	local offset = params.offset
	local cursor = context.cursor
	local bufnr = context.bufnr
	local filetype = context.filetype or "text"

	local codes = vim.api.nvim_buf_get_text(bufnr, 1, 1, cursor.line, cursor.character,{})

	local lang = lib.util.filetype_to_lang(filetype)

	if lang == nil then
		return
	end
    request.request(codes, lang, function(prompts)
		local list = {{ label = 'January' },}
        for _, val in pairs(prompts) do
			-- this logic must be rewrited!!!!
			table.insert(list, {
				-- code
				type = 1,
				detail = val, --here is code
				-- this is header
				-- documentation = "January+documentation",
				-- this is body
				label = val,
				-- this is lable
				insertText = val,
				-- this inserttext
				cmp = {
					kind_text = "Suggestion",
					-- this is for kind_text
				},
			})
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
