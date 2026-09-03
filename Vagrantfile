Vagrant.configure("2") do |config|

  config.vm.define "control" do |c|
    c.vm.box = "ubuntu/jammy64"
    c.vm.hostname = "control"

    c.vm.network "private_network", ip: "192.168.56.104"

    c.vm.provider "virtualbox" do |v|
      v.memory = "1024"
      v.cpus = 1
    end

    c.vm.provision "shell", path: "provision-control.sh"

  end

  config.vm.define "frontend" do |f|
    f.vm.box = "ubuntu/jammy64"
    f.vm.hostname = "frontend"

    f.vm.network "private_network", ip: "192.168.56.101"

    f.vm.provider "virtualbox" do |v|
      v.memory = "1024"
      v.cpus = 1
    end

    f.vm.provision "shell", path: "provision-client.sh", env: { "VM_NAME" => f.vm.hostname }

  end

  config.vm.define "backend" do |b|
    b.vm.box = "ubuntu/jammy64"
    b.vm.hostname = "backend"

    b.vm.network "private_network", ip: "192.168.56.102"

    b.vm.provider "virtualbox" do |v|
      v.memory = "1024"
      v.cpus = 1
    end

    b.vm.provision "shell", path: "provision-client.sh", env: { "VM_NAME" => b.vm.hostname }

  end

  config.vm.define "database" do |d|
    d.vm.box = "ubuntu/jammy64"
    d.vm.hostname = "database"

    d.vm.network "private_network", ip: "192.168.56.103"

    d.vm.provider "virtualbox" do |v|
      v.memory = "1024"
      v.cpus = 1
    end

    d.vm.provision "shell", path: "provision-client.sh", env: { "VM_NAME" => d.vm.hostname }
  end

end