function! GetVisualSelection()
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction

" Escape special characters in a string for exact matching.
" This is useful to copying strings from the file to the search tool
" Based on this - http://peterodding.com/code/vim/profile/autoload/xolox/escape.vim
function! EscapeString (string)
  let string=a:string
  " Escape regex characters
  let string = escape(string, '^$.*\/~[]')
  " Escape the line endings
  let string = substitute(string, '\n', '\\n', 'g')
  return string
endfunction

function! ViscalCalc()
    let selected = GetVisualSelection()
    let result = trim(system('echo "' . selected . '" | bc -l'))
    " A bit of magic, also this is evidence that VimL is very primitive.
    "
    " '%s                              -> perform a search and replace
    "   /\%V'                          -> limit search to only selected section
    "       .                          -> concat
    "           EscapeString(selected) -> search for selected text
    "       . '/' .                    -> concat
    "           result                 -> replace selected text with command output
    "           .  '/'                 -> conclude text search
    execute '%s/\%V' . EscapeString(selected) . '/' . result . '/'
endfunction


xmap <silent> t :call ViscalCalc()<CR>
