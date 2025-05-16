-- This script is used only for configuring GUI clients for neovim

local g = vim.g

-- Setup for Neovide as gui
if vim.g.neovide then
    vim.o.guifont = "Operator-caska:h11"
    g.neovide_fullscreen = 1
    -- g.neovide_title_hidden = true
end
-- add other gui options here as extentions to the if-else ladder

