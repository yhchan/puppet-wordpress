define apache::vhost($port, $docroot, $ssl=true, $template='apache/vhost.conf.erb',
                     $priority, $serveraliases = '') {
  include apache
  file {"/etc/httpd/conf.d/${priority}-${name}.conf":
    content => template($template),
    owner => 'root',
    group => 'root',
    mode => '644',
    require => Class["apache::install"],
    notify => Class["apache::service"],
  }
}
