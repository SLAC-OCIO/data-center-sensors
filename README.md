# data-center-sensors

This is a simple frontend providing heatmaps of our data center. It provides a simple REST API plus a reactive visualisation of the numerous sensors we have around our data center building.


### Vagrant Box for data-center-sensors

To provide a private development environment, a Vagrantfile is provided that will spin up a virtual machine on your development machine and provide a complete environment from which to test your code.

Specifically, the Vagrantfile will create a `synced_folder` that provides a shared file system between your host machine and the vagrant vm. Any changes you make locally on this folder will be reflected on the vm. We make use of this by by mounting the data-center-sensor repository (this) onto the vagrant vm and running meteor off it.

Instructions:

1. Install Vagrant as per [http://www.vagrantup.com/downloads]
2. Install Virtual Box [https://www.virtualbox.org/wiki/Downloads]
3. Git clone this repository using [github desktop](https://desktop.github.com/) or command line `git clone` with the repo path `https://github.com/SLACNationalAcceleratorLaboratory/data-center-sensors`. You may also clone via `git@github.com:SLACNationalAcceleratorLaboratory/data-center-sensors.git` which is recommended if using ssh keys.
4. Import the vm image required for this vagrant box; run the command `vagrant box add lamudi/centos-7.0`
5. `cd` into the directory that was just created from the previous step.
6. run `vagrant up`
7. Run the meteor app with `vagrant ssh -c "cd /vagrant && /usr/local/bin/meteor --verbose"`; use ctrl-c to stop the meteor service.
8. open a web browser to `http://localhost:3000`
9. Edit code on your local machine and it should automatically be updated at [http://localhost:3000]
10. Shutdown the vagrant box using `vagrant destroy`

If you need to ssh into the vagrant box, you may do so via `vagrant ssh`; we do this in step 5.

