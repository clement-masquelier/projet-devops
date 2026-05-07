Vagrant.configure("2") do |config|
    config.vm.box = "generic/debian12"

    config.vm.define "k3s-server" do |server|
        server.vm.hostname = "k3s-server"
        server.vm.network "private_network", ip: "192.168.56.10"

        server.vm.provider "virtualbox" do |vb|
            vb.name = "Vagrant_k3s_server"
            vb.memory = "2048"
        end

        # Injection de la clé SSH générée dans le fichier cloud-config.yaml
        pub_key = File.read("./ssh_keys/k3s_ansible_key.pub").strip rescue "CLE_NON_TROUVEE"

        server.vm.provision "shell", inline: <<-SHELL
        echo "🔑 Configuration de l'accès SSH Ansible..."
        mkdir -p /home/vagrant/.ssh
        
        # Ajout de la clé seulement si elle n'y est pas déjà
        if ! grep -q "#{pub_key}" /home/vagrant/.ssh/authorized_keys 2>/dev/null; then
            echo "#{pub_key}" >> /home/vagrant/.ssh/authorized_keys
        fi
        
        # Sécurisation stricte des droits (obligatoire pour SSH)
        chmod 700 /home/vagrant/.ssh
        chmod 600 /home/vagrant/.ssh/authorized_keys
        chown -R vagrant:vagrant /home/vagrant/.ssh
        echo "✅ Accès SSH configuré avec succès !"
        SHELL
    end
    
    config.vm.define "grafana" do |server|
        server.vm.hostname = "grafana"
        server.vm.network "private_network", ip: "192.168.56.11"

        server.vm.provider "virtualbox" do |vb|
            vb.name = "Vagrant_grafana"
            vb.memory = "2048"
        end

        # Injection de la clé SSH générée dans le fichier cloud-config.yaml
        pub_key = File.read("./ssh_keys/k3s_ansible_key.pub").strip rescue "CLE_NON_TROUVEE"

        server.vm.provision "shell", inline: <<-SHELL
        echo "🔑 Configuration de l'accès SSH Ansible..."
        mkdir -p /home/vagrant/.ssh
        
        # Ajout de la clé seulement si elle n'y est pas déjà
        if ! grep -q "#{pub_key}" /home/vagrant/.ssh/authorized_keys 2>/dev/null; then
            echo "#{pub_key}" >> /home/vagrant/.ssh/authorized_keys
        fi
        
        # Sécurisation stricte des droits (obligatoire pour SSH)
        chmod 700 /home/vagrant/.ssh
        chmod 600 /home/vagrant/.ssh/authorized_keys
        chown -R vagrant:vagrant /home/vagrant/.ssh
        echo "✅ Accès SSH configuré avec succès !"
        SHELL
    end

end