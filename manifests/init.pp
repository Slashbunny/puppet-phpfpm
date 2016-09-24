#
# == Class: phpfpm
#
# Install and configure php-fpm
#
# === Parameters
#
# The puppet parameter names mirror the names in the php-fpm configuration file.
#
# See php-fpm.conf on your system or php-fpm.conf.erb in the templates folder
# for configuration details.
#
# Each parameter is documented extensively within the config.
#
# === Examples
#
# See README.md
#
class phpfpm (
  $ensure                      = 'present',
  $pools                       = undef,
  $poold_purge                 = $phpfpm::params::poold_purge,
  $package_name                = $phpfpm::params::package_name,
  $service_name                = $phpfpm::params::service_name,
  $config_dir                  = $phpfpm::params::config_dir,
  $config_name                 = $phpfpm::params::config_name,
  $config_template_file        = $phpfpm::params::config_template_file,
  $pool_dir                    = $phpfpm::params::pool_dir,
  $pid_file                    = $phpfpm::params::pid_file,
  $error_log                   = $phpfpm::params::error_log,
  $syslog_facility             = $phpfpm::params::syslog_facility,
  $syslog_ident                = $phpfpm::params::syslog_ident,
  $log_level                   = $phpfpm::params::log_level,
  $emergency_restart_threshold = $phpfpm::params::emergency_restart_threshold,
  $emergency_restart_interval  = $phpfpm::params::emergency_restart_interval,
  $process_control_timeout     = $phpfpm::params::process_control_timeout,
  $process_max                 = $phpfpm::params::process_max,
  $daemonize                   = $phpfpm::params::daemonize,
  $rlimit_files                = $phpfpm::params::rlimit_files,
  $rlimit_core                 = $phpfpm::params::rlimit_core,
  $restart_command             = $phpfpm::params::restart_command,
) inherits phpfpm::params {

  # Install package
  include 'phpfpm::package'

  # Create pools via hash instead of using phpfm::pool explicitly (optional)
  if $pools {
      create_resources('::phpfpm::pool', $pools)
  }

  # Manage service and configuration only if the package is present
  if $ensure != 'absent' {

    # Manage daemon
    include 'phpfpm::service'

    Class['phpfpm::package'] -> Class['phpfpm::service']

    file { $pool_dir:
      ensure => 'directory',
    }

    # Purge pool.d if necessary
    if $poold_purge == true {
      File[$pool_dir] {
        purge   => true,
        recurse => true,
        require => Class['phpfpm::package'],
      }
    }

    # Main php-fpm config file
    file { "${config_dir}/${config_name}":
      ensure  => 'present',
      content => template($config_template_file),
      notify  => Class['phpfpm::service'],
    }
  }
}

