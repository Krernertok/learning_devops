# Setting up CentOS 7 on Virtualbox

## Basic setup

**Enable internet connection inside VM:**

    sudo vi /etc/sysconfig/network-scripts/ifcfg-enp0s3

Change the `ONBOOT` variable  from `no` to `yes`

    ONBOOT=yes

## Useful links

[How to SSH into CentOS in Virtualbox](https://www.ericlin.me/2016/05/how-to-ssh-into-centos-in-virtualbox/)
