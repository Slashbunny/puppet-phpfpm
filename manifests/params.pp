#
# == Class: phpfpm::params
#
# Configuration for the phpfpm module. Do not use this class directly.
#
class phpfpm::params {

  # Module configuration defaults
  $poold_purge    = false
  $manage_package = true

  case $::osfamily {
    'debian': {
      $ensure = 'present'

      # Service configuration defaults
      # Ubuntu Bionic and above ship php 7.2
      if $facts['os']['name'] == 'Ubuntu' and '18' in String($facts['os']['release']['major']) {
        $package_name                   = 'php7.2-fpm'
        $service_name                   = 'php7.2-fpm'
        $config_dir                     = '/etc/php/7.2/fpm'
        $pid_file                       = '/var/run/php/php7.2-fpm.pid'
        $error_log                      = '/var/log/php7.2-fpm.log'
      # Ubuntu Artful and above ship php 7.1
      } elsif $facts['os']['name'] == 'Ubuntu' and '17' in String($facts['os']['release']['major']) {
        $package_name                   = 'php7.1-fpm'
        $service_name                   = 'php7.1-fpm'
        $config_dir                     = '/etc/php/7.1/fpm'
        $pid_file                       = '/var/run/php/php7.1-fpm.pid'
        $error_log                      = '/var/log/php7.1-fpm.log'
      # Ubuntu Xenial and above ship with php7 not php5
      } elsif $facts['os']['name'] == 'Ubuntu' and '16' in String($facts['os']['release']['major']) {
        $package_name                   = 'php7.0-fpm'
        $service_name                   = 'php7.0-fpm'
        $config_dir                     = '/etc/php/7.0/fpm'
        $pid_file                       = '/var/run/php/php7.0-fpm.pid'
        $error_log                      = '/var/log/php7.0-fpm.log'
      # Debian buster is ship with php7.3
      } elsif $facts['os']['name'] == 'Debian' and '10' in String($facts['os']['release']['major']) {
        $package_name                   = 'php7.3-fpm'
        $service_name                   = 'php7.3-fpm'
        $config_dir                     = '/etc/php/7.3/fpm'
        $pid_file                       = '/run/php/php7.3-fpm.pid'
        $error_log                      = '/var/log/php7.3-fpm.log'
      # Debian stretch and above ship with php7 not php5
      } elsif $facts['os']['name'] == 'Debian' and '9' in String($facts['os']['release']['major']) {
        $package_name                   = 'php7.0-fpm'
        $service_name                   = 'php7.0-fpm'
        $config_dir                     = '/etc/php/7.0/fpm'
        $pid_file                       = '/run/php/php7.0-fpm.pid'
        $error_log                      = '/var/log/php7.0-fpm.log'
      } else {
        $package_name                   = 'php5-fpm'
        $service_name                   = 'php5-fpm'
        $config_dir                     = '/etc/php5/fpm'
        case $::operatingsystem {
          'Debian':         { $pid_file = '/run/php5-fpm.pid' }
          default:          { $pid_file = '/var/run/php5-fpm.pid' }
        }
        $error_log                      = '/var/log/php5-fpm.log'
      }
      $config_name                    = 'php-fpm.conf'
      $config_user                    = 'root'
      $config_group                   = 'root'
      $config_template_file           = 'phpfpm/php-fpm.conf.erb'
      $pool_dir                       = "${config_dir}/pool.d"
      $syslog_facility                = 'daemon'
      $syslog_ident                   = 'php-fpm'
      $log_level                      = 'notice'
      $emergency_restart_threshold    = 0
      $emergency_restart_interval     = 0
      $process_control_timeout        = 0
      $process_max                    = 0
      $daemonize                      = 'yes'
      $rlimit_files                   = undef
      $rlimit_core                    = undef
      $restart_command                = "service ${service_name} reload"

      # Pool configuration defaults
      $pool_template_file             = 'phpfpm/pool.conf.erb'
      $pool_user                      = 'www-data'
      $pool_group                     = 'www-data'
      $pool_listen                    = '127.0.0.1:9000'
      $pool_listen_backlog            = undef
      $pool_listen_owner              = undef
      $pool_listen_group              = undef
      $pool_listen_mode               = undef
      $pool_listen_allowed_clients    = undef
      $pool_pm                        = 'dynamic'
      $pool_pm_max_children           = 10
      $pool_pm_start_servers          = 4
      $pool_pm_min_spare_servers      = 2
      $pool_pm_max_spare_servers      = 6
      $pool_pm_process_idle_timeout   = undef
      $pool_pm_max_requests           = undef
      $pool_pm_status_path            = undef
      $pool_ping_path                 = undef
      $pool_ping_response             = undef
      $pool_access_log                = undef
      $pool_access_format             = undef
      $pool_slowlog                   = undef
      $pool_req_slowlog_timeout       = undef
      $pool_req_terminate_timeout     = undef
      $pool_rlimit_files              = undef
      $pool_rlimit_core               = undef
      $pool_chroot                    = undef
      $pool_chdir                     = '/'
      $pool_catch_workers_output      = undef
      $pool_security_limit_extensions = undef
      $pool_env                       = {}
      $pool_php_value                 = {}
      $pool_php_flag                  = {}
      $pool_php_admin_value           = {}
      $pool_php_admin_flag            = {}
    }
    'archlinux': {
      $ensure = 'present'

      # Service configuration defaults
      $package_name                   = 'php-fpm'
      $service_name                   = 'php-fpm'
      $config_dir                     = '/etc/php'
      $config_name                    = 'php-fpm.conf'
      $config_user                    = 'root'
      $config_group                   = 'root'
      $config_template_file           = 'phpfpm/php-fpm.conf.erb'
      $pool_dir                       = '/etc/php/fpm.d'
      $pid_file                       = '/run/php-fpm/php-fpm.pid'
      $error_log                      = '/var/log/php-fpm.log'
      $syslog_facility                = undef
      $syslog_ident                   = undef
      $log_level                      = 'notice'
      $emergency_restart_threshold    = 0
      $emergency_restart_interval     = 0
      $process_control_timeout        = 0
      $process_max                    = 0
      $daemonize                      = 'yes'
      $rlimit_files                   = undef
      $rlimit_core                    = undef
      $restart_command                = "systemctl reload ${service_name}"

      # Pool configuration defaults
      $pool_template_file             = 'phpfpm/pool.conf.erb'
      $pool_user                      = 'http'
      $pool_group                     = 'http'
      $pool_listen                    = '127.0.0.1:9000'
      $pool_listen_backlog            = undef
      $pool_listen_owner              = undef
      $pool_listen_group              = undef
      $pool_listen_mode               = undef
      $pool_listen_allowed_clients    = undef
      $pool_pm                        = 'dynamic'
      $pool_pm_max_children           = 10
      $pool_pm_start_servers          = 4
      $pool_pm_min_spare_servers      = 2
      $pool_pm_max_spare_servers      = 6
      $pool_pm_process_idle_timeout   = undef
      $pool_pm_max_requests           = undef
      $pool_pm_status_path            = undef
      $pool_ping_path                 = undef
      $pool_ping_response             = undef
      $pool_access_log                = undef
      $pool_access_format             = undef
      $pool_slowlog                   = undef
      $pool_req_slowlog_timeout       = undef
      $pool_req_terminate_timeout     = undef
      $pool_rlimit_files              = undef
      $pool_rlimit_core               = undef
      $pool_chroot                    = undef
      $pool_chdir                     = '/'
      $pool_catch_workers_output      = undef
      $pool_security_limit_extensions = undef
      $pool_env                       = {}
      $pool_php_value                 = {}
      $pool_php_flag                  = {}
      $pool_php_admin_value           = {}
      $pool_php_admin_flag            = {}
    }
    'redhat', 'linux': {
      $ensure = 'present'

      # Service configuration defaults
      $package_name                   = 'php-fpm'
      $service_name                   = 'php-fpm'
      $config_dir                     = '/etc'
      $config_name                    = 'php-fpm.conf'
      $config_user                    = 'root'
      $config_group                   = 'root'
      $config_template_file           = 'phpfpm/php-fpm.conf.erb'
      $pool_dir                       = '/etc/php-fpm.d'
      $pid_file                       = '/var/run/php-fpm/php-fpm.pid'
      $error_log                      = '/var/log/php-fpm/error.log'
      $syslog_facility                = 'daemon'
      $syslog_ident                   = 'php-fpm'
      $log_level                      = 'notice'
      $emergency_restart_threshold    = 0
      $emergency_restart_interval     = 0
      $process_control_timeout        = 0
      $process_max                    = 0
      $daemonize                      = 'yes'
      $rlimit_files                   = undef
      $rlimit_core                    = undef
      $restart_command                = "service ${service_name} reload"

      # Pool configuration defaults
      $pool_template_file             = 'phpfpm/pool.conf.erb'
      $pool_user                      = 'apache'
      $pool_group                     = 'apache'
      $pool_listen                    = '127.0.0.1:9000'
      $pool_listen_backlog            = undef
      $pool_listen_owner              = undef
      $pool_listen_group              = undef
      $pool_listen_mode               = undef
      $pool_listen_allowed_clients    = undef
      $pool_pm                        = 'dynamic'
      $pool_pm_max_children           = 10
      $pool_pm_start_servers          = 4
      $pool_pm_min_spare_servers      = 2
      $pool_pm_max_spare_servers      = 6
      $pool_pm_process_idle_timeout   = undef
      $pool_pm_max_requests           = undef
      $pool_pm_status_path            = undef
      $pool_ping_path                 = undef
      $pool_ping_response             = undef
      $pool_access_log                = undef
      $pool_access_format             = undef
      $pool_slowlog                   = undef
      $pool_req_slowlog_timeout       = undef
      $pool_req_terminate_timeout     = undef
      $pool_rlimit_files              = undef
      $pool_rlimit_core               = undef
      $pool_chroot                    = undef
      $pool_chdir                     = '/'
      $pool_catch_workers_output      = undef
      $pool_security_limit_extensions = undef
      $pool_env                       = {}
      $pool_php_value                 = {}
      $pool_php_flag                  = {}
      $pool_php_admin_value           = {}
      $pool_php_admin_flag            = {}
    }
    'openbsd': {
      $ensure = $::kernelversion ? {
        '6.2'   => '7.0.23',
        default => '%7',
      }

      # Service configuration defaults
      $package_name                   = 'php'
      $service_name                   = 'php70_fpm'
      $config_dir                     = '/etc'
      $config_name                    = 'php-fpm.conf'
      $config_user                    = 'root'
      $config_group                   = 'wheel'
      $config_template_file           = 'phpfpm/php-fpm.conf.erb'
      $pool_dir                       = "${config_dir}/php-fpm.d"
      $pid_file                       = 'run/php-fpm.pid'
      $error_log                      = 'log/php-fpm.log'
      $syslog_facility                = 'daemon'
      $syslog_ident                   = 'php-fpm'
      $log_level                      = 'notice'
      $emergency_restart_threshold    = 0
      $emergency_restart_interval     = 0
      $process_control_timeout        = 0
      $process_max                    = 0
      $daemonize                      = 'yes'
      $rlimit_files                   = undef
      $rlimit_core                    = undef
      $restart_command                = "rcctl restart ${service_name}"

      # Pool configuration defaults
      $pool_template_file             = 'phpfpm/pool.conf.erb'
      $pool_user                      = 'www'
      $pool_group                     = 'www'
      $pool_listen                    = '127.0.0.1:9000'
      $pool_listen_backlog            = undef
      $pool_listen_owner              = undef
      $pool_listen_group              = undef
      $pool_listen_mode               = undef
      $pool_listen_allowed_clients    = undef
      $pool_pm                        = 'dynamic'
      $pool_pm_max_children           = 10
      $pool_pm_start_servers          = 4
      $pool_pm_min_spare_servers      = 2
      $pool_pm_max_spare_servers      = 6
      $pool_pm_process_idle_timeout   = undef
      $pool_pm_max_requests           = undef
      $pool_pm_status_path            = undef
      $pool_ping_path                 = undef
      $pool_ping_response             = undef
      $pool_access_log                = undef
      $pool_access_format             = undef
      $pool_slowlog                   = undef
      $pool_req_slowlog_timeout       = undef
      $pool_req_terminate_timeout     = undef
      $pool_rlimit_files              = undef
      $pool_rlimit_core               = undef
      $pool_chroot                    = undef
      $pool_chdir                     = '/'
      $pool_catch_workers_output      = undef
      $pool_security_limit_extensions = undef
      $pool_env                       = {}
      $pool_php_value                 = {}
      $pool_php_flag                  = {}
      $pool_php_admin_value           = {}
      $pool_php_admin_flag            = {}
    }
    'freebsd': {
      $ensure = 'present'

      # Service configuration defaults
      $package_name                   = 'php70'
      $service_name                   = 'php-fpm'
      $config_dir                     = '/usr/local/etc'
      $config_name                    = 'php-fpm.conf'
      $config_user                    = 'root'
      $config_group                   = 'wheel'
      $config_template_file           = 'phpfpm/php-fpm.conf.erb'
      $pool_dir                       = "${config_dir}/php-fpm.d"
      $pid_file                       = '/var/run/php-fpm.pid'
      $error_log                      = '/var/log/php-fpm.log'
      $syslog_facility                = undef
      $syslog_ident                   = undef
      $log_level                      = 'notice'
      $emergency_restart_threshold    = 0
      $emergency_restart_interval     = 0
      $process_control_timeout        = 0
      $process_max                    = 0
      $daemonize                      = 'yes'
      $rlimit_files                   = undef
      $rlimit_core                    = undef
      $restart_command                = "service ${service_name} reload"

      # Pool configuration defaults
      $pool_template_file             = 'phpfpm/pool.conf.erb'
      $pool_user                      = 'www'
      $pool_group                     = 'www'
      $pool_listen                    = '127.0.0.1:9000'
      $pool_listen_backlog            = undef
      $pool_listen_owner              = undef
      $pool_listen_group              = undef
      $pool_listen_mode               = undef
      $pool_listen_allowed_clients    = undef
      $pool_pm                        = 'dynamic'
      $pool_pm_max_children           = 10
      $pool_pm_start_servers          = 4
      $pool_pm_min_spare_servers      = 2
      $pool_pm_max_spare_servers      = 6
      $pool_pm_process_idle_timeout   = undef
      $pool_pm_max_requests           = undef
      $pool_pm_status_path            = undef
      $pool_ping_path                 = undef
      $pool_ping_response             = undef
      $pool_access_log                = undef
      $pool_access_format             = undef
      $pool_slowlog                   = undef
      $pool_req_slowlog_timeout       = undef
      $pool_req_terminate_timeout     = undef
      $pool_rlimit_files              = undef
      $pool_rlimit_core               = undef
      $pool_chroot                    = undef
      $pool_chdir                     = '/'
      $pool_catch_workers_output      = undef
      $pool_security_limit_extensions = undef
      $pool_env                       = {}
      $pool_php_value                 = {}
      $pool_php_flag                  = {}
      $pool_php_admin_value           = {}
      $pool_php_admin_flag            = {}
    }
    default: {
      fail( "Unsupported platform: ${::osfamily}" )
    }
  }
}
