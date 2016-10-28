#!/bin/bash -xe
sudo /etc/init.d/jenkins stop
cd /data/restore
tar xzvf backup*
sudo cp -R jenkins-backup/* $JENKINS_HOME/
sudo chown jenkins:jenkins -R $JENKINS_HOME/
sudo /etc/init.d/jenkins start