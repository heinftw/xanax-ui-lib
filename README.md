# xanax ui lib

A clean, modern Roblox UI library with config saving, notifications, popups, and more.

## Setup

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/heinftw/xanax-ui-lib/main/uilib"))()
local lib = Library.new({Title = "my hub", Width = 320, Height = 450})
local Window = lib:Window({Title = "my hub", Width = 320, Height = 450})
local Tab = Window:Tab("main")
```

## Window

```lua
lib:Window(opts)
```

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| Title | string | `"xanax"` | Title bar text |
| Width | number | `300` | Window width |
| Height | number | `420` | Window height |
| Position | UDim2 | center | Initial position |
| Image | string | built-in | Background image asset id |
| Font | string | built-in | Custom font asset id |
| Settings | bool | `true` | Show/hide settings tab |
| Name | string | `"xanax"` | ScreenGui name |
| ConfigFolder | string | `"<name>_cfgs"` | Folder for saved configs |

**Window methods:**
- `win:Tab(name)` — adds a tab
- `win:Select(tab)` — switches to a tab
- `win:Destroy()` — destroys the window

**Built-in features:**
- Draggable (drag the title bar)
- Resizable (drag the corner grip)
- Minimize/close buttons
- Settings tab with config management and UI toggle bind

## Tab Elements

### Section
```lua
Tab:Section("combat")
```
A bold section header with cycling color animation.

### Label
```lua
Tab:Label("this is info text")
```
Static gray label text.

### Paragraph
```lua
Tab:Paragraph("this is a longer paragraph that wraps to multiple lines automatically")
```
Wrapped multi-line text.

### Toggle
```lua
local tog = Tab:Toggle("auto farm", true, function(state)
    print("auto farm:", state)
end)
tog.Set(false)  -- programmatic toggle
tog.Get()       -- returns true/false
```
ON/OFF toggle button. Registers for config saving.

### Button
```lua
Tab:Button("teleport to lobby", function()
    -- do something
end)
```
Clickable button with click sound.

### Slider
```lua
local sld = Tab:Slider("speed", 16, 100, 16, function(val)
    humanoid.WalkSpeed = val
end)
sld.Set(50)  -- programmatic set
sld.Get()    -- returns current value
```
Draggable slider with min/max values and live value display.

### Dropdown
```lua
local drop = Tab:Dropdown("team", {"red", "blue", "green"}, "red", function(val)
    print("selected:", val)
end)
drop.Set("blue")
drop.Get()
drop.Refresh({"red", "blue", "green", "yellow"})  -- update options
```
Dropdown selector. Registers for config saving.

### Textbox
```lua
local box = Tab:Textbox("webhook", "paste webhook url...", function(text, enter)
    if enter then print("submitted:", text) end
end)
box.Text  -- read current text
```
Text input field.

### Bind
```lua
local bind = Tab:Bind("toggle aimbot", Enum.KeyCode.Q, function()
    -- pressed key
end)
bind.Set(Enum.KeyCode.R)
bind.Get()  -- returns current KeyCode
```
Keybind picker. Registers for config saving.

## Notifications

```lua
lib:Notify({Title = "xanax", Body = "saved successfully!", Time = 4})
```

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| Title | string | library name | Notification title |
| Body | string | `""` | Notification message |
| Time | number | `4` | Display duration in seconds |

Slide-in from the right, auto-dismiss after `Time` seconds.

## Popup

```lua
lib:Popup({
    Title = "xanax",
    Sub = "hold on...",
    Body = "are you sure you wanna delete this?",
    Buttons = {
        {"yes", function()
            -- confirmed
        end},
        {"no"}
    }
})
```

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| Title | string | library name | Popup title |
| Sub | string | none | Small subtitle below title |
| Body | string | `""` | Main message text |
| Buttons | table | `{{"ok shhh"}}` | Array of `{text, callback}` |

- Hides main UI while open
- Shows main UI when any button is clicked
- Modal overlay with dimmed background

## Config System

All toggles, sliders, dropdowns, binds, and textboxes auto-register for config saving (requires executor with filesystem support).

**Settings tab (built-in):**
- Save config — saves all element values to a JSON file
- Load config — loads from dropdown selection
- Overwrite current — overwrites the active config
- Delete config — removes selected config
- Set as auto load — auto-loads a config on startup
- Toggle UI — keybind to show/hide the window (default: RightShift)

**Manual API:**
```lua
lib:SaveCfg("myconfig")
lib:LoadCfg("myconfig")
lib:DeleteCfg("myconfig")
```

## Customization

### Colors
```lua
local lib = Library.new({
    Black = Color3.fromRGB(0, 0, 0),
    Bar = Color3.fromRGB(15, 15, 15),
    Off = Color3.fromRGB(65, 65, 65),
    On = Color3.fromRGB(105, 105, 105),
    Track = Color3.fromRGB(45, 45, 45),
    Fill = Color3.fromRGB(180, 180, 180),
    Text = Color3.fromRGB(230, 230, 230),
    SubText = Color3.fromRGB(140, 140, 140),
})
```

### Font & Image
```lua
local lib = Library.new({
    Font = "rbxassetid://12187377325",
    Image = "rbxthumb://type=Asset&id=71976807018315&w=420&h=420",
})
```

### Sound
```lua
local lib = Library.new({
    Sfx = "rbxassetid://124476359159008",
    SfxVolume = 2,
})
```

## Executor Compatibility

Works with any executor that supports:
- `Instance.new`, `game:GetService`
- `writefile`, `readfile`, `isfile`, `listfiles`, `isfolder`, `makefolder` (for config saving)
- Falls back gracefully without filesystem support
