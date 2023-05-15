class fluent_bit::uninstall_old inherits fluent_bit {

  service { 'td-agent-bit':
    ensure => stopped,
    enable => false,
  }

  -> package { 'td-agent-bit':
    ensure => absent,
  }

  -> file { '/etc/td-agent-bit':
    ensure  => absent,
    recurse => true,
    force   => true,
  }

}
