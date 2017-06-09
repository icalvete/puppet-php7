class  php7::php7_fpm::install {

  package {"libapache2-mod-php7.${php7::params::version}":
    ensure => purged,
    before => Package[$php7::params::php7_fpm_package]
  }

  package { $php7::params::php7_fpm_package :
    ensure => present
  }

  file {'fpm_syslog_config':
    ensure  => present,
    path    => "${php7::params::php7_includepath}/fpm_log.php",
    content => template("${module_name}/fpm_log.php.erb"),
    mode    => '0664',
  }
}
