-- https://yazi-rs.github.io/docs/tips

-- Show symlink in status bar
Status:children_add(function(self)
    local h = self._current.hovered
    if h and h.link_to then
        return " -> " .. tostring(h.link_to)
    else
        return ""
    end
end, 3300, Status.LEFT)

-- Show file/dir owner in status bar
Status:children_add(function()
    local h = cx.active.current.hovered
    if h == nil or ya.target_family() ~= "unix" then
        return ""
    end

    return ui.Line({
        ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
        ":",
        ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
        " ",
    })
end, 500, Status.RIGHT)

-- Full-border: https://github.com/yazi-rs/plugins/tree/main/full-border.yazi
require("full-border"):setup()

-- Git: https://github.com/yazi-rs/plugins/tree/main/git.yazi
require("git"):setup()
