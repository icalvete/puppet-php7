class php7::php7_cli (

  $env                    = $php7::params::env,
  $max_execution_time_cli = $php7::params::max_execution_time,
  $memory_limit_cli       = $php7::params::memory_limit,
  $version                = $php7::params::version

) inherits php7::params {

  $php7_cli_package = "php7.${version}-cli"

  $php7_cli_phpini   = "/etc/php/7.${version}/cli/php.ini"
  $php7_cli_phpconf  = "/etc/php/7.${version}/cli/conf.d"
  $php7_includepath  = '/usr/share/php'
  $php7_memcachedini = "/etc/php/7.${version}/mods-available/memcached.ini"

  case $version {
    0: {
      $extension_dir     = '/usr/lib/php/20151012'
    }
    1: {
      $extension_dir     = '/usr/lib/php/20160303'
    }
      2: {
      $extension_dir     = '/usr/lib/php/20170718'
    }
    default: {
    }
  }

  anchor {'php7::php7_cli::begin':
    before => Class['php7::php7_cli::install']
  }

  class {'php7::php7_cli::common':
    require => Anchor['php7::php7_cli::begin']
  }

  class {'php7::php7_cli::install':
    require => [
      Class['php7::php7_cli::common'],
      Class['apt::update']
    ]
  }

  class {'php7::php7_cli::common_post_install':
    require => Class['php7::php7_cli::install']
  }

  class {'php7::php7_cli::config':
    require => Class['php7::php7_cli::common_post_install']
  }

  anchor {'php7::php7_cli::end':
    require => Class['php7::php7_cli::config']
  }
}
