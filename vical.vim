function GetVisualSelection()
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

function VicalProcessVisualSelect()
    let selected = GetVisualSelection()
    let res = system('echo "' . selected . '" | bc -l')
    return trim(res)

    "
endfunction

function VicalResult()
    let result = VicalProcessVisualSelect()

    " 1. This escsape visual mode and print result into a new line 
    " execute "normal! i" . result . "\<Esc>"

    " 2. The complicated way:
    "   - save cursor position, 
    "   - go to norm
    "   - move cursor to saved position
    "   - print result 
    let save_pos = getpos(".")
    echo save_pos
    call setpos('.', save_pos)
    execute "normal! i \<Esc>"
    " execute "normal! i" . result . "\<Esc>"
    
    " 3. NOTE: maybe yank the result into the default register might be more
    "convenient here
    " execute "i " . res . "normal!"
endfunction

xmap <silent> u :call VicalResult()<CR>

let selected = '( 2.43*1.643 )'

