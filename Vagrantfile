# -*- mode: ruby -*-
# vi: set ft=ruby :

domain = 'local-openstack.none'

puppet_nodes = [
# {:hostname => 'controller',   :ip => '192.168.100.10', :box => 'precise64', :fwdhost => 8140, :fwdguest => 8140, :ram => 512},
# {:hostname => 'swift1',       :ip => '192.168.100.11', :box => 'precise64'},
# {:hostname => 'swift2',       :ip => '192.168.100.12', :box => 'precise64'},
# {:hostname => 'swift3',       :ip => '192.168.100.13', :box => 'precise64'},
  {:hostname => 'swift-saio',   :ip => '192.168.100.14', :box => 'precise64', :ram => 512},
# {:hostname => 'glance1',      :ip => '192.168.100.15', :box => 'precise64'},
# {:hostname => 'compute1',     :ip => '192.168.100.16', :box => 'precise64'},
# {:hostname => 'compute2',     :ip => '192.168.100.17', :box => 'precise64'},
# {:hostname => 'keystone1',    :ip => '192.168.100.18', :box => 'precise64'},
# {:hostname => 'quantum1',     :ip => '192.168.100.19', :box => 'precise64'},
# {:hostname => 'jenkins1',     :ip => '192.168.100.20', :box => 'precise64'},
]


Vagrant::Config.run do |config|
  puppet_nodes.each do |node|
    config.vm.define node[:hostname] do |node_config|
      node_config.vm.box = node[:box]
      node_config.vm.box_url = 'http://cloud-images.ubuntu.com/precise/current/precise-server-cloudimg-vagrant-i386-disk1.box'
      node_config.vm.host_name = node[:hostname] + '.' + domain
      node_config.vm.network :hostonly, node[:ip]

      if node[:fwdhost]
        node_config.vm.forward_port(node[:fwdguest], node[:fwdhost])
      end

      memory = node[:ram] ? node[:ram] : 256;
      node_config.vm.customize [
        'modifyvm', :id,
        '--name', node[:hostname],
        '--memory', memory.to_s
      ]

      node_config.vm.provision :puppet do |puppet|
        puppet.manifests_path = 'provision/manifests'
        puppet.module_path = 'provision/modules'
      end
    end
  end
end
