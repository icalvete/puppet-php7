class php7::install inherits php7::params {

  package {$php7::params::php7_package:
    ensure  => present,
    require =>  Class['apt::update']
  }

  class {'php7::php7_cli::install':
    max_execution_time_cli => $php5::max_execution_time_cli,
    memory_limit_cli       => $php5::memory_limit_cli
  }
}
