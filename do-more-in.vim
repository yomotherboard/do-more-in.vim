nnoremap ci" :call DoMoreIn('"', "c", "i")<CR>
nnoremap ci` :call DoMoreIn('`', "c", "i")<CR>
nnoremap ci' :call DoMoreIn("'", "c", "i")<CR>
nnoremap di" :call DoMoreIn('"', "d", "i")<CR>
nnoremap di` :call DoMoreIn('`', "d", "i")<CR>
nnoremap di' :call DoMoreIn("'", "d", "i")<CR>
nnoremap yi" :call DoMoreIn('"', "y", "i")<CR>
nnoremap yi` :call DoMoreIn('`', "y", "i")<CR>
nnoremap yi' :call DoMoreIn("'", "y", "i")<CR>

nnoremap ca" :call DoMoreIn('"', "c", "a")<CR>
nnoremap ca` :call DoMoreIn('`', "c", "a")<CR>
nnoremap ca' :call DoMoreIn("'", "c", "a")<CR>
nnoremap da" :call DoMoreIn('"', "d", "a")<CR>
nnoremap da` :call DoMoreIn('`', "d", "a")<CR>
nnoremap da' :call DoMoreIn("'", "d", "a")<CR>
nnoremap ya" :call DoMoreIn('"', "y", "a")<CR>
nnoremap ya` :call DoMoreIn('`', "y", "a")<CR>
nnoremap ya' :call DoMoreIn("'", "y", "a")<CR>

" DoMoreIn(<character>, <function>, <motion>)
function DoMoreIn(c, f, m)
	let startpos = getcurpos()
	let startlen = col("$")-1
	execute "normal! " . a:f . a:m . a:c
	if startpos[2] == getcurpos()[2] && startlen == col("$")-1
		execute "normal! 2F" . a:c . a:f . a:m . a:c
	endif
	if startpos[2] == getcurpos()[2]
		if line(".") == line("$")-1
			echom "out of luck boss"
			return 1
		endif
		normal! j
		call DoMoreIn(a:c, a:f, a:m)
	endif
endfunction
