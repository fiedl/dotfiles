#!/usr/bin/env coffee -p
# https://github.com/kasper/phoenix
# https://github.com/fabiospampinato/phoenix/
# brew cask install phoenix

# Debugging
# -----------------------------------------------------------------------------

# Debugging: Open `Console.app` and filter for "phoenix"
# to view the output of `Phoenix.log 'foo'`.


# Toggle Hotkeys
# -----------------------------------------------------------------------------

# fn+letter is mapped to cmd+alt+shift+ctrl+letter in karabiner-elements
fn = ['alt', 'shift', 'ctrl', 'cmd']

toggle_bluetooth = ->
  Task.run("/usr/local/bin/blueutil", ["toggle"])

Key.on 'b', fn , toggle_bluetooth

wifi_state = "On"
Task.run "/usr/sbin/networksetup", ["-getairportpower", "en0"], (task) ->
  # Output: Wi-Fi Power (en0): On
  wifi_state = task.output.split(": ")[1]

toggle_wifi = ->
  wifi_state = if (wifi_state == "On") then "Off" else "On"
  Task.run "/usr/sbin/networksetup", ["-setairportpower", "en0", wifi_state]

Key.on 'w', fn, toggle_wifi


# Application Hotkeys
# -----------------------------------------------------------------------------

cmd_alt = (letter, application) ->
  Key.on letter, ['cmd', 'alt'], -> App.launch(application).focus()

cmd_alt 'i', 'Safari'
cmd_alt 'm', 'Mail'


## Spaces
## -----------------------------------------------------------------------------

caps_lock = ['alt', 'shift', 'ctrl']  # mapped by karabiner
caps_lock_cmd = ['alt', 'shift', 'ctrl', 'cmd']

for i in [1..9]
  ((i)-> # needed for scoping. otherwise i will always be n+1 when the callback is called.
    # Key.on i, caps_lock, -> go_to_space i
    Key.on i, ['ctrl', 'alt'], -> move_active_window_to_space i
    Key.on i, ['ctrl', 'alt', 'cmd'], -> move_active_window_and_go_to_space i
  )(i)

spaces_of_current_screen = ->
  _.filter(Space.all(), (space)->
    _.includes(space.screens(), active_window().screen()) && space.isNormal()
  )

space = (i)->
  spaces_of_current_screen()[i - 1]

active_window = ->
  Window.focused()

# go_to_space = (i)->
#   w = Window.recent()[0]
#   s = w.spaces()[0]
#   space(i).addWindows [w]
#   s.removeWindows [w]
#   w.focus()
#   space(i).removeWindows [w]
#   s.addWindows [w]

move_active_window_to_space = (i)->
  Space.active().removeWindows [active_window()]
  space(i).addWindows [active_window()]

move_active_window_and_go_to_space = (i)->
  move_active_window_to_space(i)
  active_window().focus()

## Move new or restored windows to the current space
## which is a workaround for auto swooshing.
## ----------------------------------------------------------------------------

# Notable things:
#
# - Window events don't get triggered for all apps.
#   Therefore, we need to use a timer to watch the current window.
#   https://github.com/kasper/phoenix/issues/145#issuecomment-256474398
#
# - This actually does help:
#
#       defaults write com.apple.Dock workspaces-auto-swoosh -bool NO
#       killall Dock

# current_space = null
# last_space = null
# space_changed_at = null
# window_spawned_at = null
#
# Event.on 'spaceDidChange', ->
#   Phoenix.log "spaceDidChange"
#   last_space = current_space
#   current_space = Space.active()
#   space_changed_at = (new Date()).getTime()
#
#   # Event order: First, the window spawnes and then the space changes.
#   Phoenix.log space_changed_at - window_spawned_at
#   if space_changed_at - window_spawned_at < 500 # ms
#     Phoenix.log "swoosh!"
#
# window_did_spawn = ->
#   window_spawned_at = (new Date()).getTime()
#   Phoenix.log window_spawned_at
#
# Event.on 'windowDidOpen', (window)->
#   Phoenix.log "windowDidOpen"
#   #window_did_spawn()
#
# Event.on "windowDidFocus", (window)->
#   Phoenix.log "windowDidFocus"
#
# Event.on 'appDidShow', ->
#   Phoenix.log "appDidShow"
#   #window_did_spawn()
#
# Event.on 'windowDidUnminimise', ->
#   Phoenix.log "windowDidUnminimise"
#   #window_did_spawn()
#
# Event.on 'appDidActivate', ->
#   Phoenix.log "appDidActivate"
#   window_spawned_at = (new Date()).getTime()
#   Phoenix.log space_changed_at - window_spawned_at
#   if space_changed_at - window_spawned_at > 0
#     if space_changed_at - window_spawned_at < 500 # ms
#       Phoenix.log "swoosh"
#       #Phoenix.log Window.focused().isVisible()
#
# Event.on 'appDidActivate', (app)->
#   if app.mainWindow()
#     app_main_window_is_on_current_space = Space.active().windows().map((window)-> window.hash()).includes(app.mainWindow().hash())
#     if not app_main_window_is_on_current_space
#       for space in Space.all()
#         space.removeWindows [app.mainWindow()]
#       Space.active().addWindows [app.mainWindow()]

# Window Positions
# -----------------------------------------------------------------------------

main_screen = -> Screen.all()[0]

Key.on 'f18', [], ->
  Window.focused().setFrame WindowPreset.next().frame()

Key.on 'left', caps_lock, ->
  Window.focused().setFrame left_preset().frame()

Key.on 'right', caps_lock, ->
  Window.focused().setFrame right_preset().frame()


window_padding = -> 12

left_preset = -> WindowPreset.new({left: 0.0, width: 0.5})
right_preset = -> WindowPreset.new({left: 0.5, width: 0.5})

class WindowPreset
  left: 0
  width: 0
  @destroy_all: -> @all = []
  @new: (args)->
    new_preset = new WindowPreset
    for key, value of args
      new_preset[key] = value
    return new_preset
  @create: (args)->
    @all.push(WindowPreset.new(args))
  @all: []
  @current_index: -1
  @next: ->
    @current_index += 1
    @current_index = 0 if @current_index >= @all.length
    @all[@current_index]
  frame: ->
    frame = main_screen().flippedVisibleFrame()
    frame.x = frame.width * @left + window_padding()
    frame.width = frame.width * @width - window_padding()
    frame.y = frame.y + window_padding()
    frame.height = frame.height - window_padding() * 2
    return frame
  @second: ->
    @all[1]

Event.on 'screensDidChange', -> initialize_window_presets()

initialize_window_presets = ->
  WindowPreset.destroy_all()
  if main_screen().visibleFrame().width > 2500
    WindowPreset.create {left: 0.0, width: 1 / 3}
    WindowPreset.create {left: 1 / 3, width: 1 / 3}
    WindowPreset.create {left: 2 / 3, width: 1 / 3}
    #if Screen.all().length > 1
    #  WindowPreset.create {left: 1.0, width: 1 / 3}
    #  WindowPreset.create {left: 4 / 3, width: 1 / 3}
    #  WindowPreset.create {left: 5 / 3, width: 1 / 3}
  else
    golden_ratio = 0.618
    WindowPreset.create {left: 0.0, width: golden_ratio}
    WindowPreset.create {left: golden_ratio, width: (1 - golden_ratio)}

initialize_window_presets()


Key.on 'f18', ['cmd'], ->
  frame = Window.focused().frame()
  Phoenix.log frame.width
  frame.height = frame.width / 16 * 9
  Window.focused().setFrame frame


# Window Rules
# -----------------------------------------------------------------------------

Event.on 'windowDidOpen', (window)->
  if window.app().name() == "Markoff"
    window.setFrame WindowPreset.second()


# Mic mute
# -----------------------------------------------------------------------------

Key.on 'm', fn , toggle_microphone

toggle_microphone = ->
  Phoenix.log "test"
  #apple_script = "
  #set inputVolume to input volume of (get volume settings)
  #if inputVolume = 0 then
  #  set inputVolume to 25
  #else
  #  set inputVolume to 0
  #end if
  #set volume input volume inputVolume"
  #Phoenix.log apple_script
  #Task.run "/usr/bin/osascript", ["-e", apple_script]

