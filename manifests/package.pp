#
# == Class: phpfpm::package
#
# Installs the php-fpm package. Do not use this class directly.
#
class phpfpm::package {

  package { $::phpfpm::package_name:
    ensure => $::phpfpm::ensure,
  }
}

