class php7::common inherits php7::params {

    if $php7::version {
      $version = $php7::version
    } else {
      $version = $php7::php7_cli::version
    }

  case $::operatingsystem {
    /^(Debian|Ubuntu)$/: {
      $php7_package     = "php7.${version}"
      $php7_cli_package = "php7.${version}-cli"
      $php7_fpm_service = "php7.${version}-fpm"
      $php7_fpm_package = ["php7.${version}-fpm", "php7.${version}-cgi"]

      $php7_cli_phpini   = "/etc/php/7.${version}/cli/php.ini"
      $php7_cli_phpconf  = "/etc/php/7.${version}/cli/conf.d"
      $php7_includepath  = '/usr/share/php'
      $php7_fpm_phpini   = "/etc/php/7.${version}/fpm/php.ini"
      $php7_memcachedini = "/etc/php/7.${version}/mods-available/memcached.ini"
      $php7_fpm_phpconf  = "/etc/php/7.${version}/fpm/conf.d"
      $php7_fpm_conf     = "/etc/php/7.${version}/fpm/php-fpm.conf"
      $php7_fpm_www_pool = "/etc/php/7.${version}/fpm/pool.d/www.conf"

      case $version {
        0: {
          $extension_dir     = '/usr/lib/php/20151012'
          $php7_modules = ["php7.${version}-curl","php7.${version}-mysql", "php7.${version}-json", "php7.${version}-mcrypt", "php7.${version}-gd", "php7.${version}-mbstring", "php7.${version}-bcmath", "php7.${version}-xml", "php7.${version}-sqlite3", "php7.${version}-zip", "php7.${version}-gmp", "php7.${version}-bz2",  'php-mongodb', 'php-memcached', 'php-imagick', 'php-redis']
        }
        1: {
          $extension_dir     = '/usr/lib/php/20160303'
          $php7_modules = ["php7.${version}-curl","php7.${version}-mysql", "php7.${version}-json", "php7.${version}-mcrypt", "php7.${version}-gd", "php7.${version}-mbstring", "php7.${version}-bcmath", "php7.${version}-xml", "php7.${version}-sqlite3", "php7.${version}-zip", "php7.${version}-gmp", "php7.${version}-bz2",  'php-mongodb', 'php-memcached', 'php-imagick', 'php-redis']
        }
        2: {
          $extension_dir     = '/usr/lib/php/20170718'
          $php7_modules = ["php7.${version}-curl","php7.${version}-mysql", "php7.${version}-json", "php7.${version}-gd", "php7.${version}-mbstring", "php7.${version}-bcmath", "php7.${version}-xml", "php7.${version}-sqlite3", "php7.${version}-zip", "php7.${version}-gmp", "php7.${version}-bz2",  'php-mongodb', 'php-memcached', 'php-imagick', 'php-redis']
        }
        3: {
          $extension_dir     = '/usr/lib/php/20180731'
          $php7_modules = ["php7.${version}-curl","php7.${version}-mysql", "php7.${version}-json", "php7.${version}-gd", "php7.${version}-mbstring", "php7.${version}-bcmath", "php7.${version}-xml", "php7.${version}-sqlite3", "php7.${version}-zip", "php7.${version}-gmp", "php7.${version}-bz2",  'php-mongodb', 'php-memcached', 'php-imagick', 'php-redis']
        }
        default: {
          $php7_modules = ["php7.${version}-curl","php7.${version}-mysql", "php7.${version}-json", "php7.${version}-gd", "php7.${version}-mbstring", "php7.${version}-bcmath", "php7.${version}-xml", "php7.${version}-sqlite3", "php7.${version}-zip", "php7.${version}-gmp", "php7.${version}-bz2",  'php-mongodb', 'php-memcached', 'php-imagick', 'php-redis']
        }
      }
    }
    default: {
      fail ("${::operatingsystem} not supported.")
    }
  }

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
    path   => $php7_includepath,
    owner  => 'root',
    group  => 'root',
    mode   => '0775',
  }
}
