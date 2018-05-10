--
-- For help with Hammerspoon, load the doc module. [Isaac Virshup 5:12 PM Jul 12, 2015]
-- Values can be accesed like keys, has documentation for everything
--
-- doc = hs.doc.fromJSONFile(hs.docstrings_json_file) # No longer works [Isaac Virshup 12:30 PM May 8, 2017]


-- Where I link in practice files:
--require("window_movement") -- [Isaac Virshup 2:55 PM Jul 12, 2015]
--require("profiles") -- [Isaac Virshup 1:29 AM Jul 22, 2015]
require("window_manager")

--
-- Turn off Animations.
--
hs.window.animationDuration = 0


-- Pretty printing for tables
function show(tbl)
  return hs.inspect.inspect(tbl)
end

-- Reload this config.
function reload_config()
  hs.application.launchOrFocus("Hammerspoon")
  local hsapp = hs.appfinder.appFromName("Hammerspoon")
  local cmd = {"File", "Reload Config"}
  hsapp:selectMenuItem(cmd)
end
hs.hotkey.bind({"ctrl", "command"}, "r", reload_config)
