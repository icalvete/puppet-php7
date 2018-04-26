class php7::install inherits php7::params {

  package {$php7::params::php7_package:
    ensure  => present,
    require =>  [
      Apt::Ppa['ppa:ondrej/php'],
      Class['apt::update']]
  }

  class {'php7::php7_cli':
    max_execution_time_cli => $php7::max_execution_time_cli,
    memory_limit_cli       => $php7::memory_limit_cli
  }
}
