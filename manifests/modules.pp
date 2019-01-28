class php7::modules inherits php7::params {

  if $php7::common::php7_modules {
    php7::module { $php7::common::php7_modules:}
  }

  if $php7::env == 'DEV' {

    package { 'php-xdebug':
      ensure  => present,
      require => Class['apt::update']
    }
  }
}
