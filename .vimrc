set term=pcansi
set t_co=256
let &t_AB="\e[48;5;%dm"
let &t_AF="\e[38;5;%dm"

execute pathogen#infect()
syntax on
filetype plugin indent on
