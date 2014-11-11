VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.provision :shell, path: "bootstrap.sh"
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 5432, host: 5000
  config.vm.synced_folder ".apt-cache", "/var/cache/apt/archives"

  config.vm.provider "virtualbox" do |vb|
   vb.customize ["modifyvm", :id, "--memory", "1024"]
  end
end
