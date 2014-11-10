#
# == Class: phpfpm::service
#
# Manages the main php-fpm service. Do not initialize this class directly. Only
# use this class to notify php-fpm
#
class phpfpm::service {

  service { $::phpfpm::service_name:
    ensure     => 'running',
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    restart    => $::phpfpm::restart_command,
  }
}

