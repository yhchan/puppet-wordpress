class postfix::config {
  File {
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  $require = Class["postfix::install"]
  $notify  = Class["postfix::service"]

  file { "/etc/postfix/master.cf":
    ensure  => present,
    source  => "puppet:///modules/postfix/master.cf",
  }

  file { "/etc/postfix/main.cf":
    ensure  => present,
    content => template("postfix/main.cf.erb"),
  }
}
