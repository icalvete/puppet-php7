class php7::common_post_install inherits php7::params {

  case $facts['os']['distro']['codename'] {
    'bionic': {
      $update_alternatives = '/usr/bin/update-alternatives'
    }
    default: {
      $update_alternatives = '/usr/sbin/update-alternatives'
    }
  }

  exec { "update-alternatives_php7_${php7::version}":
    command => "${update_alternatives} --set php /usr/bin/php7.${php7::version}",
    user    => 'root',
    require => Package[$php7::php7_cli_package]
  }

  exec { "update-alternatives_phar7_${php7::version}":
    command => "${update_alternatives} --set phar /usr/bin/phar7.${php7::version}",
    user    => 'root',
    require => Package[$php7::php7_cli_package]
  }

  exec { "update-alternatives_phar.phar7_${php7::version}":
    command => "${update_alternatives} --set phar.phar /usr/bin/phar.phar7.${php7::version}",
    user    => 'root',
    require => Package[$php7::php7_cli_package]
  }
}
