1   set tabstop=4
  1 set shiftwidth=4
  2 set softtabstop=4
  3 set number
  4 set relativenumber
  5 set ruler
  6 colorscheme industry
  7
  8 vmap J :m '>+1<CR>gv=gv
  9 vmap K :m '<-2<CR>gv=gv
 10
 11 " flash yanked text
 12 augroup highlightYankedText
 13     autocmd!
 14     autocmd TextYankPost * call FlashYankedText()
 15 augroup END
 16
 17 function! FlashYankedText()
 18     if (!exists('g:yankedTextMatches'))
 19         let g:yankedTextMatches = []
 20     endif
 21
 22     let matchId = matchadd('IncSearch', ".\\%>'\\[\\_.*\\%<']..")
 23     let windowId = winnr()
 24
 25     call add(g:yankedTextMatches, [windowId, matchId])
 26     call timer_start(100, 'DeleteTemporaryMatch')
 27 endfunction
 28
 29 function! DeleteTemporaryMatch(timerId)
 30     while !empty(g:yankedTextMatches)
 31         let match = remove(g:yankedTextMatches, 0)
 32         let windowID = match[0]
 33         let matchID = match[1]
 34
 35         try
 36             call matchdelete(matchID, windowID)
 37         endtry
 38     endwhile
 39 endfunction
