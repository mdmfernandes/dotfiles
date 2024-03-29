-- Count unique lines
local F = {}

function F.format(lines)
    local counts = {}
    local unique_lines = {}

    -- Count occurrences of each line
    for _, line in ipairs(lines) do
        if counts[line] then
            counts[line] = counts[line] + 1
        else
            counts[line] = 1
            table.insert(unique_lines, line)
        end
    end

    -- Prepend the count to each line
    local result_lines = {}
    for _, line in ipairs(unique_lines) do
        table.insert(result_lines, counts[line] .. " " .. line)
    end

    -- Sort lines by count (descending)
    table.sort(result_lines, function(a, b) return a > b end)

    return result_lines
end

return F
