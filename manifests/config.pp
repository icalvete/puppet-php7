class php7::config {

  augeas{'memcached_compression_threshold':
    context => "/files/${php7::params::php7_memcachedini}/PHP",
    changes => [
      "set memcached.compression_threshold ${php7::memcached_compression_threshold}",
    ]
  }

  include  php7::php7_cli::config
}
