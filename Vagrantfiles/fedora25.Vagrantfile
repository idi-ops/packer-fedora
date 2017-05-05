Vagrant.configure(2) do |config|
  config.vm.box = "inclusivedesign/fedora24"

  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
    vb.memory = "2048"
    vb.customize ["modifyvm", :id, "--cpus", "2"]
    vb.customize ["modifyvm", :id, "--vram", "128"]
    vb.customize ["modifyvm", :id, "--accelerate3d", "on"]
    vb.customize ["modifyvm", :id, "--audio", "null", "--audiocontroller", "ac97"]
    vb.customize ["modifyvm", :id, "--ioapic", "on"]
    vb.customize ["setextradata", "global", "GUI/SuppressMessages", "all"]
  end
end
