dir = Dir.pwd
vagrant_dir = File.expand_path(File.dirname(__FILE__))

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "ubuntu/trusty64"

  # Set the url for the box.
  
  config.ssh.forward_x11 = true
  config.ssh.insert_key = false

  config.vm.network "forwarded_port", guest: 3000, host: 3100
  config.vm.network "forwarded_port", guest: 3001, host: 3101
  config.vm.network "forwarded_port", guest: 3002, host: 3102
  config.vm.network "forwarded_port", guest: 3003, host: 3103
  config.vm.network "forwarded_port", guest: 5001, host: 5101
  config.vm.network "forwarded_port", guest: 9200, host: 9300
  #config.vm.network "forwarded_port", guest: 5432, host: 5432

  config.vm.provider :virtualbox do |vb|
    vb.gui = false
    vb.customize ["modifyvm", :id, "--memory", "1024"]
    # vb.customize ['modifyvm', :id, '--hostonlyadapter2', 'vboxnet0']
    vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/vagrant", "1"]
  end

  config.vm.define :receta2 do |receta|
    receta.vm.network :private_network, type: "dhcp"
    receta.vm.hostname = "receta2-dev"
  end  
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "provision/main.yml"
  end
end
