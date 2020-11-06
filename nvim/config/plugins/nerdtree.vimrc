" Settings to tweak the NERDTree configuration.

let g:NERDTreeQuitOnOpen=3  " Close the window after opening a file.
let g:NERDTreeShowLineNumbers=1  " Show Line Numbers in the NERDTree window
let g:NERDTreeNaturalSort=1  " Sort using natural numbers, i.e. 1.txt, 2.txt, 10.txt

" Try putting dirs after files in NERDTree view
" See :h NERDTreeSortOrder for more info
let g:NERDTreeSortOrder=['*', '\.swp$',  '\.bak$', '\~$', '\/$']

" Experiment with this to see how things look.
" let NERDTreeNodeDelimiter="\x07"     "bell
" let g:NERDTreeNodeDelimiter="\u00b7"   "middle dot
" let NERDTreeNodeDelimiter="\u00a0"   "non-breaking space
" let NERDTreeNodeDelimiter="😀"       "smiley face

" whether or not to show the nerdtree brackets around flags
let g:webdevicons_conceal_nerdtree_brackets = 0
