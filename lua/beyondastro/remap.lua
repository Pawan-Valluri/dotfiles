local map = vim.keymap.set

------------------------------------------------------------------------------------------------------
-- GLOSSARY
-- <cmd> → special Neovim keyword that executes a command without polluting the command history
--      (introduced in Lua keymaps, cleaner than using :<command><CR>)
--
-- <CR> → means “press Enter” (Carriage Return), so the command actually runs
--
------------------------------------------------------------------------------------------------------

-- describing groups in which-key (doing it after its lazy init)
vim.api.nvim_create_autocmd("User", {
    pattern = "LazyDone",
    callback = function()
        local wk = require("which-key")
        wk.add({
            { "<leader>s", group = "Incremental [S]election", mode={ "n", "v" } },
            { "<leader>p", group = "[P]roject Options" },
        })
    end,
})

-- Indent handling
map("v", "<Tab>", ">gv", { desc = "Increase indent of selection" })
map("v", "<S-Tab>", "<gv", { desc = "Decrease indent of selection" })

-- Crtl-S to save a file
map({"n", "i", "v"}, "<C-s>", "<cmd>w<CR><Esc>", { desc="Save your file" })

-- <leader>pv (project view) setting as Explorer(netrw)
map("n", "<leader>pv", "<cmd>Ex<CR>", { desc = "Open Explorer [V]iew(netrw)" })

-- Select All to Ctrl-a
map({ "n", "i" }, "<C-a>", "<Esc>ggVG", { desc= "Select All" })

-- Ctrl-x in terminal to exit to terminal-Normal mode
map("t", "<C-x>", [[<C-\><C-n>]])

map({"n", "t"}, "<Esc><Esc>", "<cmd>noh<CR>", { desc = "Clear last search highlighting"} )

-- Explorer
map("n", "<leader>e", "<cmd>lua Snacks.explorer()<CR>", { desc = "Open Explorer" })

return {}

