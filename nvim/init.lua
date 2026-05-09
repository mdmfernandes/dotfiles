--   ____    ____  ________
--  |_   \  /   _||_   __  |
--    |   \/   |    | |_ \_|    Miguel Fernandes
--    | |\  /| |    |  _|       https://github.com/mdmfernandes
--   _| |_\/_| |_  _| |_
--  |_____||_____||_____|

-- Load core configurations
require("vim._core.ui2").enable() -- Experimental UI
require("core.options")
require("core.mappings")
require("core.commands")
require("core.diagnostic")
require("core.filetype")
require("core.autocmd")

-- Load LSP
require("lsp")
