# vim-functions

A collection of Vim functions I don't want to hold in .vimrc

## CreatePHPClass

The `CreatePHPClass` function is a quick way to create a PHP class.

Call it as `CreatePHPClass Ham/Spam/Can` and it will create a new
`project_root/src/Ham/Spam/Can.php` file.

The contents of the file will be:

``` php
<?php
declare(strict_types=1);

namespace Ham\Spam;

class Can
{
    public function __construct()
    {
    }
}
```

It will also create the corresponding PHPUnit test file
`project_root/test/HamTest/Spam/CanTest.php`:

``` php
<?php
declare(strict_types=1);

namespace HamTest\Spam;

use Ham\Spam\Can;

class CanTest extends \PHPUnit_Framework_TestCase
{
    public function setup()
    {
    }
}
```
