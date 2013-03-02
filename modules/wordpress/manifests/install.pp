define wordpress::install ($docroot = '/var/www/wordpress', $config_template = 'wordpress/wp-config.php.erb',
                           $db_name = 'wordpress', $db_host = 'localhost', 
                           $db_user = 'wordpress', $db_pass = 'wordpress'){
  include php

  package { 'php53-mysql':
    ensure => installed,
    notify => Class[apache::service],
  }

  package { 'subversion':
    ensure => installed,
  }

  File {
    owner   => 'apache',
    group   => 'apache',
  }

  file { $docroot:
    ensure => directory,
  }

  vcsrepo { $docroot: 
    source   => "http://core.svn.wordpress.org/tags/3.5.1/",
    require  => [Package['subversion'], File[$docroot]],
    provider => svn,
    ensure   => latest,
  }

  file { "$docroot/wp-config.php":
    content => template($config_template),
    mode    => 0640,
  }
}
