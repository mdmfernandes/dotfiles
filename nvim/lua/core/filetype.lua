-- File types
-- Ref.: https://gpanders.com/blog/whats-new-in-neovim-0-7/#filetypelua

vim.filetype.add({
    extension = {
        service = "systemd",
        socket = "systemd",
        target = "systemd",
        log = "log",
        _log = "log",
        LOG = "log",
        _LOG = "log",
    },
    filename = {
        ["docker-compose.yml"] = "yaml.docker-compose",
        ["docker-compose.yaml"] = "yaml.docker-compose"
    },
    pattern = {
        -- Improve detection of *.inc files
        [".*%.inc"] = {
            priority = vim.g.filetype_inc,
            function(path, bufnr)
                local content = vim.api.nvim_buf_get_lines(bufnr, 0, 50, false)
                for _, line in ipairs(content) do
                    --  Detect BitBake files by the presence of ".*:append =" or ".*:remove ="
                    if line:match(":append =") or line:match(":remove =") then
                        return "bitbake"
                    end
                end
            end
        }
    }
})
