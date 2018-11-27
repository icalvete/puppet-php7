class php7 (

  $fpm                             = false,
  $amqp                            = false,
  $phalcon                         = false,
  $opcache                         = false,
  $opcache_blacklist               = [''],
  $env                             = pick($::env, $php7::params::env),
  $version                         = $php7::params::version,
  $file_uploads                    = 'Off',
  $file_uploads_size               = $php7::params::file_uploads_size,
  $max_execution_time_cli          = $php7::params::max_execution_time,
  $max_execution_time_fpm          = $php7::params::max_execution_time,
  $memory_limit_cli                = $php7::params::memory_limit,
  $memory_limit_fpm                = $php7::params::memory_limit,
  $memcached_compression_threshold = $php7::params::memcached_compression_threshold

) inherits php7::params {
  
  case $::operatingsystem {
    /^(Debian|Ubuntu)$/: {
      $php7_package     = "php7.${version}"
      $php7_cli_package = "php7.${version}-cli"
      $php7_fpm_service = "php7.${version}-fpm"
      $php7_fpm_package = ["php7.${version}-fpm", "php7.${version}-cgi"]

      $php7_cli_phpini   = "/etc/php/7.${version}/cli/php.ini"
      $php7_cli_phpconf  = "/etc/php/7.${version}/cli/conf.d"
      $php7_includepath  = '/usr/share/php'
      $php7_fpm_phpini   = "/etc/php/7.${version}/fpm/php.ini"
      $php7_memcachedini = "/etc/php/7.${version}/mods-available/memcached.ini"
      $php7_fpm_phpconf  = "/etc/php/7.${version}/fpm/conf.d"
      $php7_fpm_conf     = "/etc/php/7.${version}/fpm/php-fpm.conf"
      $php7_fpm_www_pool = "/etc/php/7.${version}/fpm/pool.d/www.conf"

      case $version {
        0: { 
          $extension_dir     = '/usr/lib/php/20151012'
          $php7_modules = ["php7.${version}-curl","php7.${version}-mysql", "php7.${version}-json", "php7.${version}-mcrypt", "php7.${version}-gd", "php7.${version}-mbstring", "php7.${version}-bcmath", "php7.${version}-xml", "php7.${version}-sqlite3", "php7.${version}-zip", "php7.${version}-gmp", "php7.${version}-bz2",  'php-mongodb', 'php-memcached', 'php-imagick', 'php-redis']
        }
        1: { 
          $extension_dir     = '/usr/lib/php/20160303' 
          $php7_modules = ["php7.${version}-curl","php7.${version}-mysql", "php7.${version}-json", "php7.${version}-mcrypt", "php7.${version}-gd", "php7.${version}-mbstring", "php7.${version}-bcmath", "php7.${version}-xml", "php7.${version}-sqlite3", "php7.${version}-zip", "php7.${version}-gmp", "php7.${version}-bz2",  'php-mongodb', 'php-memcached', 'php-imagick', 'php-redis']
        }
        2: {
          $extension_dir     = '/usr/lib/php/20170718'
          $php7_modules = ["php7.${version}-curl","php7.${version}-mysql", "php7.${version}-json", "php7.${version}-gd", "php7.${version}-mbstring", "php7.${version}-bcmath", "php7.${version}-xml", "php7.${version}-sqlite3", "php7.${version}-zip", "php7.${version}-gmp", "php7.${version}-bz2",  'php-mongodb', 'php-memcached', 'php-imagick', 'php-redis']
        }
        default: {
          $php7_modules = ["php7.${version}-curl","php7.${version}-mysql", "php7.${version}-json", "php7.${version}-mcrypt", "php7.${version}-gd", "php7.${version}-mbstring", "php7.${version}-bcmath", "php7.${version}-xml", "php7.${version}-sqlite3", "php7.${version}-zip", "php7.${version}-gmp", "php7.${version}-bz2",  'php-mongodb', 'php-memcached', 'php-imagick', 'php-redis']
        }
      }
    }
    default: {
      fail ("${::operatingsystem} not supported.")
    }
  }

  if $phalcon and ! $phalcon_support[$osfamily][$lsbdistcodename] {
    fail("Falcom module isn't supported in $osfamily $lsbdistcodename")
  }

  anchor {'php7::begin':
    before => Class['php7::install']
  }

  class {'php7::common':
    require => Anchor['php7::begin']
  }

  class {'php7::install':
    require => Class['php7::common']
  }

  class {'php7::config':
    require => Class['php7::install']
  }

  if $fpm {
      class {'php7::php7_fpm':
        require => Class['php7::config'],
      }
  }

  anchor {'php7::end':
    require => Class['php7::config']
  }
}
