-- Rebind alt-` to switch me

-- Trying to make it faster
-- log = hs.logger.new("infologger", "verbose")
-- local wf = hs.window.filter.new():setOverrideFilter{visible=true}
-- switcher = hs.window.switcher.new(wf, nil, "infologger", "info")

switcher = hs.window.switcher.new()
-- switcher = require("switcher").new()
-- show(switcher)

hs.hotkey.bind('alt', '`', nil, function()switcher:next()end, nil, function()switcher:next()end)
hs.hotkey.bind('shift-alt', '`', nil, function()switcher:previous()end, nil, function()switcher:previous()end)
