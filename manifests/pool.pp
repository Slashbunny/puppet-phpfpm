#
# == Class: phpfpm::pool
#
# Manage php-fpm pools
#
# === Parameters
#
# The puppet parameter name represents the name of the pool configuration file.
#
# You can either look at pool.conf.erb in the templates folder or look at the
# generated configuration on your system (for example in /etc/php5/fpm/pool.d/).
#
# Each parameter is documented extensively within the config.
#
# === Examples
#
# See README.md
#
define phpfpm::pool (
    $ensure                    = 'present',
    $user                      = $phpfpm::params::pool_user,
    $group                     = $phpfpm::params::pool_group,
    $listen                    = $phpfpm::params::pool_listen,
    $listen_backlog            = $phpfpm::params::pool_listen_backlog,
    $listen_owner              = $phpfpm::params::pool_listen_owner,
    $listen_group              = $phpfpm::params::pool_listen_group,
    $listen_mode               = $phpfpm::params::pool_listen_mode,
    $listen_allowed_clients    = $phpfpm::params::pool_listen_allowed_clients,
    $pm                        = $phpfpm::params::pool_pm,
    $pm_max_children           = $phpfpm::params::pool_pm_max_children,
    $pm_start_servers          = $phpfpm::params::pool_pm_start_servers,
    $pm_min_spare_servers      = $phpfpm::params::pool_pm_min_spare_servers,
    $pm_max_spare_servers      = $phpfpm::params::pool_pm_max_spare_servers,
    $pm_process_idle_timeout   = $phpfpm::params::pool_pm_process_idle_timeout,
    $pm_max_requests           = $phpfpm::params::pool_pm_max_requests,
    $pm_status_path            = $phpfpm::params::pool_pm_status_path,
    $ping_path                 = $phpfpm::params::pool_ping_path,
    $ping_response             = $phpfpm::params::pool_ping_response,
    $access_log                = $phpfpm::params::pool_access_log,
    $access_format             = $phpfpm::params::pool_access_format,
    $slowlog                   = $phpfpm::params::pool_slowlog,
    $request_slowlog_timeout   = $phpfpm::params::pool_req_slowlog_timeout,
    $request_terminate_timeout = $phpfpm::params::pool_req_terminate_timeout,
    $rlimit_files              = $phpfpm::params::pool_rlimit_files,
    $rlimit_core               = $phpfpm::params::pool_rlimit_core,
    $chroot                    = $phpfpm::params::pool_chroot,
    $chdir                     = $phpfpm::params::pool_chdir,
    $catch_workers_output      = $phpfpm::params::pool_catch_workers_output,
    $security_limit_extensions = $phpfpm::params::pool_sec_limit_extensions,
    $env                       = $phpfpm::params::pool_env,
    $php_value                 = $phpfpm::params::pool_php_value,
    $php_flag                  = $phpfpm::params::pool_php_flag,
    $php_admin_value           = $phpfpm::params::pool_php_admin_value,
    $php_admin_flag            = $phpfpm::params::pool_php_admin_flag,
    $service_name              = $phpfpm::params::service_name,
    $pool_dir                  = $phpfpm::params::pool_dir,
)
{
    $pool_file_path = "${pool_dir}/${name}.conf"

    if $pm_start_servers < $pm_min_spare_servers or
         $pm_start_servers > $pm_max_spare_servers {
        fail( "pm_start_servers(${pm_start_servers}) must not be less than \
pm_min_spare_servers(${pm_min_spare_servers}) and not greater than \
pm_max_spare_servers(${pm_max_spare_servers})" )
    }

    if $ensure == 'absent' {
        file { $pool_file_path:
            ensure => 'absent',
            notify => Service[$service_name],
        }
    }
    else {
        file { $pool_file_path:
            ensure   => 'present',
            owner    => 'root',
            group    => 'root',
            mode     => '0644',
            content  => template('phpfpm/pool.conf.erb'),
            require  => Class['Phpfpm::Package'],
            notify   => Service[$service_name],
        }
    }
}
