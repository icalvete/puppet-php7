class php7::params {

  case $::lsbdistcodename {
    /^(saucy|trusty)/: {
      $version  = 0
    }
    default: {
      $version  = 1
    }
  }

  $env      = $::env
  $timezone = 'Europe/Madrid'

  $phalcon_support = {
    'Debian' => {
      'saucy'  => true,
      'trusty' => true,
    }
  }

  $syslog_facility     = 'local4'
  $syslog_facility_php = 'LOG_LOCAL4'

  # log_level values can be alert, error, warning, notice, debug
  $log_level = 'warning'

  $file_uploads_size  = '10M'
  $max_execution_time = '15'
  $memory_limit       = '32M'

  $max_requests_fpm   = '512'

  $memcached_compression_threshold = 15000
}
