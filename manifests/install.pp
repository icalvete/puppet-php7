class php7::install inherits php7::params {

  package {$php7::params::php7_package:
    ensure  => present,
    require =>  Class['apt::update']
  }

  class {'php7::php7_cli':
    max_execution_time_cli => $php7::max_execution_time_cli,
    memory_limit_cli       => $php7::memory_limit_cli
  }

  file { 'maxminddb.so':
    ensure  => present,
    path    => "$extension_dir/maxminddb.so",
    owner   => 'root',
    group   => 'root',
    mode    => '0664',
    source  => "puppet:///modules/${module_name}/extensions/maxminddb7.${php7::params::version}.so",
    require => Package[$php7::params::php7_package]
  }
}
