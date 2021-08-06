" Set Editor Font
if exists(':GuiFont')
    GuiRenderLigatures 1
    GuiFont! mononoki Nerd Font:h10
    " GuiFont Cascadia Code PL:h10:l
    " GuiFont! Fira Code:h10
    " set guifont=Fira\ Code:h10
    set guifontwide=Noto\ Color\ Emoji:h10
endif

" Disable GUI Popupmenu
if exists(':GuiPopupmenu')
    GuiPopupmenu 0
endif
