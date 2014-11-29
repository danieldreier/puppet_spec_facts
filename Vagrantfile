# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    ### Define options for all VMs ###

  config.vm.provision "shell", path: "scripts/gather_facts.sh"

  config.vm.define :openbsd55 do |node|
    node.vm.box = 'openbsd55'
    node.vm.box_url = 'https://github.com/jose-lpa/veewee-openbsd/releases/download/v0.5.5/openbsd55.box'
    node.vm.hostname = 'server.example.com'
  end
  config.vm.define :freebsd10 do |node|
    node.vm.box = 'hfm4/freebsd-10.0'
    node.vm.hostname = 'server.example.com'
  end
  config.vm.define :ubuntu1310_64 do |node|
    node.vm.box = 'puppetlabs/ubuntu-13.10-64-puppet'
    node.vm.hostname = 'server.example.com'
  end
  config.vm.define :arch do |node|
    node.vm.box = 'jfredett/arch-puppet'
    node.vm.hostname = 'server.example.com'
  end
  config.vm.define :sles11sp1 do |node|
    node.vm.box = 'sles-11sp1-x64-vbox4210'
    node.vm.box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/sles-11sp1-x64-vbox4210.box'
    node.vm.hostname = 'server.example.com'
  end

  # boxes without puppet, need to figure out how to install
#  config.vm.define :opensuse13_64_nocm do |node|
#    node.vm.box = 'elatov/opensuse13-64'
#    node.vm.hostname = 'server.example.com'
#  end
#  config.vm.define :gentoo_nocm do |node|
#    node.vm.box = 'd11wtq/gentoo'
#    node.vm.hostname = 'server.example.com'
#  end

  ## Centos
  config.vm.define :centos5_32_foss do |node|
    node.vm.box = 'puppetlabs/centos-5.11-32-puppet'
    node.vm.hostname = 'server.example.com'
  end
  config.vm.define :centos5_32_pe do |node|
    node.vm.box = 'puppetlabs/centos-5.11-32-puppet-enterprise'
    node.vm.hostname = 'server.example.com'
  end
  config.vm.define :centos5_64_foss do |node|
    node.vm.box = 'puppetlabs/centos-5.11-64-puppet'
    node.vm.hostname = 'server.example.com'
  end
  config.vm.define :centos5_64_pe do |node|
    node.vm.box = 'puppetlabs/centos-5.11-64-puppet-enterprise'
    node.vm.hostname = 'server.example.com'
  end

  # didn't work
  config.vm.define :centos65_32_pe do |node|
    node.vm.box = 'puppetlabs/centos-6.5-32-puppet-enterprise'
    node.vm.hostname = 'server.example.com'
  end

  config.vm.define :centos65_64_pe do |node|
    node.vm.box = 'puppetlabs/centos-6.5-64-puppet-enterprise'
    node.vm.hostname = 'server.example.com'
  end

  # didn't work
  config.vm.define :centos65_64_foss do |node|
    node.vm.box = 'puppetlabs/centos-6.5-64-puppet'
    node.vm.hostname = 'server.example.com'
  end
  config.vm.define :centos65_64_foss do |node|
    node.vm.box = 'puppetlabs/centos-6.5-64-puppet-enterprise'
    node.vm.hostname = 'server.example.com'
  end

  # Debian
  config.vm.define :debian76_32_foss do |node|
    node.vm.box = 'puppetlabs/debian-7.6-32-puppet'
    node.vm.hostname = 'server.example.com'
  end
  config.vm.define :debian76_32_foss do |node|
    node.vm.box = 'puppetlabs/debian-7.6-32-puppet-enterprise'
    node.vm.hostname = 'server.example.com'
  end
  config.vm.define :debian76_64_foss do |node|
    node.vm.box = 'puppetlabs/debian-7.6-64-puppet'
    node.vm.hostname = 'server.example.com'
  end
  config.vm.define :debian76_64_foss do |node|
    node.vm.box = 'puppetlabs/debian-7.6-64-puppet-enterprise'
    node.vm.hostname = 'server.example.com'
  end

  # Ubuntu
  config.vm.define :ubuntu1204_32_foss do |node|
    node.vm.box = 'puppetlabs/ubuntu-12.04-32-puppet'
    node.vm.hostname = 'server.example.com'
  end
  config.vm.define :ubuntu1204_32_foss do |node|
    node.vm.box = 'puppetlabs/ubuntu-12.04-32-puppet-enterprise'
    node.vm.hostname = 'server.example.com'
  end
  config.vm.define :ubuntu1204_64_foss do |node|
    node.vm.box = 'puppetlabs/ubuntu-12.04-64-puppet'
    node.vm.hostname = 'server.example.com'
  end
  config.vm.define :ubuntu1204_64_foss do |node|
    node.vm.box = 'puppetlabs/ubuntu-12.04-64-puppet-enterprise'
    node.vm.hostname = 'server.example.com'
  end

  config.vm.define :ubuntu1404_32_foss do |node|
    node.vm.box = 'puppetlabs/ubuntu-14.04-32-puppet'
    node.vm.hostname = 'server.example.com'
  end
  config.vm.define :ubuntu1404_32_foss do |node|
    node.vm.box = 'puppetlabs/ubuntu-14.04-32-puppet-enterprise'
    node.vm.hostname = 'server.example.com'
  end
  config.vm.define :ubuntu1404_64_foss do |node|
    node.vm.box = 'puppetlabs/ubuntu-14.04-64-puppet'
    node.vm.hostname = 'server.example.com'
  end
  config.vm.define :ubuntu1404_64_foss do |node|
    node.vm.box = 'puppetlabs/ubuntu-14.04-64-puppet-enterprise'
    node.vm.hostname = 'server.example.com'
  end

  # centos
  config.vm.define :centos7_64_foss do |node|
    node.vm.box = 'puppetlabs/centos-7.0-64-puppet'
    node.vm.hostname = 'server.example.com'
  end
  config.vm.define :centos7_64_foss do |node|
    node.vm.box = 'puppetlabs/centos-7.0-64-puppet-enterprise'
    node.vm.hostname = 'server.example.com'
  end

end
