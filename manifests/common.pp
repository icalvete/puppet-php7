class php7::common inherits php7::params {

  include apt
  apt::ppa { 'ppa:ondrej/php': }

  realize Package['augeas-lenses']

  file {'augeas_php7_len':
    ensure  => present,
    path    => '/usr/share/augeas/lenses/dist/php.aug',
    content => template("${module_name}/php.aug.erb"),
    mode    => '0664',
    require => Package['augeas-lenses']
  }

  file {'php7_include_path_dir':
    ensure => directory,
    path   => $php7::params::php7_includepath,
    owner  => 'root',
    group  => 'root',
    mode   => '0775',
  }
}
