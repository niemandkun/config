" Vim color file

set background=dark

if version > 580
hi clear
if exists("syntax_on")
syntax reset
endif
endif

let colors_name = "dark"

" General colors
hi Normal			ctermfg=188	ctermbg=234	cterm=none	guifg=#d4d4d4	guibg=#1e1e1e	gui=none
hi Cursor			ctermfg=234	ctermbg=228	cterm=none	guifg=#1e1e1e	guibg=#ffff87	gui=none
hi Visual			ctermfg=188	ctermbg=24	cterm=none					guibg=#264f78	gui=none
hi VisualNOS					ctermbg=237	cterm=none					guibg=#3a3d41	gui=none
hi Search			ctermfg=188	ctermbg=58	cterm=none	guifg=#d4d4d4	guibg=#623315	gui=none
hi Folded			ctermfg=103	ctermbg=237	cterm=none	guifg=#8787af	guibg=#3a3a3a	gui=none
hi Title			ctermfg=252				cterm=bold	guifg=#d4d4d4					gui=bold
hi VertSplit		ctermfg=238	ctermbg=234	cterm=none	guifg=#444444	guibg=#1e1e1e	gui=none
hi LineNr			ctermfg=238	ctermbg=234	cterm=none	guifg=#444444	guibg=#1e1e1e	gui=none
hi CursorLineNr		ctermfg=252	ctermbg=236	cterm=none	guifg=#cccccc	guibg=#303030	gui=none
hi WarningMsg		ctermfg=11	ctermbg=234 cterm=bold	guifg=#ffff00	guibg=#1e1e1e	gui=bold
hi ErrorMsg			ctermfg=9	ctermbg=234	cterm=bold	guifg=#ff0000	guibg=#1e1e1e	gui=bold
hi SignColumn		ctermfg=188	ctermbg=234 cterm=none	guifg=#d4d4d4	guibg=#1e1e1e	gui=none
hi ColorColumn					ctermbg=236	cterm=none					guibg=#303030	gui=none
hi Conceal			ctermfg=188	ctermbg=234	cterm=none	guifg=#d4d4d4	guibg=#1e1e1e	gui=none

hi StatusLine		ctermfg=15	ctermbg=32	cterm=none	guifg=#ffffff	guibg=#0078d4	gui=none
hi StatusLineNC		ctermfg=234	ctermbg=239	cterm=none	guifg=#1e1e1e	guibg=#4e4e4e	gui=none

hi StatusLineTerm	ctermfg=15	ctermbg=29	cterm=none	guifg=#ffffff	guibg=#16825d	gui=none
hi StatusLineTermNC	ctermfg=234	ctermbg=239	cterm=none	guifg=#1e1e1e	guibg=#4e4e4e	gui=none

hi CursorLine					ctermbg=236	cterm=none					guibg=#303030	gui=none
hi MatchParen		ctermfg=227	ctermbg=238	cterm=bold	guifg=#ffff5f	guibg=#444444	gui=bold
hi Pmenu			ctermfg=188	ctermbg=236				guifg=#d4d4d4	guibg=#303030
hi PmenuSel			ctermfg=15	ctermbg=24				guifg=#ffffff	guibg=#264f78
hi PmenuSbar		ctermfg=232	ctermbg=236				guifg=#080808	guibg=#303030
hi PmenuThumb		ctermfg=232	ctermbg=8				guifg=#080808	guibg=#808080

" Diff highlighting
hi DiffAdd						ctermbg=65								guibg=#383e2a	gui=none
hi DiffDelete		ctermfg=15	ctermbg=52	cterm=none	guifg=#ffffff	guibg=#4c1919	gui=none
hi DiffText						ctermbg=236	cterm=none					guibg=#303030	gui=none
hi DiffChange					ctermbg=236								guibg=#303030	gui=none

hi TabLine			ctermfg=8	ctermbg=234	cterm=none	guifg=#808080	guibg=#1e1e1e	gui=none
hi TabLineFill		ctermfg=234	ctermbg=234				guifg=#1e1e1e	guibg=#1e1e1e	gui=none
hi TabLineSel		ctermfg=188	ctermbg=236	cterm=none	guifg=#d4d4d4	guibg=#303030	gui=none

" Syntax highlighting

" Green
hi Comment			ctermfg=65				cterm=none	guifg=#6a9955					gui=none
hi MoreMsg			ctermfg=65				cterm=none	guifg=#6a9955					gui=none
hi Question			ctermfg=65				cterm=none	guifg=#6a9955					gui=none

" Purple
hi Keyword			ctermfg=176				cterm=none	guifg=#c586c0					gui=none
hi Statement		ctermfg=176				cterm=none	guifg=#c586c0					gui=none
hi PreProc			ctermfg=176				cterm=none	guifg=#c586c0					gui=none

" Blue
hi Type				ctermfg=74				cterm=none	guifg=#569cd6					gui=none
hi Boolean			ctermfg=74				cterm=none	guifg=#569cd6					gui=none
hi Constant			ctermfg=74				cterm=none	guifg=#569cd6					gui=none
hi Directory		ctermfg=74				cterm=none	guifg=#569cd6					gui=none

" Blue/green
hi Struct			ctermfg=79				cterm=none	guifg=#4ec9b0					gui=none

" Pale green
hi Float			ctermfg=151				cterm=none	guifg=#b5cea8					gui=none
hi Number			ctermfg=151				cterm=none	guifg=#b5cea8					gui=none

" Pale yellow
hi Function			ctermfg=187				cterm=none	guifg=#dcdcaa					gui=none

" Light blue
hi Identifier		ctermfg=153				cterm=none	guifg=#9cdcfe					gui=none

" Orange
hi Character		ctermfg=216				cterm=none	guifg=#ce9178					gui=none
hi String			ctermfg=216				cterm=none	guifg=#ce9178					gui=none

" Bright orange
hi Special			ctermfg=180				cterm=none	guifg=#d7ba7d					gui=none

" Bright yellow
hi Todo				ctermfg=192	ctermbg=234	cterm=bold	guifg=#d7ff87	guibg=#1e1e1e	gui=bold

" Grey
hi NonText			ctermfg=238				cterm=none	guifg=#444444					gui=none
hi SpecialKey		ctermfg=238				cterm=none	guifg=#444444					gui=none

" Links
hi! link FoldColumn		Folded
hi! link CursorColumn	CursorLine

hi! link lCursor		Cursor
hi! link CursorIM		Cursor

hi! link LineNrAbove	LineNr
hi! link LineNrBelow	LineNr

" vim:set ts=4 sw=4 noet:
