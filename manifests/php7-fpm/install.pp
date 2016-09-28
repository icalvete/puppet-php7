class  php7::php7-fpm::install {

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
