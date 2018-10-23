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

  case $::operatingsystem {
    /^(Debian|Ubuntu)$/: {
      $php7_package     = "php7.${version}"
      $php7_cli_package = "php7.${version}-cli"
      $php7_fpm_service = "php7.${version}-fpm"
      $php7_fpm_package = ["php7.${version}-fpm", "php7.${version}-cgi"]

      case $::lsbdistcodename {
        /^(saucy|trusty|xenial)/: {
          $php7_modules = ["php7.${version}-curl","php7.${version}-mysql", "php7.${version}-json", "php7.${version}-mcrypt", "php7.${version}-gd", "php7.${version}-mbstring", "php7.${version}-bcmath", "php7.${version}-xml", "php7.${version}-sqlite3", "php7.${version}-zip", "php7.${version}-gmp", "php7.${version}-bz2",  'php-mongodb', 'php-memcached', 'php-imagick', 'php-redis']
        }
        default: {
          $php7_modules = ["php7.${version}-curl","php7.${version}-mysqlnd", "php7.${version}-json", "php7.${version}-mcrypt", "php7.${version}-gd"]
        }
      }

      $php7_cli_phpini   = "/etc/php/7.${version}/cli/php.ini"
      $php7_cli_phpconf  = "/etc/php/7.${version}/cli/conf.d"
      $php7_includepath  = '/usr/share/php'
      $php7_fpm_phpini   = "/etc/php/7.${version}/fpm/php.ini"
      $php7_memcachedini = "/etc/php/7.${version}/mods-available/memcached.ini"
      $php7_fpm_phpconf  = "/etc/php/7.${version}/fpm/conf.d"
      $php7_fpm_conf     = "/etc/php/7.${version}/fpm/php-fpm.conf"
      $php7_fpm_www_pool = "/etc/php/7.${version}/fpm/pool.d/www.conf"

      case $version {
        0: { $extension_dir     = '/usr/lib/php/20151012' }
        1: { $extension_dir     = '/usr/lib/php/20160303' }
      }
    }
    default: {
      fail ("${::operatingsystem} not supported.")
    }
  }

  $memcached_compression_threshold = 15000
}
