-- Editor options
local o = vim.opt

-------------
-- General --
-------------
o.updatetime = 250 -- Refresh time
-- o.hidden = true  -- Do not save when switching buffers
o.history = 50 -- Command line history
o.clipboard = "unnamedplus"
-- Better buffer splitting
o.splitright = true
o.splitbelow = true
o.completeopt = { "menu", "menuone", "noselect" }

-------------
-- Display --
-------------
o.termguicolors = true -- GUI colors
-- o.showcmd = true       -- Show commands on bottom right corner
o.number = true
o.relativenumber = true
o.scrolloff = 10 -- Show at least 10 lines above/below the cursor
o.cursorline = true
o.signcolumn = "yes"
o.showmatch = true -- When a bracket is inserted, briefly jump to the matching one
o.cmdheight = 0 -- Don't show the cmdline

-- Empty characters
-- o.list = true
--o.listchars = "eol:¬"

------------
-- Editor --
------------
-- Indentation
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.shiftround = true
o.expandtab = true
-- Line wrapping
o.wrap = true
o.linebreak = true
o.showbreak = "▶"

------------
-- Search --
------------
o.ignorecase = true
o.smartcase = true
o.hlsearch = true
o.inccommand = "nosplit" -- Live highlight substitutions

-------------------
-- Swap & Backup --
-------------------
o.backup = false
o.undofile = true
o.swapfile = false

--------------------
-- Spell Checking --
--------------------
o.spelllang = "en,pt_pt"
o.spellsuggest = "10"
