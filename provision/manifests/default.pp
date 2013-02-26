group { "puppet":
  ensure => "present",
}

File { owner => 0, group => 0, mode => 0644 }

file { '/etc/motd':
  content => "Welcome to your Vagrant-built virtual machine!
              Managed by Puppet.\n"
}

file { '/etc/hosts':
  content => "127.0.0.1	localhost
127.0.1.1	vagrant-ubuntu.vagrantup.com	vagrant-ubuntu
192.168.1.3     puppet squid-deb-proxy
192.168.100.11	swift1.local-openstack.none  swift1  
192.168.100.12	swift2.local-openstack.none  swift2  
192.168.100.13	glance1.local-openstack.none  glance1  
192.168.100.14	compute1.local-openstack.none  compute1  
192.168.100.15	compute2.local-openstack.none  compute2  
192.168.100.16	keystone1.local-openstack.none  keystone1  
192.168.100.17	quantum1.local-openstack.none quantum1 



# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
"
}
exec { 'wget http://apt.puppetlabs.com/puppetlabs-release-precise.deb':
  path       => '/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin',
  cwd        => '/tmp',
  creates    => '/tmp/puppetlabs-release-precise.deb',
  alias      => 'get_puppet_apt'
}
file { '/tmp/puppetlabs-release-precise.deb':
  ensure   => 'file',
  subscribe  =>  Exec['get_puppet_apt'],
}
exec { 'dpkg -i /tmp/puppetlabs-release-precise.deb':
  path       => '/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin',
  subscribe  => File['/tmp/puppetlabs-release-precise.deb'],
  alias      => 'install_puppet_apt',
}

