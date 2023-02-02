local M = {}

M.options = {
	debug = false,
	server = {
		url = "https://tianqi.aminer.cn/api/v2/multilingual_code_generate",
		apikey = "",
		apisecret = "",
		num = 5,
	},
}

M.merge = function(param)
	vim.tbl_deep_extend("force", M.options, param)
end

return M
