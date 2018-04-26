class php7::php7_fpm inherits php7::params {

  anchor {'php7::php7_fpm::begin':
    before => Class['php7::php7_fpm::install']
  }

  class {'php7::php7_fpm::install':
    require => Anchor['php7::php7_fpm::begin']
  }

  class {'php7::php7_fpm::config':
    require => Class['php7::php7_fpm::install'],
  }

  class {'php7::php7_fpm::common_post_install':
    require => Class['php7::php7_fpm::config']
  }

  class {'php7::php7_fpm::service':
    subscribe => Class['php7::php7_fpm::common_post_install']
  }

  anchor {'php7::php7_fpm::end':
    require => Class['php7::php7_fpm::service']
  }
}
