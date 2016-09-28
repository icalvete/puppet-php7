class php7::install inherits php7::params {

  include apt

  apt::ppa { 'ppa:ondrej/php': }

  package {$php7::params::php7_package:
    ensure => present,
    require   => Class['apt::update']
  }

  file {'php7_include_path_dir':
    ensure => directory,
    path   => $php7::params::php7_includepath,
    owner  => 'root',
    group  => 'root',
    mode   => '0775',
  }

  class {'php7::php7-cli::install':
    require => Class['apt::update']
  }

  exec { 'update_php_binary':
    command => "/usr/bin/update-alternatives --install /usr/bin/php php /usr/bin/php7.${php7::params::version} 100",
    user    => 'root',
    require => Package[$php7::params::php7_cli_package]
  }

  case $::operatingsystem {

    /^(Debian|Ubuntu)$/: {

      package {"libapache2-mod-php7.${php7::params::version}":
        ensure => purged
      }
    }
    default:{}
  }

  if $php7::params::php7_modules {
    php7::module { $php7::params::php7_modules:}
  }

  if $environment == 'DEV' {

    package { 'php-xdebug':
      ensure  => present,
      require   => Class['apt::update']
    }
  }

  file {'augeas_php7_len':
    ensure  => present,
    path    => '/usr/share/augeas/lenses/dist/php.aug',
    content => template("${module_name}/php.aug.erb"),
    mode    => '0664',
  }
}
