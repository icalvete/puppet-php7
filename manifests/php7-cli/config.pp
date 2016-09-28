class php7::php7-cli::config {

  Augeas {
    require => Package[$php7::params::php7_cli_package]
  }

  augeas{'include_path_cli' :
    context => "/files${php7::params::php7_cli_phpini}/PHP",
    changes => "set include_path .:${php7::params::php7_includepath}:${php7::params::php7_includepath}/7.${php7::params::version}/cli",
  }

  augeas{'cli_security' :
    context => "/files/${php7::params::php7_cli_phpini}/PHP",
    changes => [
      'set expose_php Off',
      'set file_uploads Off',
    ]
  }

  augeas{'cli_performance' :
    context => "/files/${php7::params::php7_cli_phpini}/PHP",
    changes => [
      "set max_execution_time ${php7::max_execution_time_cli}",
      'set max_input_time 15',
      "set date.timezone ${php7::params::timezone}",
    ]
  }

  augeas{'cli_memory_limit' :
    context => "/files/${php7::params::php7_cli_phpini}/PHP",
    changes => [
      "set memory_limit ${php7::memory_limit_cli}",
    ]
  }

  augeas{'cli_debug' :
    context => "/files/${php7::params::php7_cli_phpini}/PHP",
    changes => [
      'set error_log syslog',
      'set auto_prepend_file cli_log.php',
    ]
  }

  if $php7::env == 'DEV' {
    augeas{'display_errors_cli':
      context => "/files/${php7::params::php7_cli_phpini}/PHP",
      changes => 'set display_errors On',
    }
  }
}
