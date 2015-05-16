# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'ubuntu/trusty64'
  # config.vm.network :forwarded_port, guest: 80, host: 8088
  config.vm.network 'private_network', ip: '192.168.60.66'
  config.vm.hostname = 'lambda-api-vagrant'

  config.vm.synced_folder '.', '/vagrant', id: 'vagrant-root',
    owner: 'vagrant',
    group: 'vagrant',
    mount_options: ['dmode=775,fmode=664']

  config.vm.provider :virtualbox do |vb|
    vb.customize ['modifyvm', :id, '--memory', '2048']
    vb.customize ['guestproperty', 'set', :id, '/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold', 10000]
  end

  config.vm.provision :shell, path: 'devops/bootstrap.sh', privileged: false
end
