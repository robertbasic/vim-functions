import os

def get_file_path(name):
    root_path = os.getcwd()

    return "%s/src/%s.php" % (root_path, name)

def get_test_path(name):
    root_path = os.getcwd()

    return "%s/test/%s.php" % (root_path, name)

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

def write_test_file(file_path, namespace, class_name):
    lines = [
        "<?php\n",
        "declare(strict_types=1);\n\n",
        "namespace %s;\n\n" % (namespace),
        "use %s\%s;\n\n" % (namespace.replace('Test', ''), class_name.replace('Test', '')),
        "class %s extends \\PHPUnit_Framework_TestCase\n{\n" % (class_name),
        "    public function setup()\n    {\n    }\n}\n"
    ]

    fp = open(file_path, 'a')
    for line in lines:
        fp.write(line)
    fp.close()


def create_php_class(name):
    file_path = get_file_path(name)

    if not can_create_file(file_path):
        return file_path

    name_parts = name.split("/")
    class_name = name_parts.pop()
    namespace = "\\".join(name_parts)

    write_php_file(file_path, namespace, class_name)

    return file_path

def create_test_class(name):
    name_parts = name.split("/")
    name_parts[0] = '%sTest' % name_parts[0]
    name_parts[-1] = '%sTest' % name_parts[-1]
    name = '/'.join(name_parts)

    test_path = get_test_path(name)

    if not can_create_file(test_path):
        return test_path

    name_parts = name.split('/')
    class_name = '%s' % name_parts.pop()
    namespace = "\\".join(name_parts)

    write_test_file(test_path, namespace, class_name)

    return test_path
