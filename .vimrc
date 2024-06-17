set tabstop=4
set shiftwidth=4
set softtabstop=4
set number
set relativenumber
set ruler
colorscheme industry

vmap J :m '>+1<CR>gv=gv
vmap K :m '<-2<CR>gv=gv

" flash yanked text
augroup highlightYankedText
    autocmd!
    autocmd TextYankPost * call FlashYankedText()
augroup END

function! FlashYankedText()
    if (!exists('g:yankedTextMatches'))
        let g:yankedTextMatches = []
    endif

    let matchId = matchadd('IncSearch', ".\\%>'\\[\\_.*\\%<']..")
    let windowId = winnr()

    call add(g:yankedTextMatches, [windowId, matchId])
    call timer_start(100, 'DeleteTemporaryMatch')
endfunction

function! DeleteTemporaryMatch(timerId)
    while !empty(g:yankedTextMatches)
        let match = remove(g:yankedTextMatches, 0)
        let windowID = match[0]
        let matchID = match[1]

        try
            call matchdelete(matchID, windowID)
        endtry
    endwhile
endfunction
