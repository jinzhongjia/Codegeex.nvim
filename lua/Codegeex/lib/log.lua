local lsp, fn, api = vim.lsp, vim.fn, vim.api
local M = {}

local _notify_public_message = "[Codegeex]:"

M.Error = function(message)
	vim.schedule(function ()
		api.nvim_notify(_notify_public_message .. message, vim.log.levels.ERROR, {})
	end)
	
end

M.Info = function(message)
	vim.schedule(function ()
	api.nvim_notify(_notify_public_message .. message, vim.log.levels.INFO, {})
	end)
end

M.Warn = function(message)
	vim.schedule(function ()
	api.nvim_notify(_notify_public_message .. message, vim.log.levels.WARN, {})
	end)
end
return M
