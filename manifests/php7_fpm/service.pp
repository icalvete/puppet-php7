class php7::php7_fpm::service {

  service { $php7::params::php7_fpm_service:
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
  }
}
