" Vim color file

set background=dark

if version > 580
	hi clear
	if exists("syntax_on")
		syntax reset
	endif
endif

let colors_name = "vs2019dark"


" General colors
hi Normal		ctermfg=252		ctermbg=234		cterm=none
hi Cursor		ctermfg=234		ctermbg=228		cterm=none
hi Visual		ctermfg=251		ctermbg=239		cterm=none
hi VisualNOS	ctermfg=251		ctermbg=236		cterm=none
hi Search		ctermfg=227		ctermbg=238		cterm=none
hi Folded		ctermfg=103		ctermbg=237		cterm=none
hi Title		ctermfg=252						cterm=bold
hi StatusLine	ctermfg=231		ctermbg=32		cterm=none
hi VertSplit	ctermfg=238		ctermbg=238		cterm=none
hi StatusLineNC	ctermfg=244		ctermbg=238		cterm=none
hi LineNr		ctermfg=238		ctermbg=234		cterm=none
hi CursorLineNr	ctermfg=227		ctermbg=236		cterm=none
hi WarningMsg	ctermfg=203
hi ErrorMsg		ctermfg=196		ctermbg=236		cterm=bold

" Vim >= 7.0 specific colors
if version >= 700
hi CursorLine					ctermbg=236		cterm=none
hi MatchParen	ctermfg=227	    ctermbg=238		cterm=bold
hi Pmenu		ctermfg=252		ctermbg=238
hi PmenuSel		ctermfg=232		ctermbg=32
hi PmenuSbar	ctermfg=232		ctermbg=238
hi PmenuThumb	ctermfg=232		ctermbg=244
endif

" Diff highlighting
hi DiffAdd						ctermbg=17
hi DiffDelete	ctermfg=231		ctermbg=60		cterm=none
hi DiffText						ctermbg=53		cterm=none
hi DiffChange					ctermbg=237

hi TabLine		ctermfg=244		ctermbg=238		cterm=none
hi TabLineFill	ctermfg=238		ctermbg=238
hi TabLineSel	ctermfg=252		ctermbg=236		cterm=none

" Syntax highlighting

" Green
hi Comment		ctermfg=71		cterm=none

" Purple
hi Keyword		ctermfg=182		cterm=none
hi Statement	ctermfg=182		cterm=none

" Light grey
hi PreProc		ctermfg=246		cterm=none

" Blue
hi Type			ctermfg=110		cterm=none
hi Constant		ctermfg=110		cterm=none

" Pale yellow
hi Identifier	ctermfg=187		cterm=none
hi Function		ctermfg=187		cterm=none

" Orange
hi String		ctermfg=216		cterm=none
hi Character	ctermfg=216		cterm=none
hi Number		ctermfg=216		cterm=none
hi Float		ctermfg=216		cterm=none
hi Boolean		ctermfg=216		cterm=none
hi Special		ctermfg=216		cterm=none

" Bright yellow
hi Todo			ctermfg=192		cterm=bold

" Grey
hi NonText		ctermfg=238		cterm=none
hi SpecialKey	ctermfg=238		cterm=none

" Links
hi! link FoldColumn		Folded
hi! link CursorColumn	CursorLine

" vim:set ts=4 sw=4 noet:
