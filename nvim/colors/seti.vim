" Hex colour conversion functions borrowed from the theme "Desert256""

let s:background = 0
let s:colors = 0

let s:keyword_style = "bold"
"let s:keyword_style = ""

if s:background == 0
	" One Dark
	let s:foreground = "abb2bf"
	let s:background = "282c34"
	let s:comment = "5d636f"
	let s:window = "282c33"
	let s:cursor = "74ade8"
	let s:line = "2d323b"
	let s:selection = "394c62"
	let s:lineNr = "4e5a5f"
	let s:cursorLineNr = "d0d4da"

elseif s:background == 1
	" One Dark - desaturated
	let s:foreground = "b5b5b5"
	let s:background = "282828"
	let s:comment = "5f5f5f"
	let s:window = "282828"
	let s:cursor = "aeaeae"
	let s:line = "2e2e2e"
	let s:selection = "454545"
	let s:lineNr = "535353"
	let s:cursorLineNr = "d0d0d0"

elseif s:background == 2
	" Seti
	let s:foreground = "d6d6d6"
	let s:background = "1d1d1d"
	let s:comment = "787878"
	let s:window = "1d1d1d"
	let s:cursor = "aeaeae"
	let s:line = "282828"
	let s:selection = "4a4a4a"
	let s:lineNr = "4a4a4a"
	let s:cursorLineNr = "d6d6d6"
endif

if s:colors == 0
	" One Dark
	let s:aqua = "56b6c2"
	let s:blue = "61afef"
	let s:green = "98c379"
	let s:orange = "bf956a"
	let s:purple = "c678dd"
	let s:red = "e06c75"
	let s:yellow = "e5c07b"

elseif s:colors == 1
	" One Dark - desaturated
	let s:aqua = "6eb0b4"
	let s:blue = "73a9de"
	let s:green = "9fbb75"
	let s:orange = "bf915f"
	let s:purple = "b473c4"
	let s:red = "d06e6c"
	let s:yellow = "dfbd79"

elseif s:colors == 2
	" Seti
	let s:aqua = "55dbbe"
	let s:blue = "55b5db"
	let s:green = "9fca56"
	let s:orange = "d98657"
	let s:purple = "a074c4"
	let s:red = "cd3f45"
	let s:yellow = "e6cd69"
endif

set background=dark
hi clear
syntax reset

let g:colors_name = "seti"

if has("gui_running") || &t_Co == 88 || &t_Co == 256
	" Returns an approximate grey index for the given grey level
	fun <SID>grey_number(x)
		if &t_Co == 88
			if a:x < 23
				return 0
			elseif a:x < 69
				return 1
			elseif a:x < 103
				return 2
			elseif a:x < 127
				return 3
			elseif a:x < 150
				return 4
			elseif a:x < 173
				return 5
			elseif a:x < 196
				return 6
			elseif a:x < 219
				return 7
			elseif a:x < 243
				return 8
			else
				return 9
			endif
		else
			if a:x < 14
				return 0
			else
				let l:n = (a:x - 8) / 10
				let l:m = (a:x - 8) % 10
				if l:m < 5
					return l:n
				else
					return l:n + 1
				endif
			endif
		endif
	endfun

	" Returns the actual grey level represented by the grey index
	fun <SID>grey_level(n)
		if &t_Co == 88
			if a:n == 0
				return 0
			elseif a:n == 1
				return 46
			elseif a:n == 2
				return 92
			elseif a:n == 3
				return 115
			elseif a:n == 4
				return 139
			elseif a:n == 5
				return 162
			elseif a:n == 6
				return 185
			elseif a:n == 7
				return 208
			elseif a:n == 8
				return 231
			else
				return 255
			endif
		else
			if a:n == 0
				return 0
			else
				return 8 + (a:n * 10)
			endif
		endif
	endfun

	" Returns the palette index for the given grey index
	fun <SID>grey_colour(n)
		if &t_Co == 88
			if a:n == 0
				return 16
			elseif a:n == 9
				return 79
			else
				return 79 + a:n
			endif
		else
			if a:n == 0
				return 16
			elseif a:n == 25
				return 231
			else
				return 231 + a:n
			endif
		endif
	endfun

	" Returns an approximate colour index for the given colour level
	fun <SID>rgb_number(x)
		if &t_Co == 88
			if a:x < 69
				return 0
			elseif a:x < 172
				return 1
			elseif a:x < 230
				return 2
			else
				return 3
			endif
		else
			if a:x < 75
				return 0
			else
				let l:n = (a:x - 55) / 40
				let l:m = (a:x - 55) % 40
				if l:m < 20
					return l:n
				else
					return l:n + 1
				endif
			endif
		endif
	endfun

	" Returns the actual colour level for the given colour index
	fun <SID>rgb_level(n)
		if &t_Co == 88
			if a:n == 0
				return 0
			elseif a:n == 1
				return 139
			elseif a:n == 2
				return 205
			else
				return 255
			endif
		else
			if a:n == 0
				return 0
			else
				return 55 + (a:n * 40)
			endif
		endif
	endfun

	" Returns the palette index for the given R/G/B colour indices
	fun <SID>rgb_colour(x, y, z)
		if &t_Co == 88
			return 16 + (a:x * 16) + (a:y * 4) + a:z
		else
			return 16 + (a:x * 36) + (a:y * 6) + a:z
		endif
	endfun

	" Returns the palette index to approximate the given R/G/B colour levels
	fun <SID>colour(r, g, b)
		" Get the closest grey
		let l:gx = <SID>grey_number(a:r)
		let l:gy = <SID>grey_number(a:g)
		let l:gz = <SID>grey_number(a:b)

		" Get the closest colour
		let l:x = <SID>rgb_number(a:r)
		let l:y = <SID>rgb_number(a:g)
		let l:z = <SID>rgb_number(a:b)

		if l:gx == l:gy && l:gy == l:gz
			" There are two possibilities
			let l:dgr = <SID>grey_level(l:gx) - a:r
			let l:dgg = <SID>grey_level(l:gy) - a:g
			let l:dgb = <SID>grey_level(l:gz) - a:b
			let l:dgrey = (l:dgr * l:dgr) + (l:dgg * l:dgg) + (l:dgb * l:dgb)
			let l:dr = <SID>rgb_level(l:gx) - a:r
			let l:dg = <SID>rgb_level(l:gy) - a:g
			let l:db = <SID>rgb_level(l:gz) - a:b
			let l:drgb = (l:dr * l:dr) + (l:dg * l:dg) + (l:db * l:db)
			if l:dgrey < l:drgb
				" Use the grey
				return <SID>grey_colour(l:gx)
			else
				" Use the colour
				return <SID>rgb_colour(l:x, l:y, l:z)
			endif
		else
			" Only one possibility
			return <SID>rgb_colour(l:x, l:y, l:z)
		endif
	endfun

	" Returns the palette index to approximate the 'rrggbb' hex string
	fun <SID>rgb(rgb)
		let l:r = ("0x" . strpart(a:rgb, 0, 2)) + 0
		let l:g = ("0x" . strpart(a:rgb, 2, 2)) + 0
		let l:b = ("0x" . strpart(a:rgb, 4, 2)) + 0

		return <SID>colour(l:r, l:g, l:b)
	endfun

	" Sets the highlighting for the given group
	fun <SID>X(group, fg, bg, attr)
		if a:fg != ""
			exec "hi " . a:group . " guifg=#" . a:fg . " ctermfg=" . <SID>rgb(a:fg)
		endif
		if a:bg != ""
			exec "hi " . a:group . " guibg=#" . a:bg . " ctermbg=" . <SID>rgb(a:bg)
		endif
		if a:attr != ""
			exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
		endif
	endfun

	" Vim Highlighting
	call <SID>X("Normal", s:foreground, s:background, "")
	call <SID>X("LineNr", s:lineNr, "", "")
	call <SID>X("NonText", s:lineNr, "", "")
	call <SID>X("SpecialKey", s:selection, "", "")
	call <SID>X("Search", s:background, s:yellow, "")
	call <SID>X("CurSearch", s:background, s:yellow, "")
	call <SID>X("TabLine", s:lineNr, s:window, "")
	call <SID>X("TabLineFill", s:foreground, s:window, "")
	call <SID>X("TabLineSel", s:foreground, s:window, "none")
	call <SID>X("StatusLine", s:window, s:foreground, "reverse")
	call <SID>X("StatusLineNC", s:window, s:lineNr, "reverse")
	call <SID>X("StatusLineError", s:window, s:red, "reverse")
	call <SID>X("StatusLineWarn", s:window, s:yellow, "reverse")
	call <SID>X("StatusLineInfo", s:window, s:blue, "reverse")
	call <SID>X("StatusLineHint", s:window, s:comment, "reverse")
	call <SID>X("VertSplit", s:lineNr, s:background, "none")
	call <SID>X("WinSeparator", s:lineNr, s:background, "none")
	call <SID>X("Visual", "", s:selection, "")
	call <SID>X("Directory", s:blue, "", "")
	call <SID>X("ModeMsg", s:green, "", "")
	call <SID>X("MoreMsg", s:green, "", "")
	call <SID>X("Question", s:green, "", "")
	call <SID>X("WarningMsg", s:yellow, "", "")
	call <SID>X("ErrorMsg", s:red, "", "")
	call <SID>X("MatchParen", "", s:selection, "")
	call <SID>X("Folded", s:comment, s:background, "")
	call <SID>X("FoldColumn", "", s:background, "")
	call <SID>X("QuickFixLine", s:aqua, "", "")
	if version >= 700
		call <SID>X("CursorLine", "", s:line, "none")
		call <SID>X("CursorLineNr", s:cursorLineNr, s:line, "")
		call <SID>X("CursorColumn", "", s:line, "none")
		call <SID>X("PMenu", s:foreground, s:selection, "none")
		call <SID>X("PMenuSel", s:foreground, s:selection, "reverse")
		call <SID>X("PMenuSbar", s:foreground, s:selection, "none")
		call <SID>X("PMenuThumb", s:foreground, s:selection, "reverse")
		call <SID>X("SignColumn", "", s:background, "none")
	end
	if version >= 703
		call <SID>X("ColorColumn", "", s:line, "none")
	end

	" Diagnostics
	call <SID>X("DiagnosticUnderlineError", "", "", "undercurl")
	call <SID>X("DiagnosticUnderlineWarn", "", "", "undercurl")
	call <SID>X("DiagnosticUnderlineInfo", "", "", "undercurl")
	call <SID>X("DiagnosticUnderlineHint", "", "", "undercurl")
	call <SID>X("DiagnosticUnderlineOk", "", "", "undercurl")

	" Standard Highlighting
	call <SID>X("Comment", s:comment, "", "italic")
	call <SID>X("Todo", s:comment, "", "bold")
	call <SID>X("Title", s:comment, "", "")
	call <SID>X("Identifier", s:blue, "", "none")
	call <SID>X("Statement", s:purple, "", s:keyword_style)
	call <SID>X("Conditional", s:foreground, "", "")
	call <SID>X("Delimiter", s:foreground, "", "")
	call <SID>X("Keyword", s:purple, "", s:keyword_style)
	call <SID>X("Repeat", s:foreground, "", "")
	call <SID>X("Structure", s:blue, "", "")
	call <SID>X("Function", s:yellow, "", "")
	call <SID>X("Constant", s:blue, "", "")
	call <SID>X("Number", s:green, "", "")
	call <SID>X("Boolean", s:blue, "", "")
	call <SID>X("String", s:orange, "", "")
	call <SID>X("Character", s:orange, "", "")
	call <SID>X("Special", s:yellow, "", "")
	call <SID>X("PreProc", s:purple, "", s:keyword_style)
	call <SID>X("Operator", s:foreground, "", "none")
	call <SID>X("Type", s:aqua, "", "none")
	call <SID>X("Define", s:purple, "", s:keyword_style)
	call <SID>X("Include", s:purple, "", s:keyword_style)

	" Treesitter
	call <SID>X("@variable", s:foreground, "", "")

	" Vim Highlighting
	call <SID>X("vimCommand", s:purple, "", s:keyword_style)
	call <SID>X("vimVar", s:foreground, "", "")

	" C Highlighting
	call <SID>X("cType", s:blue, "", "")
	call <SID>X("cStorageClass", s:blue, "", "")
	call <SID>X("cConditional", s:purple, "", s:keyword_style)
	call <SID>X("cRepeat", s:purple, "", s:keyword_style)

	" C# Highlighting
	call <SID>X("csAccessModifier", s:purple, "", s:keyword_style)
	call <SID>X("csModifier", s:purple, "", s:keyword_style)
	call <SID>X("csClass", s:purple, "", s:keyword_style)
	call <SID>X("csType", s:blue, "", "")

	" PHP Highlighting
	call <SID>X("phpVarSelector", s:red, "", "")
	call <SID>X("phpKeyword", s:purple, "", "")
	call <SID>X("phpRepeat", s:purple, "", "")
	call <SID>X("phpConditional", s:purple, "", "")
	call <SID>X("phpStatement", s:purple, "", "")
	call <SID>X("phpMemberSelector", s:foreground, "", "")

	" Ruby Highlighting
	call <SID>X("rubySymbol", s:green, "", "")
	call <SID>X("rubyConstant", s:yellow, "", "")
	call <SID>X("rubyAttribute", s:blue, "", "")
	call <SID>X("rubyInclude", s:blue, "", "")
	call <SID>X("rubyLocalVariableOrMethod", s:orange, "", "")
	call <SID>X("rubyCurlyBlock", s:orange, "", "")
	call <SID>X("rubyStringDelimiter", s:green, "", "")
	call <SID>X("rubyInterpolationDelimiter", s:orange, "", "")
	call <SID>X("rubyConditional", s:purple, "", "")
	call <SID>X("rubyRepeat", s:purple, "", "")

	" Python Highlighting
	call <SID>X("pythonInclude", s:yellow, "", "")
	call <SID>X("pythonStatement", s:purple, "", s:keyword_style)
	call <SID>X("pythonConditional", s:purple, "", s:keyword_style)
	call <SID>X("pythonRepeat", s:purple, "", s:keyword_style)
	call <SID>X("pythonException", s:purple, "", s:keyword_style)
	call <SID>X("pythonFunction", s:yellow, "", "")
	call <SID>X("pythonBuiltin", s:yellow, "", "")

	" Go Highlighting
	call <SID>X("goStatement", s:purple, "", "")
	call <SID>X("goConditional", s:purple, "", "")
	call <SID>X("goRepeat", s:purple, "", "")
	call <SID>X("goException", s:purple, "", "")
	call <SID>X("goDeclaration", s:blue, "", "")
	call <SID>X("goConstants", s:yellow, "", "")
	call <SID>X("goBuiltins", s:orange, "", "")

	" CoffeeScript Highlighting
	call <SID>X("coffeeKeyword", s:purple, "", "")
	call <SID>X("coffeeConditional", s:purple, "", "")

	" JavaScript Highlighting
	call <SID>X("javaScriptBraces", s:foreground, "", "")
	call <SID>X("javaScriptFunction", s:purple, "", "")
	call <SID>X("javaScriptConditional", s:purple, "", "")
	call <SID>X("javaScriptRepeat", s:purple, "", "")
	call <SID>X("javaScriptNumber", s:orange, "", "")
	call <SID>X("javaScriptMember", s:orange, "", "")

	" HTML Highlighting
	call <SID>X("htmlTag", s:red, "", "")
	call <SID>X("htmlTagName", s:red, "", "")
	call <SID>X("htmlArg", s:red, "", "")
	call <SID>X("htmlScriptTag", s:red, "", "")

	" Diff Highlighting
	call <SID>X("diffAdded", "", "383e2a", "none")
	call <SID>X("diffRemoved", "", "4c1919", "none")
	call <SID>X("DiffAdd", "", "383e2a", "none")
	call <SID>X("DiffDelete", "", "4c1919", "none")
	call <SID>X("DiffChange", "", "303030", "none")
	call <SID>X("DiffText", "", "303030", "none")

	" ShowMarks Highlighting
	call <SID>X("ShowMarksHLl", s:orange, s:background, "none")
	call <SID>X("ShowMarksHLo", s:purple, s:background, "none")
	call <SID>X("ShowMarksHLu", s:yellow, s:background, "none")
	call <SID>X("ShowMarksHLm", s:aqua, s:background, "none")

	" Delete Functions
	delf <SID>X
	delf <SID>rgb
	delf <SID>colour
	delf <SID>rgb_colour
	delf <SID>rgb_level
	delf <SID>rgb_number
	delf <SID>grey_colour
	delf <SID>grey_level
	delf <SID>grey_number
endif
