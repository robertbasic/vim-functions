if exists('g:vimfunctions_plugin_loaded') || &cp
    finish
endif
let g:vimfunctions_plugin_loaded = 1

let g:vimfunctions_plugin_path = expand('<sfile>:p:h')

" A command to call
command! -nargs=1 CreatePHPClass call vimfunctions#vimfunctionsCreatePHPClass(<f-args>)
