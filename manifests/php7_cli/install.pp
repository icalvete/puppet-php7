class php7::php7_cli::install {

  package {$php7::php7_cli::php7_cli_package:
    ensure  => present,
    require => Class['apt::update'],
    before  => Class['php7::modules']
  }

  include php7::modules

  file {'cli_syslog_config':
    ensure  => present,
    path    => "${php7::common::php7_includepath}/cli_log.php",
    content => template("${module_name}/cli_log.php.erb"),
    mode    => '0664',
  }

  file { 'maxminddb.so':
    ensure  => present,
    path    => "${php7::common::extension_dir}/maxminddb.so",
    owner   => 'root',
    group   => 'root',
    mode    => '0664',
    source  => "puppet:///modules/${module_name}/extensions/maxminddb7.${php7::php7_cli::version}.so",
    require => Package[$php7::php7_cli::php7_cli_package]
  }

  if "${php7::php7_cli::version}" >= '2' {

    package{'libmcrypt4':}

    file { 'mcrypt.so':
      ensure  => present,
      path    => "${php7::common::extension_dir}/mcrypt.so",
      owner   => 'root',
      group   => 'root',
      mode    => '0664',
      source  => "puppet:///modules/${module_name}/extensions/mcrypt7.${php7::php7_cli::version}.so",
      require => Package[$php7::common::php7_common_package]
    }
  }
}
