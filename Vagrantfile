Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.provision "shell", inline: <<~EOF
    apt-get update
    apt-get install --yes python3-pip
    sudo -u vagrant python3 -m pip install --user --upgrade --no-warn-script-location ansible
  EOF
end
