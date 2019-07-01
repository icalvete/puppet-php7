class php7::common_post_install inherits php7::params {

  if defined('php7::php7_cli') {
    $version = $php7::php7_cli::version
  } else {
    $version = $php7::version
  }

  case $facts['os']['distro']['codename'] {
    'bionic': {
      $update_alternatives = '/usr/bin/update-alternatives'
    }
    default: {
      $update_alternatives = '/usr/sbin/update-alternatives'
    }
  }

  exec { "update-alternatives_php7_${version}":
    command => "${update_alternatives} --set php /usr/bin/php7.${version}",
    user    => 'root',
    require => [Class['php7::php7_cli::install'], Package[$php7_cli_package]]
  }

  exec { "update-alternatives_phar7_${version}":
    command => "${update_alternatives} --set phar /usr/bin/phar7.${version}",
    user    => 'root',
    require => [Class['php7::php7_cli::install'], Package[$php7_cli_package]]
  }

  exec { "update-alternatives_phar.phar7_${version}":
    command => "${update_alternatives} --set phar.phar /usr/bin/phar.phar7.${version}",
    user    => 'root',
    require => [Class['php7::php7_cli::install'], Package[$php7_cli_package]]
  }
}
