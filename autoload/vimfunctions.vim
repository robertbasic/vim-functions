function! vimfunctions#VimFunctionsCreatePHPClass(name)
python3 << endpython3
import vim
from vimfunctions import create_php_class

if __name__ == '__main__':
    name = vim.eval("a:name")
    file_path = create_php_class.create_php_class(name)
    test_file_path = create_php_class.create_test_class(name)

    if file_path:
        vim.command("e %s" % (file_path))
        vim.command("vsplit %s" % (test_file_path))

endpython3
endfunction

function! vimfunctions#SetupPyImports()
python3 << endpython3
import os
import sys
import vim

python_plugin_path_loaded = int(vim.eval('exists("g:vimfunctions_plugin_path_loaded")'))

if python_plugin_path_loaded == 0:
    vim.command("let g:vimfunctions_plugin_path_loaded=1")

    plugin_path = vim.eval("g:vimfunctions_plugin_path")
    python_plugin_path = os.path.abspath('%s/../lib' % (plugin_path))
    sys.path.append(python_plugin_path)

endpython3
endfunction
