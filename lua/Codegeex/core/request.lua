local lsp, fn, api = vim.lsp, vim.fn, vim.api
local lib = require("Codegeex.lib")

local config = require("Codegeex.config").options

local M = {}

M.request = function(prompt, language, callback)
	local body = vim.json.encode({
		prompt = prompt, -- this is context
		n = config.server.num, -- this is the result number
		lang = language,
		apikey = config.server.apikey,
		apisecret = config.server.apisecret,
	})
	lib.curl.post(config.server.url, {
		body = body,
		headers = {
			content_type = "application/json",
		},
		callback = function(res)
			if res.exit ~= 0 then
				lib.log.Error("request failed, Maybe your network has problem!\n" .. "Output:" .. res.body)
				return
			end
			if config.debug then
				lib.util.debug(res)
			end
			if res.status == 200 then
				local data = vim.json.decode(res.body)
				callback(data.result.output.code)
			else
				lib.log.Warn("request failed, Please check you server config!")
			end
		end,
	})
end

return M
