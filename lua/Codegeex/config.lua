local M = {}

M.options = {
	debug = false,
	server = {
		url = "https://tianqi.aminer.cn/api/v2/multilingual_code_generate",
		apikey = "68cf004321e94b47a91c2e45a8109852",
		apisecret = "e82b86a16f9d471ab215f653060310e3",
		num = 5,
	},
}

M.merge = function(param)
	vim.tbl_deep_extend("force", M.options, param)
end

return M
