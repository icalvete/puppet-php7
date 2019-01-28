class php7::php7_cli::config {

  Augeas {
    require => Package[$php7::common::common_package]
  }

  augeas{'include_path_cli' :
    context => "/files${php7::common::common_phpini}/PHP",
    changes => "set include_path .:${php7::common::php7_includepath}:${php7::common::php7_includepath}/7.${php7::common::version}/cli",
  }

  augeas{'cli_security' :
    context => "/files/${php7::common::common_phpini}/PHP",
    changes => [
      'set expose_php Off',
      'set file_uploads Off',
    ]
  }

  augeas{'cli_performance' :
    context => "/files/${php7::common::php7_cli_phpini}/PHP",
    changes => [
      "set max_execution_time ${php7::php7_cli::max_execution_time_cli}",
      'set max_input_time 15',
      "set date.timezone ${php7::params::timezone}",
    ]
  }

  augeas{'cli_memory_limit' :
    context => "/files/${php7::common::php7_cli_phpini}/PHP",
    changes => [
      "set memory_limit ${php7::php7_cli::memory_limit_cli}",
    ]
  }

  file {'cli_maxminddb_config':
    ensure  => file,
    path    => "${php7::common::common_phpconf}/20-maxminddb.ini",
    content => template("${module_name}/maxminddb.ini.erb"),
    mode    => '0644',
  }

  augeas{'cli_debug' :
    context => "/files/${php7::common::common_phpini}/PHP",
    changes => [
      'set error_log syslog',
      'set auto_prepend_file cli_log.php',
    ]
  }

  if $php7::common::env == 'DEV' {
    augeas{'display_errors_cli':
      context => "/files/${php7::common::common_phpini}/PHP",
      changes => 'set display_errors On',
    }
  }

  if "${php7::common::version}" == '2' {
    file_line { "${php7::common::common_phpini}":
      path  => "${php7::common::common_phpini}",
      line  => 'extension=mcrypt.so',
    }
  }
}
