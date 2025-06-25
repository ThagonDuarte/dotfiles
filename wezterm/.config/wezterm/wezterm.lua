local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local act = wezterm.action

config.font = wezterm.font 'FiraCode Nerd Font'
config.color_scheme = 'GruvboxDark'config.window_padding = {
  left = '0.5cell',
  right = '0.5cell',
  top = '0.25cell',
  bottom = '0.25cell',
}

config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.colors = {
  tab_bar = {
    background = '#232323',
    active_tab = {
      bg_color = '#282828',
      fg_color = '#ebdbb2',
      underline = 'None',
    },
    inactive_tab = {
      bg_color = '#232323',
      fg_color = '#a89984',
    },
    inactive_tab_hover = {
      bg_color = '#232323',
      fg_color = '#a89984',
    },
    new_tab = {
      bg_color = '#232323',
      fg_color = '#a89984',
    },
    new_tab_hover = {
      bg_color = '#282828',
      fg_color = '#fbf1c7',
    },
  }
}
config.tab_max_width = 64
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
  local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider
  local SOLID_SEPARATOR = wezterm.nerdfonts.ple_lower_right_triangle

  local title = tab.active_pane.title
  if tab.tab_title and #tab.tab_title > 0 then
    title = tab.tab_title
  end
  if tab.is_active then
    if tab.tab_index == 0 then
      return {
        { Text = " " .. title .. " " },
        { Foreground = { Color = "#232323" } },
        { Text = SOLID_SEPARATOR },
      }
    elseif tab.tab_index + 1 == #tabs then
      return {
        { Background = { Color = "#232323" } },
        { Foreground = { Color = "#282828" } },
        { Text = SOLID_SEPARATOR },
        { Background = { Color = "#282828" } },
        { Foreground = { Color = "#ebdbb2" } },
        { Text = " " .. title .. " " },
      }
    else
      return {
        { Background = { Color = "#232323" } },
        { Foreground = { Color = "#282828" } },
        { Text = SOLID_SEPARATOR },
        { Background = { Color = "#282828" } },
        { Foreground = { Color = "#ebdbb2" } },
        { Text = " " .. title .. " " },
        { Foreground = { Color = "#232323" } },
        { Text = SOLID_SEPARATOR },
       }
    end
  else  
    return {
      { Text = " " .. title .. " " },
    }
  end
end)

config.keys = {
  {
    key = 'LeftArrow',
    mods = 'ALT',
    action = act.ActivatePaneDirection 'Left',
  },
  {
    key = 'RightArrow',
    mods = 'ALT',
    action = act.ActivatePaneDirection 'Right',
  },
  {
    key = 'UpArrow',
    mods = 'ALT',
    action = act.ActivatePaneDirection 'Up',
  },
  {
    key = 'DownArrow',
    mods = 'ALT',
    action = act.ActivatePaneDirection 'Down',
  },
  {
    key = 'RightArrow',
    mods = 'CTRL|SHIFT',
    action = act.SplitPane {
      direction = 'Right',
      size = { Percent = 50 },
    },
  },
  {
    key = 'LeftArrow',
    mods = 'CTRL|SHIFT',
    action = act.SplitPane {
      direction = 'Left',
      size = { Percent = 50 },
    },
  },
  {
    key = 'UpArrow',
    mods = 'CTRL|SHIFT',
    action = act.SplitPane {
      direction = 'Up',
      size = { Percent = 50 },
    },
  },
  {
    key = 'DownArrow',
    mods = 'CTRL|SHIFT',
    action = act.SplitPane {
      direction = 'Down',
      size = { Percent = 50 },
    },
  },
  { key = 'n', mods = 'CTRL|SHIFT|ALT', action = act.SpawnWindow },
  {
    key = 'b',
    mods = 'CTRL|SHIFT',
    action = act.RotatePanes 'CounterClockwise',
  },
  { key = 'n', mods = 'CTRL|SHIFT', action = act.RotatePanes 'Clockwise' },
  { key = 'l', mods = 'CTRL|SHIFT', action = act.ShowLauncher },
}

return config
