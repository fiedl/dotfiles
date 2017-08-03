#!/usr/bin/env ruby

# This script moves and resizes the current window to the following positions
# in turn:
#
# |--------|---------|--------|
# |        |         |        |
# |        |         |        |
# |   (1)  |   (2)   |   (3)  |
# |        |         |        |
# |        |         |        |
# |--------|---------|--------|
#
# Triggering this script by a hotkey in your favorite window manager (e.g. compiz)
# will add a certain tiling window manager functionality on top of the regular
# window manager.
#
# This script requires the following packages:
#
#   * ruby
#   * xdotool
#   * wmctrl
#
# Kind regards,
# Sebastian Fiedlschuster
# 2015-01-21
#
# Released under the GPL.
#

# class Window
#   def initialize(window_id)
#     @window_id = window_id
#   end
# end
#
# class CurrentWindow < Window
#   def initialize
#     super Window.current_window_id
#   end
# end


def screen_width
  # If the screen is larger than 2560 in width, it's a dual head.
  # Then, just assume 2560.
  #
  # "0  * DG: 17920x1440  VP: 0,0  WA: 0,24 4480x1416  Workspace 1"
  [`wmctrl -d`.match(/(\d{4})x(\d{4})  (Workspace|N\/A)/)[1].to_i, 2560].min
end
def screen_height
  `wmctrl -d`.match(/(\d{4})x(\d{4})  (Workspace|N\/A)/)[2].to_i
end

def current_window_id
  @current_window_id ||= `xdotool getwindowfocus`.strip
end

def move_window(window_id, x, y, width = -1, height = -1)
  `wmctrl -i -r #{window_id} -e 0,#{x.to_i},#{y.to_i},#{width.to_i},#{height.to_i}`
end

def move_window_to_preset(window_id, preset_id)
  case preset_id
  when 1
    move_window window_id,   x_zero_coordinate,             0, screen_width * 0.61803398875, screen_height
  when 2
    move_window window_id,   screen_width * 0.61803398875,  0, screen_width * (1-0.61803398875), screen_height
  when 3
    move_window window_id,   0,                    0, screen_width / 3, screen_height
  when 4
    move_window window_id,   screen_width / 3,     0, screen_width / 3, screen_height
  when 5
    move_window window_id,   screen_width / 3 * 2, 0, screen_width / 3, screen_height
  end
end
def number_of_presets
  if screen_width > 2000
    5
  else
    2
  end
end

def x_zero_coordinate
  0
end

def last_preset
  if File.exist?("/tmp/arrange-window-preset.txt")
    File.read("/tmp/arrange-window-preset.txt").to_i
  end
end
def store_last_preset(preset)
  File.write("/tmp/arrange-window-preset.txt", preset)
end

preset = (last_preset || 0) + 1
preset = 1 if preset > number_of_presets
store_last_preset preset

move_window_to_preset current_window_id, preset
