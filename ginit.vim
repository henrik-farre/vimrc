" Set Editor Font
if exists(':GuiFont')
    GuiRenderLigatures 1
    GuiFont! mononoki Nerd Font:h10
    set guifontwide=Noto\ Color\ Emoji:h10
endif

" Disable GUI Popupmenu
if exists(':GuiPopupmenu')
    GuiPopupmenu 0
endif
