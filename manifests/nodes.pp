node base {
  include ssh
}

node 'agent1.localdomain' inherits base {
  include postfix
  include mysql
  include apache
  include wordpress

  $hostname = 'www.example.com'

  apache::vhost { $hostname:
    port => 80,
    docroot => "/var/www/${hostname}",
    ssl => false,
    priority => 10,
  }

  mysql::op::db { 'wordpress':
    dbname   => 'wordpress',
    user     => 'wordpress',
    password => 'wordpress',
    rootpass => 'puppet',
  }

  wordpress::install { 'wordpress':
    docroot => "/var/www/${hostname}",
  }
}
