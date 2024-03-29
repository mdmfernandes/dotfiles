-- Format SELinux logs
local F = {}

function F.format(lines)
    for i, line in ipairs(lines) do
        -- Simplify lines starting with "...avc:" to just "avc:"
        lines[i] = line:gsub("^.*avc:", "avc:")
        -- Remove digits from "pid"
        lines[i] = lines[i]:gsub("pid=%d*", "pid=")
    end

    return lines
end

return F
