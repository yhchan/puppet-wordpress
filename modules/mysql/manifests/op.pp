define mysql::op::db($user, $password, $dbname, $rootpass = '') {

  $pass_arg = $rootpass ? {
    ''      => '',
    default => "-p${rootpass}",
  }

  exec { "create-${dbname}-db":
    unless => "/usr/bin/mysql -uroot ${pass_arg} ${dbname}",
    command => "/usr/bin/mysql -uroot ${pass_arg} -e \"create database ${dbname};\"",
    require => Service["mysqld"],
  }

  exec { "grant-${dbname}-db":
    unless => "/usr/bin/mysql -u${user} -p${password} ${dbname}",
    command => "/usr/bin/mysql -uroot ${pass_arg} -e \"grant all on ${dbname}.* to ${user}@localhost identified by '$password';\"",
    require => [Service["mysqld"], Exec["create-${dbname}-db"]]
  }
}
