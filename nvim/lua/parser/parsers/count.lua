-- Count unique lines
local P = {}

function P.parse(lines)
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
        table.insert(result_lines, { number = counts[line], text = line })
    end

    -- Sort lines by count (descending)
    table.sort(result_lines, function(a, b) return a.number > b.number end)

    local sorted_lines = {}
    for _, line in ipairs(result_lines) do
        table.insert(sorted_lines, line.number .. " " .. line.text)
    end

    return sorted_lines
end

return P
