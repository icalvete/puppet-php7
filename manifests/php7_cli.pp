class php7::php7_cli (

  $env                    = $php7::params::env,
  $max_execution_time_cli = $php7::params::max_execution_time,
  $memory_limit_cli       = $php7::params::memory_limit,

) inherits php7::params {

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

  class {'php7::php7_cli::config':
    require => Class['php7::php7_cli::install']
  }

  anchor {'php7::php7_cli::end':
    require => Class['php7::php7_cli::config']
  }
}
