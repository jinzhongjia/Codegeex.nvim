local M = {}

local core = require("Codegeex.core")
local config = require("Codegeex.config")

local initialized = false

M.setup = function(opt)
	if initialized then
		return
	end

	if opt then
		config.merge(opt)
	end

	core.init()
	initialized = true
end

return M
