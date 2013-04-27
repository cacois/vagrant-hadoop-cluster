vagrant-hadoop-cluster
======================

This Vagrant environment will automatically set up a 3 datanode + master + backup hadoop cluster. It comes with the files necessary to run the canonical WordCount MapRedude demo.

## Requirements

* Install VirtualBox (https://www.virtualbox.org/wiki/Downloads)
* Install Vagrant (http://downloads.vagrantup.com/)
* A Vagrant box named precise64

## Installation Steps

Install Vagrant and VirtualBox. 

Download the base box if necessary:

```
$ vagrant box add lucid64 http://files.vagrantup.com/precise64.box
```

Next: 

```
$ git clone git://github.com/cacois/vagrant-hadoop-cluster.git
$ cd vagrant-hadoop-cluster
$ vagrant up
```

It will be a few minutes while Vagrant sets up your VMs. Then:

```
$ vagrant ssh master
```

You will now be at the terminal of your 'master' VM, rather than your host system. Continue:

```
$ cd /opt/hadoop-1.0.4/bin
$ sudo hadoop namenode -format
```

Now your namenode is formatted. Next we will start up all the services in the cluster. To make life easier, I recommend you first ssh into each of the following VMs from the master and accept the RSA fingerprint, to avoid prompts:

```
$ ssh hadoop1
$ exit
$ ssh hadoop2
$ exit
$ ssh hadoop3
$ exit
$ ssh backup
$ exit
```

Now, you can start the services:

```
$ sudo ./start-all.sh
```

You should be able to monitor the cluster now by going to [http://192.168.3.10:50070](http://192.168.3.10:50070) in your host browser.

## WordCount Demo

Now that your hadoop cluster is installed and running, its time for a MapReduce demo!

Ensure that you are ssh'd into your master VM, and that all services of the Hadoop cluster are running. Then:

```
$ cd ~/app
```

Now it is time to put some data into your Hadoop cluster. Check out the two small files provided for an inital test:

```
$ cat input/file01
$ cat input/file02
```

COpy these files into HDFS with the following command:

```
$ sudo /opt/hadoop-1.0.4/bin/hadoop fs -copyFromLocal /home/vagrant/app/input/ /user/root/wordcount/input/
```
This places the files within `/home/vagrant/app/input/` into HDFS at the HDFS path `/user/root/wordcount/input/`.

Also provided is a small Java MapReduce program:

```
$ cat WordCount.java
```

This application is designed to count the number of times each word is used in the target file(s). To use it, we must first compile the code into a jar. The commands to do this are:

```
$ javac -classpath /opt/hadoop-1.0.4/hadoop-core-1.0.4.jar -d wordcount_classes WordCount.java
$ jar -cvf wordcount.jar -C wordcount_classes/ .
```

...but I've also provided a script to handle this in one step, if you prefer:

```
$ ./gen_jar.sh
```

Now run:

```
$ sudo ./run.sh
```

This will run the following command:

```
/opt/hadoop-1.0.4/bin/hadoop jar wordcount.jar org.myorg.WordCount /user/root/wordcount/input /user/root/wordcount/output
```

MapReduce will proceed to run the WordCount program against the files in `/user/root/wordcount/input`. You will see console output letting you know how things are going. Once the process is complete, run the following to view the results:

```
$ ./view_output.sh
```

Cheers