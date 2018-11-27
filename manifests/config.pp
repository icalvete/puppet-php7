class php7::config {

  augeas{'memcached_compression_threshold':
    context => "/files/${php7::php7_memcachedini}/PHP",
    changes => [
      "set memcached.compression_threshold ${php7::memcached_compression_threshold}",
    ],
    require => Package['php-memcached']
  }

  include  php7::php7_cli::config
}
