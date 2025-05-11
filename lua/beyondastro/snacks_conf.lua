local map = vim.keymap.set

return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        -----------------------------------------------------------
        bigfile = {
            enabled = true,
            notify = true, -- show notification when big file detected
            size = 3.0 * 1024 * 1024, -- 1.5MB
        },
        -----------------------------------------------------------
        toggle = {
            map = vim.keymap.set, -- keymap.set function to use
            which_key = true, -- integrate with which-key to show enabled/disabled icons and colors
            notify = true, -- show a notification when toggling
            -- icons for enabled/disabled states
            icon = {
                enabled = " ",
                disabled = " ",
            },
            -- colors for enabled/disabled states
            color = {
                enabled = "green",
                disabled = "yellow",
            },
            wk_desc = {
                enabled = "Disable ",
                disabled = "Enable ",
            },
        },
        -----------------------------------------------------------
        dashboard = { enabled = false },
        -----------------------------------------------------------
        explorer = { enabled = false },
        -----------------------------------------------------------
        indent = {
            priority = 1,
            enabled = true, -- enable indent guides
            char = "│",
            only_scope = true, -- only show indent guides of the scope
            only_current = false, -- only show indent guides in the current window
            hl = "SnacksIndent", ---@type string|string[] hl groups for indent guides
            -- can be a list of hl groups to cycle through
            -- hl = {
            --     "SnacksIndent1",
            --     "SnacksIndent2",
            --     "SnacksIndent3",
            --     "SnacksIndent4",
            --     "SnacksIndent5",
            --     "SnacksIndent6",
            --     "SnacksIndent7",
            --     "SnacksIndent8",
            -- },
        },
        -- -- animate scopes. Enabled by default for Neovim >= 0.10
        -- -- Works on older versions but has to trigger redraws during animation.
        -- ---@class snacks.indent.animate: snacks.animate.Config
        -- ---@field enabled? boolean
        -- --- * out: animate outwards from the cursor
        -- --- * up: animate upwards from the cursor
        -- --- * down: animate downwards from the cursor
        -- --- * up_down: animate up or down based on the cursor position
        -- ---@field style? "out"|"up_down"|"down"|"up"
        animate = {
            enabled = vim.fn.has("nvim-0.10") == 1,
            easing = "quart",
            duration = {
                step = 200, -- ms per step
                total = 5000, -- maximum duration
            },
        },
        -----------------------------------------------------------
        input = { enabled = false },
        -----------------------------------------------------------
        picker = { enabled = false },
        -----------------------------------------------------------
        notifier = {
            enabled = true,
            config = function()
                -- local Snacks = require("Snacks");
                map("n", "<leader>nh", "<cmd>lua Snacks.notifier.show_history()<CR>", { desc = "Show Notification History" })
            end
        },
        -----------------------------------------------------------
        quickfile = { enabled = false },
        -----------------------------------------------------------
        scope = { enabled = false },
        -----------------------------------------------------------
        scroll = { enabled = false },
        -----------------------------------------------------------
        -- Focus on the active scope by dimming the rest.
        dim = {
            enabled = true,
            ---@type snacks.scope.Config
            scope = {
                min_size = 5,
                max_size = 20,
                siblings = true,
            },
            -- animate scopes. Enabled by default for Neovim >= 0.10
            -- Works on older versions but has to trigger redraws during animation.
            ---@type snacks.animate.Config|{enabled?: boolean}
            animate = {
                enabled = vim.fn.has("nvim-0.10") == 1,
                easing = "outQuad",
                duration = {
                    step = 20, -- ms per step
                    total = 300, -- maximum duration
                },
            },
            -- what buffers to dim
            filter = function(buf)
                return vim.g.snacks_dim ~= false and vim.b[buf].snacks_dim ~= false and vim.bo[buf].buftype == ""
            end,
        },
        -----------------------------------------------------------
        statuscolumn = {
            enabled = true,
            left = { "mark", "sign" }, -- priority of signs on the left (high to low)
            right = { "fold", "git" }, -- priority of signs on the right (high to low)
            folds = {
                open = false, -- show open fold icons
                git_hl = false, -- use Git Signs hl for fold icons
            },
            git = {
                -- patterns to match Git signs
                patterns = { "GitSign", "MiniDiffSign" },
            },
            refresh = 50, -- refresh at most every 50ms
        },
        -----------------------------------------------------------
        words = { enabled = false },
        -----------------------------------------------------------
        lazygit = { enabled = false },
        -----------------------------------------------------------
    },
    init = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                -- Setup some globals for debugging (lazy-loaded)
                _G.dd = function(...)
                    Snacks.debug.inspect(...)
                end
                _G.bt = function()
                    Snacks.debug.backtrace()
                end
                vim.print = _G.dd -- Override print to use snacks for `:=` command

                ------------------------------------------------------------------
                -- Create some toggle mappings
                
                -- dimming
                Snacks.toggle.dim():map("<leader>D")

            end,
        })
    end,
}
