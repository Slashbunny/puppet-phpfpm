#
# == Class: phpfpm::service
#
# Manages the main php-fpm service. Do not initialize this class directly. Only
# use this class to notify php-fpm
#
class phpfpm::service (
    $restart_command = $phpfpm::params::restart_command,
    $service_name    = $phpfpm::params::service_name,
) inherits phpfpm::params
{
    service { $service_name:
        ensure     => 'running',
        enable     => true,
        hasstatus  => true,
        hasrestart => true,
        restart    => $restart_command,
    }
}

