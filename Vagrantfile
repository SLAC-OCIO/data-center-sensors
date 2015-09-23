###
# vagrant file for data-center-sensors
###

name = "data-center-sensors"

Vagrant.configure(2) do |config|

  config.vm.box = "lamudi/centos-7.0"

    # set cache scope for cachier, if installed
    if Vagrant.has_plugin?('vagrant-cachier')
      config.cache.scope = :box
    end

    config.vm.provider "virtualbox" do |vb|
        vb.customize ["modifyvm", :id, "--memory", 2048]
        vb.customize ["modifyvm", :id, "--cpus", 2]
      end

    config.vm.define name do |node|
      node.vm.hostname = name
      node.vm.network :private_network, ip: '192.168.13.37'
      # meteor port
      config.vm.network :forwarded_port, guest: 3000, host: 3000
    end

    # If true, then any SSH connections made will enable agent forwarding.
    config.ssh.forward_agent = true

    # sync folder with host
    config.vm.synced_folder ".", "/vagrant", :owner => "vagrant", :group => "vagrant"
    
    # install meteor as vagrant user
    config.vm.provision "shell", inline: "curl https://install.meteor.com/ | sh", privileged: false

    # fix issues with mongo on shared filesystems as per
    # http://stackoverflow.com/questions/25712468/cant-create-working-meteor-js-project-on-a-vagrant-box
    config.vm.provision "shell", inline: "mkdir -p /home/vagrant/.meteor/local && ln -sf /home/vagrant/.meteor/local/ /vagrant/.meteor/ && sudo chown -R vagrant:vagrant /home/vagrant/.meteor/local/"
    
    # run meteor for the app; need to install screen first
    config.vm.provision "shell", inline: "yum install -y screen"
    # config.vm.provision "shell", inline: "cd /vagrant/ && screen /usr/local/bin/meteor --verbose"
    # vagrant ssh -c "cd /vagrant && /usr/local/bin/meteor --verbose"
    
end
