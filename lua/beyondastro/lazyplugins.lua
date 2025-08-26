local map = vim.keymap.set

return {
    {
        'mg979/vim-visual-multi',
        branch = "master",
        lazy = false,
    },

    {	-- toggles linenums to releative in normal mode
        "sitiom/nvim-numbertoggle",
        lazy = false,
    },

    {	-- A keybinding helper plugin
        "folke/which-key.nvim",
        -- event = "VeryLazy",
        lazy = false,
        opts = {
            preset = 'helix',
        },
        keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
        -- config = require("beyondastro.remap").whichkey_extras
    },

    {
        "natecraddock/workspaces.nvim",
        config = function()
            require("workspaces").setup()
        end,
    },

    {
        'stevearc/oil.nvim',
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {
            -- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
            delete_to_trash = true,
            -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
            skip_confirm_for_simple_edits = true,
            keymaps = {
                ["g?"] = { "actions.show_help", mode = "n" },
                ["<CR>"] = "actions.select",
                ["<C-s>"] = { "actions.select", opts = { vertical = true } },
                ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
                ["<C-t>"] = { "actions.select", opts = { tab = true } },
                ["<C-p>"] = "actions.preview",
                ["<C-c>"] = { "actions.close", mode = "n" },
                ["<C-l>"] = "actions.refresh",
                ["-"] = { "actions.parent", mode = "n" },
                ["_"] = { "actions.open_cwd", mode = "n" },
                ["`"] = { "actions.cd", mode = "n" },
                ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
                ["gs"] = { "actions.change_sort", mode = "n" },
                ["gx"] = "actions.open_external",
                ["g."] = { "actions.toggle_hidden", mode = "n" },
                ["g\\"] = { "actions.toggle_trash", mode = "n" },
            },

            view_options = {
                -- Show files and directories that start with "."
                show_hidden = true,
            },
            -- Optional dependencies
            -- dependencies = { { "echasnovski/mini.icons", opts = {} } },
            dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
            -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
            lazy = false,
        },
    },

    {	-- LSP Manager/Installer
        "mason-org/mason.nvim",
        version = "1.11.0",
        config = function()
            require("mason").setup()
        end
    },

    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                -- Add your plugin folders here
                vim.fn.stdpath("config") .. "/lua/beyondastro",
            },
        },
        -- config = function()
        --     require("lazydev").setup()
        -- end,
    },

    {	-- Config for Mason(LSP Manager)
        "mason-org/mason-lspconfig.nvim",
        version = "1.32.0",
        dependencies = { "mason.nvim" },
        config = function()
            require("mason-lspconfig")
            require("mason-lspconfig").setup_handlers({
                function(servername)
                    require("lspconfig")[servername].setup({})
                end,
            })
        end,
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "mason-lspconfig.nvim",
            "lazydev.nvim",
        },
        -- opts = {
        --     servers = {
        --         lua_ls = {
        --             settings = {
        --                 Lua = {
        --                     runtime = {
        --                         version = "LuaJIT",
        --                         path = vim.split(package.path, ";"),
        --                     },
        --                     diagnostics = {
        --                         globals = { "vim" },
        --                     },
        --                     workspace = {
        --                         checkThirdParty = false,
        --                         library = {
        --                             vim.env.VIMRUNTIME,
        --                             vim.fn.stdpath("config") .. "/lua",
        --                             vim.fn.stdpath("config") .. "/lua/beyondastro", -- Your plugin code
        --                         },
        --                     },
        --                     telemetry = {
        --                         enable = false,
        --                     },
        --                 },
        --             },
        --         },
        --     },
        -- },
    },

    {   -- Statusline
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "night-owl",
                    -- Other separator symbols:
                    -- █
                    --   
                    --   
                    --   
                    --   
                    --   
                },
                sections = {
                    lualine_c = { '%f' },
                    lualine_x = {
                        function()
                            return os.date(" %d/%m/%Y")
                        end,
                        function()
                            return os.date("󱑀 %-I:%02M %p")
                        end,
                        function()
                            return vim.cmd("<cmd>echo $VIRTUAL_ENV<CR>")
                        end,
                    },
                }
            })
        end
    },

    -- {	-- Statusline
    -- 	'echasnovski/mini.statusline',
    -- 	version = '*',
    -- 	config = function()
    -- 		require("mini.statusline").setup()
    -- 	end,
    -- },

    {   -- Commenting support
        'numToStr/Comment.nvim',
        config = function()
            require("Comment").setup({
                padding = true,
            })
        end,
    },

    {   -- Togglable floating terminal
        'akinsho/toggleterm.nvim',
        version = "*",
        config = function()
            require("toggleterm").setup({
                size = 80,
                open_mapping = [[<C-\>]],
                direction = "float",
                shade_terminals = true,
                shade_filetypes = {},
                persist_size = true,
                shading_factor = 2,
                insert_mappings = true,
                start_in_insert = true,
                float_opts = {
                    border = "curved",
                    winblend = 0,
                    highlights = {
                        border = "Normal",
                        background = "Normal",
                    }
                }
            })
        end,
    },

    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            vim.opt.termguicolors = true,
            require("bufferline").setup({})
        end
    },

    {   -- Python Virtual Environment Selector
        "linux-cultist/venv-selector.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "mfussenegger/nvim-dap", "mfussenegger/nvim-dap-python", --optional
            { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
        },
        lazy = false,
        branch = "regexp", -- This is the regexp branch, use this for the new version
        -- keys = {
        --     { ",v", "<cmd>VenvSelect<cr>" },
        -- },
        config = function()
            map("n", ",v", "<cmd>VenvSelect<CR>", { desc = "Virual Environment Selector(python)" })
            require("venv-selector").setup({
                notify_user_on_venv_activation = true,
                enable_default_searches = false,
                search = {
                    my_venvs = {
                        command = "fd '/bin/python$' /home/beyond/Space/envs --full-path --color never -E /proc -I -a -L"
                    },
                },
            })
        end,
        opts = {
            -- Your settings go here
        },
    },

    -- {    -- Forces you to use nvim the way it is intended
    --     "m4xshen/hardtime.nvim",
    --     lazy = false,
    --     dependencies = { "MunifTanjim/nui.nvim" },
    --     opts = {},
    -- },

    {
        -- Typing practice/test
        "nvzone/typr",
        dependencies = "nvzone/volt",
        opts = {},
        cmd = { "Typr", "TyprStats" },
    },
}

