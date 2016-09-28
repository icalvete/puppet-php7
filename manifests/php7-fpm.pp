class php7::php7-fpm inherits php7::params {

  anchor {'php7::php7-fpm::begin':
    before => Class['php7::php7-fpm::install']
  }

  class {'php7::php7-fpm::install':
    require => Anchor['php7::php7-fpm::begin']
  }

  class {'php7::php7-fpm::config':
    require => Class['php7::php7-fpm::install'],
  }

  class {'php7::php7-fpm::service':
    subscribe => Class['php7::php7-fpm::config']
  }

  anchor {'php7::php7-fpm::end':
    require => Class['php7::php7-fpm::service']
  }
}
