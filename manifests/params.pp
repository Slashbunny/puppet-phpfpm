#
# == Class: phpfpm::params
#
# Configuration for the phpfpm module. Do not use this class directly.
#
class phpfpm::params {

    case $::osfamily {
        'debian': {
            $package_name                = 'php5-fpm'
            $service_name                = 'php5-fpm'
            $config_dir                  = '/etc/php5/fpm'
            $config_name                 = 'php-fpm.conf'
            $pool_dir                    = '/etc/php5/fpm/pool.d'
            $pid_file                    = '/var/run/php5-fpm.pid'
            $error_log                   = '/var/log/php5-fpm.log'
            $syslog_facility             = 'daemon'
            $syslog_ident                = 'php-fpm'
            $log_level                   = 'notice'
            $emergency_restart_threshold = 0
            $emergency_restart_interval  = 0
            $process_control_timeout     = 0
            $process_max                 = 0
            $daemonize                   = 'yes'
            $rlimit_files                = undef
            $rlimit_core                 = undef
            $restart_command             = "service ${service_name} reload"
        }
        default: {
            fail( "Unsupported platform: ${::osfamily}" )
        }
    }
}
