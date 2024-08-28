class fluent_bit::config inherits fluent_bit {

  file { $fluent_bit::config_path:
    ensure  => directory,
    owner   => $fluent_bit::config_owner,
    group   => $fluent_bit::config_group,
    mode    => '0750',
    recurse => true,
    force   => true,
    purge   => true,
  } ->

  file { $fluent_bit::config_file:
    ensure  => present,
    content => fluent_bit_config($fluent_bit::configs),
    require => Class['Fluent_bit::Install'],
    notify  => Class['Fluent_bit::Service'],
  }

  if ( $fluent_bit::parsers != {} ) {
    file { $fluent_bit::parsers_file:
      ensure  => present,
      content => fluent_bit_config($fluent_bit::parsers),
      owner   => $fluent_bit::config_owner,
      group   => $fluent_bit::config_group,
      mode    => '0644',
      require => File[$fluent_bit::config_file],
      notify  => Class['Fluent_bit::Service'],
    }
  } else {
      file { $fluent_bit::parsers_file:
      ensure => absent,
      notify => Class['Fluent_bit::Service'],
    }
  }

  # Any lua scripts provided
  file { $fluent_bit::lua_path:
    ensure  => directory,
    owner   => $fluent_bit::config_owner,
    group   => $fluent_bit::config_group,
    mode    => '0750',
    recurse => true,
    force   => true,
  }
  $fluent_bit::lua.each |$_key, $_code| {
    file { "${fluent_bit::lua_path}/${_key}":
      ensure  => present,
      content => $_code,
      owner   => $fluent_bit::config_owner,
      group   => $fluent_bit::config_group,
      mode    => '0644',
      require => File[$fluent_bit::lua_path],
      notify  => Class['Fluent_bit::Service'],
    }
  }
}
