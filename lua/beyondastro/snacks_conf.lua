local map = vim.keymap.set


return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
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
                enabled = "󰔡",
                disabled = "󰨙",
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
        explorer = {
            enabled = true,
            opts = {
                replace_netrw = true, -- Replace netrw with the snacks explorer
            }
        },
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
        terminal = {
            enabled = false,
            -- win = { style = "floating" },
        },
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
        dashboard = {
            enabled = true,
            preset = {
                keys = {
                    { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
                    { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                    { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
                    { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
                    { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
                    { icon = " ", key = "s", desc = "Restore Session", section = "session" },
                    { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
                    { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                    { icon = "P ", key = "p", desc = "Project", action = "<cmd>ProjectPicker<CR>" },
                    { icon = "", key = "a", desc = "Add Project", action = "<cmd>WorkspacesAdd<CR>" },
                    { icon = "", key = "c", desc = "Commands Picker", action = ":lua Snacks.picker.commands()" },
                }
            }
        },
        -----------------------------------------------------------
        picker = {
            enabled = true,
            matcher = {
                frecency = true,
            },

        },
        -----------------------------------------------------------
    },
    keys = {
        -- Top Pickers & Explorer
        { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
        { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
        { "<leader>/", function() Snacks.picker.grep({
            prompt_title = "Grep in Working Directory",
            cwd = vim.fn.getcwd(),
        }
        ) end, desc = "Grep in Working Directory" },
        { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
        -- { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
        { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
        { "<leader>fa",function() Snacks.picker() end, desc = "All Pickers" },
        -- find
        { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
        { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
        { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
        { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
        { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
        { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
        -- git
        { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
        { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
        { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
        { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
        { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
        { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
        { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
        -- Grep
        { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
        { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
        { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
        { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
        -- search
        { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
        { '<leader>s/', function() Snacks.picker.search_history() end, desc = "Search History" },
        { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
        { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
        { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
        { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
        { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
        { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
        { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
        { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
        { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
        { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
        { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
        { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
        { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
        { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
        { "<leader>sp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
        { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
        { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
        { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
        -- { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
        -- LSP
        { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
        { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
        { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
        { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
        { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
        { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
        { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
        -- Diagnostics Picker
        { "<leader>dpw", function() Snacks.picker.diagnostics() end, desc = "Diagnostics picker for [W]orkspace" },
        { "<leader>dpb", function() Snacks.picker.diagnostics_buffer() end, desc = "Diagnostics pickerfor current buffer" },
    },
    init = function()

        vim.api.nvim_create_user_command('ProjectPicker', function()
            local items = {}
            local longest_name = 0
            for i, workspace in ipairs(require('workspaces').get()) do
                table.insert(items, {
                    idx = i,
                    score = i,
                    text = workspace.path,
                    name = workspace.name,
                })
                longest_name = math.max(longest_name, #workspace.name)
            end
            longest_name = longest_name + 2
            return Snacks.picker({
                items = items,
                format = function(item)
                    local ret = {}
                    ret[#ret + 1] = { ('%-' .. longest_name .. 's'):format(item.name), 'SnacksPickerLabel' }
                    ret[#ret + 1] = { item.text, 'SnacksPickerComment' }
                    return ret
                end,
                confirm = function(picker, item)
                    picker:close()
                    vim.cmd(('WorkspacesOpen %s'):format(item.name))
                    vim.cmd(('lua Snacks.explorer()'))
                end,
            })
        end, {})

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
                ------------------------------------------------------------------
                -- dimming
                Snacks.toggle.dim():map("<leader>D")
                -- Terminal
                -- map('n', "<C-t>", Snacks.terminal.toggle(), { desc = "Terminal Toggle" })
            end,
        })

        vim.keymap.set('n', '<Leader>pc', "<cmd>ProjectPicker<CR>", { desc = "[C]hange Project" })
    end,
}
