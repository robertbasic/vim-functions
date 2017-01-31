function! vimfunctions#vimfunctionsCreatePHPClass(name)
python3 << endpython3
import vim
import os
import re

def get_file_path(name):
    root_path = vim.eval("getbufvar('%', 'rootDir')")
    current_path = vim.eval("expand('%:p:h')")

    if root_path == '':
        root_path = current_path

    return "%s/src/%s.php" % (root_path, name)

def can_create_file(file_path):
    if os.path.exists(file_path) and os.path.isfile(file_path):
        print("%s already exists" % (file_path))
        return False

    directory = os.path.dirname(file_path)

    if not os.path.exists(directory) or not os.path.isdir(directory):
        print("%s is not a directory" % (directory))
        return False

    return True


def write_php_file(file_path, namespace, class_name):
    lines = [
        "<?php\n",
        "declare(strict_types=1);\n\n",
        "namespace %s;\n\n" % (namespace),
        "class %s\n{\n" % (class_name),
        "    public function __construct()\n    {\n    }\n}\n"
    ]

    fp = open(file_path, 'a')
    for line in lines:
        fp.write(line)
    fp.close()

def create_php_class():
    name = vim.eval("a:name")

    file_path = get_file_path(name)

    if not can_create_file(file_path):
        return False

    name_parts = name.split("/")
    class_name = name_parts.pop()
    namespace = "\\".join(name_parts)

    write_php_file(file_path, namespace, class_name)

    return file_path

if __name__ == '__main__':
    file_path = create_php_class()

    if file_path:
        vim.command("e %s" % (file_path))

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
