return {
	{
		{
			"oxfist/night-owl.nvim",
			lazy = false, -- make sure we load this during startup if it is your main colorscheme
			priority = 1000, -- make sure to load this before all the other start plugins
			config = function()
				-- load the colorscheme here
				require("night-owl").setup({
                    -- These are the default settings
                    bold = true,
                    italics = true,
                    underline = true,
                    undercurl = true,
                    transparent_background = false,
                })
				vim.cmd.colorscheme("night-owl")
			end,
		}
	},
	-- {
	-- 	'sainnhe/gruvbox-material',
	-- 	lazy = true,
	-- 	priority = 100,
	-- 	config = function()
	-- 		-- Optionally configure and load the colorscheme
	-- 		-- directly inside the plugin declaration.
	-- 		vim.g.gruvbox_material_enable_italic = true
	-- 		vim.cmd.colorscheme('gruvbox-material')
	-- 	end
	-- },
    -- {
    --	"neanias/everforest-nvim",
    --	version = true,
    --	lazy = false,
    --	priority = 1000, -- make sure to load this before all the other start plugins
    --	-- Optional; default configuration will be used if setup isn't called.
    --	config = function()
    --		require("everforest").setup({
    --	    	-- Your config here
    --		})
    --	end,
    -- },
}
