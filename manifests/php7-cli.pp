class php7::php7-cli () inherits php7::params {

  anchor{'php7::php7-cli::begin':
    before => Class['php7::php7-cli::install']
  }

  class{'php7::php7-cli::install':
    require => Anchor['php7::php7-cli::begin']
  }

  class{'php7::php7-cli::config':
    require => Class['php7::php7-cli::install']
  }

  anchor{'php7::php7-cli::end':
    require => Class['php7::php7-cli::config']
  }
}
