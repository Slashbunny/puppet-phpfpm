#
# == Class: phpfpm::package
#
# Installs the php-fpm package. Do not use this class directly.
#
class phpfpm::package (
    $ensure       = 'present',
    $package_name = $phpfpm::params::package_name,
) inherits phpfpm::params
{
    package { $package_name:
        ensure => $ensure,
    }
}

