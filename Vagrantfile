Vagrant.configure("2") do |config|
    config.vm.box = "generic/debian12"

    config.vm.define "k3s-server" do |server|
        server.vm.hostname = "k3s-server"
        server.vm.network "private_network", ip: "192.168.56.10"

        server.vm.provider "virtualbox" do |vb|
            vb.name = "Vagrant_k3s_server"
            vb.memory = "2048"
        end
    end
end