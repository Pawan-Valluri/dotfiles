require "beyondastro.remap"

return {
	{	-- TreeSitter
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		config = function ()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"c", "lua", "vim", "vimdoc", "query", 
					"javascript", "html", "python",
				},
				auto_install = false,
				highlight = { enable = true },
				indent = { enable = true },
				incremental_highlight = {
					enable = true,
					keymaps = {},
				}
			})
			local map = vim.keymap.set
			local ts_inc = require "nvim-treesitter.incremental_selection"

			map({ "n", "v" }, "<leader>si", ts_inc.init_selection, { desc = "[I]nit Selection" })
			map({ "n", "v" }, "<leader>ss", ts_inc.node_incremental, { desc = "Node [S]elect/Increment" })
			map({ "n", "v" }, "<leader>sc", ts_inc.scope_incremental, { desc = "S[c]ope Increment" })
			map({ "n", "v" }, "<leader>sd", ts_inc.node_decremental, { desc = "Node [D]ecrement" })
		end,
	}
}

