local map = vim.keymap.set

------------------------------------------------------------------------------------------------------
-- GLOSSARY
-- <cmd> → special Neovim keyword that executes a command without polluting the command history
--      (introduced in Lua keymaps, cleaner than using :<command><CR>)
--
-- <CR> → means “press Enter” (Carriage Return), so the command actually runs
--
------------------------------------------------------------------------------------------------------

-- Automatic popup with shortcuts in Oil.nvim
vim.api.nvim_create_autocmd("FileType", {
    pattern = "oil",
    callback = function(ev)
    local lines = {
        "Oil.nvim shortcuts:",
        " <CR>   Open",
        " <C-s>  Open in vertical split",
        " <C-h>  Open in horizontal split",
        " <C-t>  Open in new tab",
        " <C-p>  Preview",
        " <C-c>  Close",
        " <C-l>  Refresh",
        " -      Go up one directory",
        " _      Open current working directory",
        " `      Change directory",
        " ~      Change directory (tab scope)",
        " gs     Change sort",
        " gx     Open external",
        " g.     Toggle hidden files",
        " g\\     Toggle trash",
        " g?     Show Other Shortcuts",
    }

    local width, height = 0, #lines
    for _, l in ipairs(lines) do width = math.max(width, #l) end

    local popup = require("snacks").win({
        text = lines,
        width = width,
        height = height,
        row = 1,
        col = vim.o.columns - width - 2,
        border = "rounded",
        style = "minimal",
        focusable = false,
        zindex = 20,     -- ✅ sits above, no blur
        backdrop = false -- ✅ disable blur/dim
    })

    -- close when leaving oil
    vim.api.nvim_create_autocmd("BufWinLeave", {
      buffer = ev.buf,
      once = true,
      callback = function() popup:close() end,
    })
    end,
})

-- Indent handling
-- describing groups in which-key (doing it after its lazy init)
vim.api.nvim_create_autocmd("User", {
    pattern = "LazyDone",
    callback = function()
        local wk = require("which-key")
        wk.add({
            { "<leader>s", group = "[S]earch/Incremental [S]election", mode={ "n", "v" } },
            { "<leader>p", group = "[P]roject Options" },
            { "<leader>d", group = "[D]iagnostics" },
            { "<leader>r", group = "Iron [R]epl (Python Jupyter)" },
            { "<leader>rs", group = "[S]end" },
            { "<leader>rm", group = "[M]ark" },
            { "<leader>rc", group = "[C]lear" },
            { "<leader>n", group = "[N]otification" },
            { "<leader>f", group = "[F]ind/Pickers (Snacks.nvim)" },
            { "<leader>dp", group = "Diagnostics picker" },
            { "<leader>g", group = "Git" },
        })
    end,
})

-- Diagnostics
map("n", '<leader>do', '<cmd>lua vim.diagnostic.open_float()<CR>', { desc="Open a floating diagnostic window" })
map("n", '<leader>d[', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { desc="Go to the next warning/error" })
map("n", '<leader>d]', '<cmd>lua vim.diagnostic.goto_next()<CR>', { desc="Go to previous warning/error" })
map("n", "<leader>dd", "<cmd>lua vim.diagnostic.setloclist()<CR>", { desc = "Open Diagnostics window below" })

map("v", "<Tab>", ">gv", { desc = "Increase indent of selection" })
map("v", "<S-Tab>", "<gv", { desc = "Decrease indent of selection" })

-- Crtl-S to save a file
map({"n", "i", "v"}, "<C-s>", "<cmd>w<CR><Esc>", { desc="Save your file" })

-- <leader>pv (project view) setting as Explorer(oil.nvim)
map("n", "<leader>pv", "<cmd>Oil<CR>", { desc = "Open Explorer [V]iew(Oil.nvim)" })

-- Select All to Ctrl-a
map({ "n", "i" }, "<C-a>", "<Esc>ggVG", { desc= "Select All" })

-- Ctrl-x in terminal to exit to terminal-Normal mode
map("t", "<C-x>", [[<C-\><C-n>]])

map({"n", "t"}, "<Esc><Esc>", "<cmd>noh<CR>", { desc = "Clear last search highlighting"} )

-- Explorer
map("n", "<leader>e", "<cmd>lua Snacks.explorer()<CR>", { desc = "Open Explorer" })

-- Tabs
map("n", "<C-Tab>", "<cmd>bnext<CR>", { desc = "Next Buffeer" })
map("n", "<C-S-Tab>", "<cmd>bprevious<CR>", { desc = "Previous Buffer" })

return {}

