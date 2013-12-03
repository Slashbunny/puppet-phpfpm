# puppet-phpfpm

## Overview

This module manages the php-fpm daemon and pools **only**. Managing php, php extensions, pear, pecl, nginx, apache, etc are out of the scope of this module.

The module has only been tested on Ubuntu.

* `phpfpm` : Class that installs and configures php-fpm itself.
* `phpfpm::pool` : Definition used to configure a fpm pool

## Examples

Install php-fpm with default options and a default pool called 'www' (packaging defaults on Ubuntu).

```puppet
include phpfpm
```



