" FILE:     plugin/conque_term.vim {{{
" AUTHOR:   Nico Raffo <nicoraffo@gmail.com>
" MODIFIED: 2010-05-27
" VERSION:  1.1, for Vim 7.0
" LICENSE:
" Conque - pty interaction in Vim
" Copyright (C) 2009-2010 Nico Raffo 
"
" MIT License
" 
" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to deal
" in the Software without restriction, including without limitation the rights
" to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
" copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:
" 
" The above copyright notice and this permission notice shall be included in
" all copies or substantial portions of the Software.
" 
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
" OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
" THE SOFTWARE.
" }}}

" See docs/conque_term.txt for help or type :help conque_term

if exists('g:Term_Loaded') || v:version < 700
    finish
endif

" **********************************************************************************************************
" **** CONFIG **********************************************************************************************
" **********************************************************************************************************

" Choose key mapping to leave insert mode {{{
" If you choose something other than '<Esc>', then <Esc> will be sent to terminal
" Using a different key will usually fix Alt/Meta key issues
if !exists('g:Term_EscKey')
    let g:Term_EscKey = '<Esc>'
endif " }}}

" Enable color. {{{
" If your apps use a lot of color it will slow down the shell.
if !exists('g:Term_Color')
    let g:Term_Color = 1
endif " }}}

" TERM environment setting {{{
if !exists('g:Term_TERM')
    let g:Term_TERM =  'vt100'
endif " }}}

" Syntax for your buffer {{{
if !exists('g:Term_Syntax')
    let g:Term_Syntax = 'conque_term'
endif " }}}

" Keep on updating the shell window after you've switched to another buffer {{{
if !exists('g:Term_ReadUnfocused')
    let g:Term_ReadUnfocused = 0
endif " }}}

" Use this regular expression to highlight prompt {{{
if !exists('g:Term_PromptRegex')
    let g:Term_PromptRegex = '^\w\+@[0-9A-Za-z_.-]\+:[0-9A-Za-z_./\~,:-]\+\$'
endif " }}}

" Allow user to use <C-w> keys to switch window in insert mode. {{{
if !exists('g:Term_CWInsert')
    let g:Term_CWInsert = 0
endif " }}}

" **********************************************************************************************************
" **** Startup *********************************************************************************************
" **********************************************************************************************************

" Startup {{{

let g:Term_Loaded = 1
let g:Term_Idx = 1

command! -nargs=+ -complete=shellcmd Term call conque_term#open(<q-args>)
command! -nargs=+ -complete=shellcmd Termsplit call conque_term#open(<q-args>, ['belowright split'])
command! -nargs=+ -complete=shellcmd Termvsplit call conque_term#open(<q-args>, ['belowright vsplit'])
command! -nargs=+ -complete=shellcmd Termtab call conque_term#open(<q-args>, ['tabnew'])

" }}}

