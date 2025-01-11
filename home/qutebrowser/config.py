config.load_autoconfig(False)

c.content.javascript.clipboard = "access-paste"
c.completion.shrink = True
c.content.autoplay = False
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.policy.images = "never"
c.downloads.open_dispatcher = "xdg-open '{}'"
c.qt.force_platformtheme='gtk3'
c.content.blocking.method = 'both'

# Custom fonts  
c.fonts.default_family = 'Rxen Sans'
c.fonts.prompts = '14pt Rxen Sans'
c.fonts.default_size = '14pt'


player_div = 'document.querySelector("#movie_player")'

# Custom keybinds
config.bind(';m', 'hint links spawn mpv {hint-url}')
config.bind('ch', 'history-clear')
config.bind('(', f'jseval -q {player_div}.focus()')
config.bind(')', f'jseval -q {player_div}.blur()')
config.bind('cm', 'clear-messages', mode='normal')
config.bind('xr', 'config-source', mode='normal')
config.bind('xf', 'config-cycle statusbar.show always never;; config-cycle tabs.show always never')
config.bind('xd', 'config-cycle colors.webpage.darkmode.enabled true false')
config.bind('J', 'tab-prev', mode="normal")
config.bind('K', 'tab-next', mode="normal")


# Vim-style movement in insert movde
config.bind('<Ctrl+h>', 'fake-key <left>', 'insert')
config.bind('<Ctrl+j>', 'fake-key <down>', 'insert')
config.bind('<Ctrl+k>', 'fake-key <up>', 'insert')
config.bind('<Ctrl+l>', 'fake-key <right>', 'insert')
config.bind('<Enter>', 'fake-key -g <enter>;; later 0.3s mode-leave', 'insert')

# Vim-style movement keys in command mode
config.bind('<Ctrl-j>', 'completion-item-focus --history next', mode='command')
config.bind('<Ctrl-k>', 'completion-item-focus --history prev', mode='command')
config.bind('<Alt-j>', 'completion-item-focus --history next', mode='command')
config.bind('<Alt-k>', 'completion-item-focus --history prev', mode='command')


import pywalQute.draw
pywalQute.draw.color(c, {
    'spacing': {
        'vertical': 4,
        'horizontal': 4
    }
})
