class php7::modules inherits php7::params {

  if $php7::params::php7_modules {
    php7::module { $php7::params::php7_modules:}
  }

  if $environment == 'DEV' {

    package { 'php-xdebug':
      ensure  => present,
      require => Class['apt::update']
    }
  }
}
