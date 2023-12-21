" Set Editor Font
if exists(':GuiFont')
    GuiRenderLigatures 1
    GuiFont! mononoki Nerd Font:h11
    set guifontwide=Noto\ Color\ Emoji:h11

    " Based on https://github.com/drzel/neovim-config/blob/ae5ebf721b6d1cd9e975b60df6ef97ae9fb0584c/nvim/ginit.vim#L32
    let s:fontsize = 11
    let s:font = "GuiFont! mononoki Nerd Font"

    function! AdjustFontSize(amount)
      let s:fontsize = s:fontsize+a:amount
      :execute s:font . ":h" . s:fontsize
    endfunction

    " Removed functions from insert mode
    noremap <C-ScrollWheelUp> :call AdjustFontSize(1)<CR>
    noremap <C-ScrollWheelDown> :call AdjustFontSize(-1)<CR>
    noremap <C-+> :call AdjustFontSize(1)<CR>
    noremap <C--> :call AdjustFontSize(-1)<CR>
endif

" Disable GUI Popupmenu
" if exists(':GuiPopupmenu')
"     GuiPopupmenu 0
" endif

if exists('g:GtkGuiLoaded')
    call rpcnotify(1, 'Gui', 'Font', 'Iosevka Term Light Extended 10.5')
endif

augroup auto_checktime
    autocmd!
    autocmd FocusGained * checktime
augroup END
