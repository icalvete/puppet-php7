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
}
