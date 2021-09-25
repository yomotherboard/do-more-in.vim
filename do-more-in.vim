nnoremap ci( :call DoMoreInBrackets("\(", "c", "i")<CR>
nnoremap di( :call DoMoreInBrackets("\(", "d", "i")<CR>
nnoremap yi( :call DoMoreInBrackets("\(", "y", "i")<CR>
nnoremap ci[ :call DoMoreInBrackets("[", "c", "i")<CR>
nnoremap di[ :call DoMoreInBrackets("[", "d", "i")<CR>
nnoremap yi[ :call DoMoreInBrackets("[", "y", "i")<CR>
nnoremap ci{ :call DoMoreInBrackets("{", "c", "i")<CR>
nnoremap di{ :call DoMoreInBrackets("{", "d", "i")<CR>
nnoremap yi{ :call DoMoreInBrackets("{", "y", "i")<CR>

" TODO: give open and closing brackets different behaviors
nnoremap ci) :call DoMoreInBrackets("\(", "c", "i")<CR>
nnoremap di) :call DoMoreInBrackets("\(", "d", "i")<CR>
nnoremap yi) :call DoMoreInBrackets("\(", "y", "i")<CR>
nnoremap ci] :call DoMoreInBrackets("[", "c", "i")<CR>
nnoremap di] :call DoMoreInBrackets("[", "d", "i")<CR>
nnoremap yi] :call DoMoreInBrackets("[", "y", "i")<CR>
nnoremap ci} :call DoMoreInBrackets("{", "c", "i")<CR>
nnoremap di} :call DoMoreInBrackets("{", "d", "i")<CR>
nnoremap yi} :call DoMoreInBrackets("{", "y", "i")<CR>

nnoremap ci" :call DoMoreInQuotes('"', "c", "i")<CR>
nnoremap ci` :call DoMoreInQuotes('`', "c", "i")<CR>
nnoremap ci' :call DoMoreInQuotes("'", "c", "i")<CR>
nnoremap di" :call DoMoreInQuotes('"', "d", "i")<CR>
nnoremap di` :call DoMoreInQuotes('`', "d", "i")<CR>
nnoremap di' :call DoMoreInQuotes("'", "d", "i")<CR>
nnoremap yi" :call DoMoreInQuotes('"', "y", "i")<CR>
nnoremap yi` :call DoMoreInQuotes('`', "y", "i")<CR>
nnoremap yi' :call DoMoreInQuotes("'", "y", "i")<CR>

nnoremap ca" :call DoMoreInQuotes('"', "c", "a")<CR>
nnoremap ca` :call DoMoreInQuotes('`', "c", "a")<CR>
nnoremap ca' :call DoMoreInQuotes("'", "c", "a")<CR>
nnoremap da" :call DoMoreInQuotes('"', "d", "a")<CR>
nnoremap da` :call DoMoreInQuotes('`', "d", "a")<CR>
nnoremap da' :call DoMoreInQuotes("'", "d", "a")<CR>
nnoremap ya" :call DoMoreInQuotes('"', "y", "a")<CR>
nnoremap ya` :call DoMoreInQuotes('`', "y", "a")<CR>
nnoremap ya' :call DoMoreInQuotes("'", "y", "a")<CR>

" DoMoreIn(<character>, <function>, <motion>)
function DoMoreInQuotes(c, f, m)
	"start data
	let startpos = getcurpos()
	let startlen = col("$")-1

	" try normal execution
	execute "normal! " . a:f . a:m . a:c

	" try to execute <function> left of cursor if line length is unchanged
	if startpos[2] == getcurpos()[2] && startlen == col("$")-1
		"let startchar = matchstr(getline('.'), '\%' . col('.') . 'c.')
		execute "normal! 2F" . a:c . a:f . a:m . a:c
		" edge case if cursor is on a asterisk/backtick/etc
		" <-- handle edge case -->
	else
		" if line length has changed then return success
		return 0
	endif

	" recursively move down until the end of the file
	if startpos[2] == getcurpos()[2]
		if line(".") == line("$")-1
			echom "out of luck boss"
			return 1
		endif
		normal! j
		call DoMoreInQuotes(a:c, a:f, a:m)
	endif

	" TODO: return to initial position if command reaches EOF
	" TODO: jump to next set of non-empty quotes if executed inside of
	" empty quotes
endfunction

" for characters where jumping to next block not native
function DoMoreInBrackets(c, f, m)
	"start data
	let startpos = getcurpos()
	let startlen = col("$")-1

	" try normal execution
	execute "normal! " . a:f . a:m . a:c

	" if line length and cursor position are unchanged move to next
	" <character> and retry
	if startpos[2] == getcurpos()[2] && startlen == col("$")-1
		exec "normal! f" . a:c
		execute "normal! " . a:f . a:m . a:c
		" edge case if cursor is on a bracket/parenthesis/etc
		" <-- handle edge case -->
	else
		return 0
	endif


	" execute <function> left of cursor if possible
	if startpos[2] == getcurpos()[2] && startlen == col("$")-1
		execute "normal! F" . a:c . a:f . a:m . a:c
	else
		return 0
	endif

	" recursively move down until the end of the file
	if startpos[2] == getcurpos()[2]
		if line(".") == line("$")-1
			echom "out of luck boss"
			return 1
		endif
		normal! j
		call DoMoreInBrackets(a:c, a:f, a:m)
	endif

	" TODO: return to initial position if command reaches EOF
endfunction
