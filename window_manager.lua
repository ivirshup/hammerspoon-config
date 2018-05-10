-- Global State
saved = {side="r"}
saved.win = {}
saved.winFrame = {}
-- save.dir = "" -- what window size was last moved


-- Gets window/ screen data.
function enter_window()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  saved.win = win
  saved.winFrame = saved.win:frame()
  return win, f, screen, max
end

-- Slides window to specified side of screen
-- @param dir Direction identification string
--------------------
function slide(dir)
  local win, f, screen, max = enter_window()
  if dir == 'r' or dir == 'right' then
    f.x = max.x + max.w - f.w
  elseif dir == 'l' or dir == 'left' then
    f.x = max.x
  elseif dir == 'u' or dir =='up' then
    f.y = max.y
  elseif dir == 'd' or dir == 'down' then
    f.y = max.y + max.h - f.h
  end
  -- Move window
  win:setFrame(f)
  return win
end

-- Extends window in specified direction
-- @param dir Direction identification string
function extend(dir)
  local win, f, screen, max = enter_window()
  -- Switch statement
  if dir == 'r' or dir == 'right' then
    f.w = max.x + max.w - f.x
  elseif dir == 'l' or dir == 'left' then
    f.w = f.x + f.w - max.x
    f.x = max.x
  elseif dir == 'u' or dir =='up' then
    f.h = f.y + f.h - max.y
    f.y = max.y
  elseif dir == 'd' or dir == 'down' then
    f.h = max.y + max.h - f.y
  end
  -- Move window
  win:setFrame(f)
  return win -- f, screen, max
end

function left_half()
  local win, f, screen, max = enter_window()
  f = max_frame(f,max)
  f.w = max.w /2
  win:setFrame(f)
  return win, f
end

function right_half()
  local win, f, screen, max = enter_window()
  f = max_frame(f,max)
  f.x = max.x + (max.w / 2)
  f.w = max.w /2
  win:setFrame(f)
  return win
end

function top_half()
  local win, f, screen, max = enter_window()
  f = max_frame(f,max)
  f.h = max.h / 2
  win:setFrame(f)
  return win
end

function bottom_half()
  local win, f, screen, max = enter_window()
  f = max_frame(f,max)
  f.y = (max.h -23) /2 + 23
  f.h = max.h / 2
  win:setFrame(f)
  return win
end

function left_thirds()
  local win, f, screen, max = enter_window()
  f = max_frame(f,max)
  f.x = max.x
  f.w =  max.w * 2 / 3
  win:setFrame(f)
  return win
end

function right_thirds()
  local win, f, screen, max = enter_window()
  f = max_frame(f,max)
  f.x = max.x + (max.w / 3)
  f.w =  max.w * 2 / 3
  win:setFrame(f)
  return win
end

function left_third()
  local win, f, screen, max = enter_window()
  f = max_frame(f,max)
  f.x = max.x
  f.w =  max.w * 1/3
  win:setFrame(f)
  return win
end

function right_third()
  local win, f, screen, max = enter_window()
  f = max_frame(f,max)
  f.x = max.x + (max.w * 2/3)
  f.w =  max.w * 1/3
  win:setFrame(f)
  return win
end

function max_frame(f, max)
  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h
  return f
end

-- Selects a side of the window. This allows you to select a side to extend.
-- @param f Frame of window
-- @oaram side String denoting side of window.
function select_window_side(side) -- window side should probably just be an object.
  local win, f, screen, max = enter_window()
  show_side(f, side)
  saved.win = win
  saved.side = side
  saved.winFrame = saved.winFrame
end

-- function shift_right(amount)
--   local win, f, screen, max = enter_window()
--   f.w = f.w + amount
--   return f
-- end
-- function shift_left(frame, amount)
--   f.x = f.x + amount
--   f.w = f.w + amount
--   if f.x
--   return f
-- end
-- function shift_up(frame, amount)
--   f.y = f.y + amount
--   f.h = f.h + amount
--   return f
-- end
-- function shift_down(frame, amount)
--   f.h = f.h + amount
--   return f
-- end

function enter_shift(dir) -- TODO Ugh, fix everything.
  local win, f, screen, max = enter_window() -- This breaks selecting new window
  print(dir)
  setup_shift(win, f, screen, max, dir)
  return f
end

function setup_shift(win, f, screen, max, dir)
  if win == saved.win then
    f = shift(win, f, screen, max, dir, 100)
    print("same window")
    win:setFrame(f)
  else
    show_side(f, dir)
    saved.side = dir
  end
  return f
end
function set_side(f, side)
  show_side(f, side)
  saved.side = side
end

function shift(win, f, screen, max, dir, amount)
  f = saved.winFrame
  side = saved.side
  if side == 'u' then
    if dir == 'u' then f.y = f.y - amount; f.h = f.h + amount
    elseif dir == 'd' then f.y = f.y + amount; f.h = f.h - amount
    else set_side(f, dir); --setup_shift(win, f, screen, max, dir)
    end
  elseif side == 'd' then
    if dir == 'u' then f.h = f.h - amount
    elseif dir == 'd' then f.h = f.h + amount
    else set_side(f, dir); --setup_shift(win, f, screen, max, dir)
    end
  elseif side == 'r' then
    if dir == 'r' then f.w = f.w + amount
    elseif dir == 'l' then f.w = f.w - amount
    else set_side(f, dir); --setup_shift(win, f, screen, max, dir)
    end
  elseif side == 'l' then
    if dir == 'r' then f.x = f.x + amount; f.w = f.w - amount
    elseif dir == 'l' then f.x = f.x - amount; f.w = f.w + amount
    else set_side(f, dir); --setup_shift(win, f, screen, max, dir)
    end
  end
  return f
end

-- Moves the window over a screen
function shift_screen()
  local win, f, screen, max = enter_window()
  local screen_id = screen:id()
  local screens = hs.screen.allScreens()
  local switch_to = screen
  for s_count=1, #screens do
    if screens[s_count]:id() ~= screen_id then
      switch_to = screens[s_count]
    end
  end
  win:moveToScreen(switch_to)
  return win
end

function show_side(f, side)
  local width = 20
  local shape = hs.geometry(f.x, f.y, f.w, 10)
  if     side=='u' then shape = hs.geometry(f.x, f.y, f.w, width)
  elseif side=='d' then shape = hs.geometry(f.x, f.y + f.h, f.w, width)
  elseif side=='l' then shape = hs.geometry(f.x, f.y, width, f.h)
  elseif side=='r' then shape = hs.geometry(f.x + f.w, f.y, width, f.h)
  end
  local highlight = hs.drawing.rectangle(shape)
  highlight:setStroke(false)
  highlight:setFill(true)
  highlight:setFillColor({["red"]=0.7,["blue"]=0.7,["green"]=0.7,["alpha"]=0.5})
  highlight:show()
  highlightTimer = hs.timer.doAfter(0.1, function() highlight:delete() end)
end

-- Set hotkeys
function set_hotkeys()
  local bindings = {
        {f = left_half, mods = {"cmd", "alt"}, key = "Left"},
        {f = right_half, mods = {"cmd", "alt"}, key = "Right"},
        {f = top_half, mods = {"cmd", "alt"}, key = "Up"},
        {f = bottom_half, mods = {"cmd", "alt"}, key = "Down"},
        {f = shift_screen, mods = {"control", "alt"}, key = "Left"}, -- prev, 2/3rds
        {f = shift_screen, mods = {"control", "alt"}, key = "Right"},
        {f = function() enter_shift('r') end, -- could be extend
          mods = {"cmd", "alt", "shift"}, key = "Right"},
        {f = function() enter_shift('l') end,
          mods = {"cmd", "alt", "shift"}, key = "Left"},
        {f = function() enter_shift('u') end,
          mods = {"cmd", "alt", "shift"}, key = "Up"},
        {f = function() enter_shift('d') end,
          mods = {"cmd", "alt", "shift"}, key = "Down"},
      }
  for b_count=1, #bindings do
    local b = bindings[b_count]
    hs.hotkey.bind(b.mods, b.key, b.f)
  end
end

set_hotkeys()
