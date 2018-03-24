class php7::php7_cli::install {

  package {$php7::params::php7_cli_package:
    ensure  => present,
    require => Class['apt::update']
  }

  file {'cli_syslog_config':
    ensure  => present,
    path    => "${php7::params::php7_includepath}/cli_log.php",
    content => template("${module_name}/cli_log.php.erb"),
    mode    => '0664',
  }

  file { 'maxminddb.so':
    ensure  => present,
    path    => "${php7::params::extension_dir}/maxminddb.so",
    owner   => 'root',
    group   => 'root',
    mode    => '0664',
    source  => "puppet:///modules/${module_name}/extensions/maxminddb7.${php7::params::version}.so",
    require => Package[$php7::params::php7_cli_package]
  }
}
