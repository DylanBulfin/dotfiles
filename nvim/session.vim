let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
doautoall SessionLoadPre
silent only
silent tabonly
cd ~/repos/dotfiles/nvim
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
set shortmess+=aoO
badd +14 ~/repos/dotfiles/nvim/lua/config/opts.lua
badd +93 ~/repos/dotfiles/nvim/lua/config/keymap.lua
badd +6 ~/repos/dotfiles/nvim/lua/plugins/theme/catppuccin.lua
badd +8 lua/plugins/nav/hop.lua
badd +8 ~/repos/dotfiles/nvim/lua/plugins/editing/mini.lua
badd +1 ~/repos/dotfiles/nvim/lua/plugins/nav/spider.lua
badd +1 ~/repos/dotfiles/nvim/lua/plugins/treesitter.lua
badd +1 ~/repos/dotfiles/nvim/lua/config/treesitter.lua
badd +4 ~/repos/dotfiles/nvim/./init.lua
badd +16 ~/repos/dotfiles/nvim/lua/plugins/cmp.lua
badd +3 lua/plugins/autosave.lua
badd +8 ~/repos/dotfiles/nvim/lua/plugins/format/conform.lua
argglobal
%argdel
edit ~/repos/dotfiles/nvim/lua/config/keymap.lua
argglobal
balt ~/repos/dotfiles/nvim/lua/config/opts.lua
setlocal foldmethod=manual
setlocal foldexpr=v:lua.vim.treesitter.foldexpr()
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldenable
silent! normal! zE
let &fdl = &fdl
let s:l = 61 - ((28 * winheight(0) + 29) / 58)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 61
normal! 019|
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
