class php7 (

  $fpm                             = false,
  $amqp                            = false,
  $phalcon                         = false,
  $opcache                         = false,
  $opcache_blacklist               = [''],
  $env                             = $php7::params::env,
  $file_uploads                    = 'Off',
  $file_uploads_size               = $php7::params::file_uploads_size,
  $max_execution_time_cli          = $php7::params::max_execution_time,
  $max_execution_time_fpm          = $php7::params::max_execution_time,
  $memory_limit_cli                = $php7::params::memory_limit,
  $memory_limit_fpm                = $php7::params::memory_limit,
  $memcached_compression_threshold = $php7::params::memcached_compression_threshold

) inherits php7::params {

  if $phalcon and ! $phalcon_support[$osfamily][$lsbdistcodename] {
    fail("Falcom module isn't supported in $osfamily $lsbdistcodename")
  }

  anchor {'php7::begin':
    before => Class['php7::install']
  }

  class {'php7::install':
    require => Anchor['php7::begin']
  }

  class {'php7::config':
    require => Class['php7::install']
  }

  if $fpm {
      class {'php7::php7-fpm':
        require => Class['php7::config'],
      }
  }

  anchor {'php7::end':
    require => Class['php7::config']
  }
}
