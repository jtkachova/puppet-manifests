class nrpe_web{
  service { "nagios-nrpe-server":
  ensure => running,
  enable  => true
  }
file { 'check_disk2':
    path => '/usr/lib/nagios/plugins/check_disk2',
    ensure  => file,
    source => "puppet:///files/plugins/check_disk2",
    mode    => 0755,
    owner   => 'root',
    group   => 'root'
}
file { 'nrpe.py':
    path => '/tmp/nrpe.py',
    ensure  => file,
    source => "puppet:///files/nrpe.py",
    mode    => 0777,
    owner   => 'root',
    group   => 'root'
}
file { 'sudoers.sh':
    path => '/tmp/sudoers.sh',
    ensure  => file,
    source => "puppet:///files/plugins/sudoers.sh",
    mode    => 0777,
    owner   => 'root',
    group   => 'root'
}
file { 'check_nginx_status.pl':
    path => '/usr/lib/nagios/plugins/check_nginx_status.pl',
    ensure  => file,
    source => "puppet:///files/plugins/check_nginx_status.pl",
    mode    => 0755,
    owner   => 'root',
    group   => 'root'
}
file { 'check_varnishbackends.py':
    path => '/usr/lib/nagios/plugins/check_varnishbackends.py',
    ensure  => file,
    source => "puppet:///files/plugins/check_varnishbackends.py",
    mode    => 0755,
    owner   => 'root',
    group   => 'root'
}
exec { "/tmp/nrpe.py":
  path   => "/usr/bin:/usr/sbin:/bin",
  creates => "/tmp/test_nrpe.cfg",
  onlyif => "-N /tmp/nrpe.py"
}
exec { "/tmp/sudoers.sh":
  path   => "/usr/bin:/usr/sbin:/bin",
  onlyif => "-N /tmp/nrpe.py",
  require => Exec["/home/nrpe.py"]
}
exec {"cp -p /home/test_nrpe.cfg /etc/nagios/nrpe.cfg":
     path   => "/usr/bin:/usr/sbin:/bin",
     notify  => Service["nagios-nrpe-server"],
     require => Exec["/home/nrpe.py"]
}
}
