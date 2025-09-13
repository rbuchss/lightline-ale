let s:indicator_infos = get(g:, 'lightline#ale#indicator_infos', 'I: ')
let s:indicator_warnings = get(g:, 'lightline#ale#indicator_warnings', 'W: ')
let s:indicator_errors = get(g:, 'lightline#ale#indicator_errors', 'E: ')
let s:indicator_ok = get(g:, 'lightline#ale#indicator_ok', 'OK')
let s:indicator_checking = get(g:, 'lightline#ale#indicator_checking', 'Linting...')

" Optional left and right padding to add to the indicator.
" This is useful when using wider indicator characters that
" collide with the count numbers.
" E.g.       etc
"
let s:indicator_left_pad_infos = get(g:, 'lightline#ale#indicator_left_pad_infos', '')
let s:indicator_left_pad_warnings = get(g:, 'lightline#ale#indicator_left_pad_warnings', '')
let s:indicator_left_pad_errors = get(g:, 'lightline#ale#indicator_left_pad_errors', '')
let s:indicator_left_pad_ok = get(g:, 'lightline#ale#indicator_left_pad_ok', '')
let s:indicator_left_pad_checking = get(g:, 'lightline#ale#indicator_left_pad_checking', '')

let s:indicator_right_pad_infos = get(g:, 'lightline#ale#indicator_right_pad_infos', '')
let s:indicator_right_pad_warnings = get(g:, 'lightline#ale#indicator_right_pad_warnings', '')
let s:indicator_right_pad_errors = get(g:, 'lightline#ale#indicator_right_pad_errors', '')
let s:indicator_right_pad_ok = get(g:, 'lightline#ale#indicator_right_pad_ok', '')
let s:indicator_right_pad_checking = get(g:, 'lightline#ale#indicator_right_pad_checking', '')

""""""""""""""""""""""
" Lightline components

function! lightline#ale#infos() abort
  if !lightline#ale#linted()
    return ''
  endif
  let l:counts = ale#statusline#Count(bufnr(''))
  return l:counts.info == 0 ? '' : printf(
    \   '%s%s%s%d',
    \   s:indicator_left_pad_infos,
    \   s:indicator_infos,
    \   s:indicator_right_pad_infos,
    \   l:counts.info
    \ )
endfunction

function! lightline#ale#warnings() abort
  if !lightline#ale#linted()
    return ''
  endif
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_warnings = l:counts.warning + l:counts.style_warning
  return l:all_warnings == 0 ? '' : printf(
    \   '%s%s%s%d',
    \   s:indicator_left_pad_warnings,
    \   s:indicator_warnings,
    \   s:indicator_right_pad_warnings,
    \   l:all_warnings
    \ )
endfunction

function! lightline#ale#errors() abort
  if !lightline#ale#linted()
    return ''
  endif
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  return l:all_errors == 0 ? '' : printf(
    \   '%s%s%s%d',
    \   s:indicator_left_pad_errors,
    \   s:indicator_errors,
    \   s:indicator_right_pad_errors,
    \   l:all_errors
    \ )
endfunction

function! lightline#ale#ok() abort
  if !lightline#ale#linted()
    return ''
  endif
  let l:counts = ale#statusline#Count(bufnr(''))
  return l:counts.total == 0 ? '' : printf(
    \   '%s%s%s',
    \   s:indicator_left_pad_ok,
    \   s:indicator_ok,
    \   s:indicator_right_pad_ok
    \ )
endfunction

function! lightline#ale#checking() abort
  return ale#engine#IsCheckingBuffer(bufnr(''))
    \ ? printf(
    \   '%s%s%s',
    \   s:indicator_left_pad_checking,
    \   s:indicator_checking,
    \   s:indicator_right_pad_checking
    \ )
    \ : ''
endfunction


""""""""""""""""""
" Helper functions

function! lightline#ale#linted() abort
  return get(g:, 'ale_enabled', 0) == 1
    \ && getbufvar(bufnr(''), 'ale_enabled', 1)
    \ && getbufvar(bufnr(''), 'ale_linted', 0) > 0
    \ && ale#engine#IsCheckingBuffer(bufnr('')) == 0
endfunction
