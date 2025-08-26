
-- mapping leaderkey as spacebar
vim.g.mapleader = " "


local opt = vim.opt
local o = vim.o
-- local g = vim.g

-------------------------------------- options ------------------------------------------

o.clipboard = "unnamedplus"  --clipboard will be same as system's

-- Indenting
opt.expandtab = true -- Convert tabs to spaces
opt.shiftwidth = 4 -- Amount to indent with << and >>
opt.tabstop = 4 -- How many spaces are shown per Tab
opt.softtabstop = 4 -- How many spaces are applied when pressing Tab

opt.smarttab = true
opt.smartindent = true
opt.autoindent = true -- Keep identation from previous line

-- Show line under cursor
opt.cursorline = true

-- Store undos between sessions
opt.undofile = true

-- Enable mouse mode, can be useful for resizing splits for example!
opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
opt.showmode = false


-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 5

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"

opt.number = true
--opt.relativenumber = true
vim.diagnostic.config({ virtual_text = true })

