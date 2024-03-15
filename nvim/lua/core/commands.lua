-- User commands

-- Format current buffer with the provided formatter
vim.api.nvim_buf_create_user_command(0, "Format",
    function(opts)
        local formatter = opts.fargs[1] -- Formatter is provided in the first argument

        if formatter == "help" then
            vim.notify("Available formatters: sort, violations", vim.log.levels.INFO)
            return
        end

        vim.notify(string.format("Formatting with '%s'", formatter), vim.log.levels.INFO)

        -- Get all lines in the current buffer
        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

        -- Sort the lines uniquely
        if formatter == "sort" then
            table.sort(lines)
            lines = vim.fn.uniq(lines)
        end

        -- Format violations (remove garbage and duplicates)
        if formatter == "violations" then
            for i, line in ipairs(lines) do
                -- Simplify lines starting with "...avc:" to just "avc:"
                lines[i] = line:gsub("^.*avc:", "avc:")
                -- Remove digits from "pid"
                lines[i] = lines[i]:gsub("pid=%d*", "pid=")
            end

            -- Sort the lines uniquely
            table.sort(lines)
            lines = vim.fn.uniq(lines)
        end

        -- Add more formatters below!
        -- <formatter>

        -- Set the modified lines back into the buffer
        vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    end,
    { nargs = 1 })
