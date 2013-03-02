class php {
  package { ['php53']:
    ensure => installed,
    notify => Class['apache::service'],
  }
}
