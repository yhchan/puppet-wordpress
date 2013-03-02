class mysql::install {
  package { ['mysql-server', 'mysql']:
    ensure => installed
  }
}
