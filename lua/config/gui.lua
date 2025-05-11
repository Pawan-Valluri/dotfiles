-- This script is used only for configuring GUI clients for neovim

-- Setup for Neovide as gui
if vim.g.neovide then
    vim.o.guifont = "Operator-caska:h14"
    vim.g.neovide_fullscreen = 1
end
-- add other gui options here as extentions to the if-else ladder

