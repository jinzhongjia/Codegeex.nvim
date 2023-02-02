# Codegeex.nvim

this is cmp source for codegeex

# Dependences

- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)


# Note

> Since the default request logic of cmp is to complete the request when the first continuous string is entered, all codegeex cannot obtain the subsequent character input, resulting in poor completion effect

# Install

lazy.nvim

```lua
{
	"jinzhongjia/Codegeex.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
        -- here is default config
		require("Codegeex").setup({
			debug = false,
			server = {
				url = "https://tianqi.aminer.cn/api/v2/multilingual_code_generate",
				apikey = "",
				apisecret = "",
				num = 5,
			},
		})
	end,
}
```