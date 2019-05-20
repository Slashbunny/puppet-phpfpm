# The baseline for module testing used by Puppet Labs is that each manifest
# should have a corresponding test manifest that declares that class or defined
# type.
#
# Tests are then run by using puppet apply --noop (to check for compilation
# errors and view a log of events) or by fully applying the test in a virtual
# environment (to compare the resulting system state to the desired state).
#
# Learn more about module testing here:
# http://docs.puppetlabs.com/guides/tests_smoke.html
#
class { 'phpfpm':
    poold_purge => true,
}

# TCP pool using 127.0.0.1, port 9000, upstream defaults
phpfpm::pool { 'test1':  }

# Pool running as a different user
phpfpm::pool { 'test2':
    listen => '127.0.0.1:9002',
    user   => 'foo',
    group  => 'bar',
}

# Pool with dynamic process manager, TCP socket
phpfpm::pool { 'test3':
    listen                 => '127.0.0.1:9003',
    listen_allowed_clients => '127.0.0.1',
    pm                     => 'dynamic',
    pm_max_children        => 10,
    pm_start_servers       => 4,
    pm_min_spare_servers   => 2,
    pm_max_spare_servers   => 6,
    pm_max_requests        => 500,
    pm_status_path         => '/status',
    ping_path              => '/ping',
    ping_response          => 'pong',
    env                    => {
        'ODBCINI' => '"/etc/odbc.ini"',
    },
    php_admin_flag         => {
        'expose_php' => 'Off',
    },
    php_admin_value        => {
        'max_execution_time' => '300',
    },
}

