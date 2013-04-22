vagrant-hadoop-cluster
======================

This Vagrant environment will automatically set up a 3 datanode + master + backup hadoop cluster. It comes with the files necessary to run the canonical WordCount MapRedude demo.

## Requirements

* Install VirtualBox ()
* Install Vagrant ()
* A Vagrant box named lucid64

## Installation Steps

Install Vagrant and VirtualBox. 

Download the base box if necessary:

* $ vagrant box add lucid64 http://files.vagrantup.com/lucid64.box

Next: 

* $ git clone git://github.com/cacois/vagrant-hadoop-cluster.git
* $ cd vagrant-hadoop-cluster
* $ vagrant up

It will be a few minutes while Vagrant sets up your VMs. Then:

* $ vagrant ssh master

You will now be at the terminal of your 'master' VM, rather than your host system. Continue:

* $ cd /opt/hadoop-1.0.4/bin
* $ hadoop namenode -format

Now your namenode is formatted. Next we will start up all the services in the cluster. To make life easier, I recommend you first ssh into each of the following VMs from the master and accept the RSA fingerprint, to avoid prompts:

* $ ssh hadoop1; exit
* $ ssh hadoop2; exit
* $ ssh hadoop3; exit
* $ ssh backup; exit

Now, you can start the services:

* $ ./start-all.sh

You should be able to monitor the cluster now by going to [http://192.168.3.10:50070](http://192.168.3.10:50070) in your host browser.

## WordCount Demo

Now that your hadoop cluster is installed and running, its time for a MapReduce demo!

Once ssh'd into your master VM:

* cd ~/app

