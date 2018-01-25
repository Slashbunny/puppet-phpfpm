#
# == Class: phpfpm::package
#
# Installs the php-fpm package. Do not use this class directly.
#
class phpfpm::package {

  package { 'php-fpm':
    ensure =>  $::phpfpm::ensure,
    name   =>  $::phpfpm::package_name,
  }
}

