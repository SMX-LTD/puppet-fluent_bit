class fluent_bit::params {
  $repo_install = true
  $repo_name = 'fluentbit'
  $repo_desc = 'fluentbit'

  case $facts['osfamily'] {
    'debian': {
      $distro_id = downcase($facts['lsbdistid'])
      $repo_url = "http://packages.fluentbit.io/${distro_id}"
    }

    'Redhat': {
      $release = $facts['os']['release']['major']
      $repo_url = "https://packages.fluentbit.io/centos/${release}/\$basearch/"
    }

    default: {
      fail("Unsupported osfamily ${facts['osfamily']}")
    }
  }

  $repo_enabled = true
  $repo_gpgcheck = true
  $repo_gpgkey = 'https://packages.fluentbit.io/fluentbit.key'
  $repo_gpgkeyid = 'F209D8762A60CD49E680633B4FF8368B6EA0722A'

  $package_name = 'fluent-bit'
  $package_ensure = present

  $service_name = 'fluent-bit'
  $service_ensure = running
  $service_enable = true
  $service_manage = true

  # Note: /etc/fluent-bit created by the package
  $config_file = '/etc/fluent-bit/fluent-bit.conf'
  $config_path = '/etc/fluent-bit/config.d'
  $config_owner = 'root'
  $config_group = 'root'
  $configs = {}

  $parsers_file = '/etc/fluent-bit/parsers-smx.conf'
  $parsers = {}
}
