# Basic commands for using Linux

## Articles

[BIOS](https://en.wikipedia.org/wiki/BIOS)

[Power-on self-test](https://en.wikipedia.org/wiki/Power-on_self-test)

[Disk partitioning](https://en.wikipedia.org/wiki/Disk_partitioning)

[Master boot record (MBR)](https://en.wikipedia.org/wiki/Master_boot_record)

[GUID Partition Table (GPT)](https://en.wikipedia.org/wiki/GUID_Partition_Table)

[Swap partitions](https://en.wikipedia.org/wiki/Paging#Unix_and_Unix-like_systems)

[Logical volume manager](https://en.wikipedia.org/wiki/Logical_Volume_Manager_(Linux))

[Device mapper](https://en.wikipedia.org/wiki/Device_mapper)

[Subnetwork](https://en.wikipedia.org/wiki/Subnetwork)

## Runlevels (targets)

"On Linux systems, run levels are operational levels that describe the state of the system with respect to what services are available."

[Maneuvering around runlevels on Linux](https://www.networkworld.com/article/3222070/maneuvering-around-run-levels-on-linux.html)

[Linux runlevels explained](https://www.liquidweb.com/kb/linux-runlevels-explained/)

Targets can be found in:

    /lib/systemd/system

Default target:

    /etc/systemd/system/default.target

Get default runlevel:

    systemctl get-default

Change default runlevel:

    systemctl set-default

Switch runlevels manually:

    systemctl isolate graphical.target

Can also reboot or shutdown using:

    reboot

or

    shutdown -r now

`shutdown [OPTIONS] [TIME] [WALL]` (i.e. shutdown flags hh:mm/+m message)

    shutdown now

## System logging

[Linux logging basics](https://www.loggly.com/ultimate-guide/linux-logging-basics/)

The boot log is found in:

    /var/log/dmesg

### rsyslog

Default configuration including default rules

    /etc/rsyslog.conf

Logs found under:

    /var/log/

Generate logs:

    logger -p <facility.severity> -t <tag> “Message here”

Log rotation:

    /etc/logrotate.conf

Force logrotate with verbose logging

    log rotate -fv /etc/logrotate.conf

## Disk management

### fdisk

To add a new drive to VM, shutdown -> storage settings -> add new drive.

List existing:

    fdisk -l 

To manage `/dev/sdb`

    fdisk /dev/sdb

### mkfs

Make a filesystem:

    mkfs -t TYPE DEVICE — for example:
    mkfs -t ext3 /dev/sdb2
    mkfs -t ext4 /dev/sdb3

### mount / umount

Mount device:

    mount DEVICE MOUNT_POINT
    mount /dev/sdb3 /opt

To list filesystems use `df`:

    df -h

Manual mounts DO NOT PERSIST! Add an entry in the /etc/fstab file.

Unmount device:

    umount DEVICE_OR_MOUNT_POINT

    umount /opt
    umount /dev/sdb3

Ppreparing a swap space:

    mkswap /dev/sdb1
    swapon /dev/sdb1

List swap spaces:

    swapon -s

Labeling a filesystem:

    e2label /dev/sdb3 opt

Check labels and UUIDs:

    lsblk -f

Or:

    blkid

### Logical Volume Manager (LVM)

What disks are available:

    lvmdiskscan

Or:

    fdisk -l

More info about the disks:

    lsblk

With paths:

    lsblk -p

Disk space usage:

    df -h

List physical volumes (PVs):

    pvs

Create PV:

    pvcreate PATH_TO_DISK_OR_PARTITION

Create volume group (VG):

    vgcreate VG_NAME PATH_TO_DISK_OR_PARTITION

List VGs:

    vgs

Create logical volume (LV) with size:

    lvcreate -L 1G -n lv_app vg_app

List LVs:

    lvs

Or:

    lvdisplay

## Networking

Show IP address (all equivalent):

    ip address
    ip addr
    ip a
    ip address show

Deprecated:

    ifconfig

Display hostname:

    hostname
    uname -n

Fully qualified domain name:

    hostname -f

Setting the hostname (does not persist!):

    hostname NAME

E.g.

    hostname webprod01

To persist:

    echo 'NAME' > /etc/hostname

E.g.

    echo 'webprod01' > /etc/hostname

Resolve host name:

    host
    dig

    host www.domain.com
    host 1.2.1.6

Define hostnames locally:

    vi /etc/hosts

Format: `IP FQDN` alias(es)

Control lookup order -> `/etc/nsswitch.conf`

    hosts: files dns
    hosts: files nis dns

`/etc/services` maps port names to port numbers

Get list of network devices

    ifconfig -a

Or:

    ip link

To configure a DHCP client (RHEL):

- edit `/etc/sysconfig/network-scripts/ifcfg-NETWORKDEVICENAME`
- add `BOOTPROTO=dhcp`

To configure a static IP address (RHEL) edit `/etc/sysconfig/network-scripts/eth0`:

    DEVICE=eth0
    BOOTPROTO=STATIC
    IPADDR=10.109.155.174
    NETMASK=255.255.255.0
    NETWORK=10.109.155.0
    BROADCAST=10.109.155.255
    GATEWAY=10.109.155.1
    ONBOOT=yes

Manually assign IP address:

    ip address add IP[/NETMASK] dev NETWORK_DEVICE

E.g.:

    ip address add 10.11.12.13 dev eth0

Or:

    ip address add 10.11.12.13/255.255.255.0 dev eth0

Then:

    ip link set eth0 up

`ifup`/`ifdown`

    ifup eth0
    ifdown eth0

TUI on RHEL

    nmtui

Test connectivity:

    ping HOST

Or:

    ping -c COUNT HOST

Examine route (use `-n` to skip DNS):

    traceroute -n HOSTNAME
    tracepath -n HOSTNAME

Netstat:

- `-n` numerical addresses and ports
- `-i` list of network interfaces
- `-r` route table (`netstat -rn`)
- `-p` PID and program used
- `-l` listening sockets (`netstat -nlp`)
- `-t` limit output to TCP (`netstat -ntlp`)
- `-u` limit output to UDP (`netstat -nulp`)

Packet sniffing with `tcpdump`

- `-n` numerical addresses and ports
- `-A` text (ASCII) output
- `-v` verbose mode
- `-vvv` even more verbose mode

`telnet` (outdated, but can be used for debugging)

    telnet HOST_OR_IP PORT_NUMBER

## Processes

List all running processes:

    ps aux 

List process status:

    ps

Options:

- `-e` everything, all processes
- `-f` full format listing
- `-u` username Display username's processes
- `-p` pid Display information for PID
- `-H` display as tree
- `--forest` display as tree

Other ways:

    pstree
    top
    htop

## Permissions

Another way to list groups:

    id -Gn

Change permissions:

    chmod

Options:

- `ugoa` user, group, other, all
- `+-=` add, subtract, set
- `rwx` read, write, execute

E.g.:

    chmod g+w sales.data
    chmod u+rwx,g-x sales.data
    chmod o= sales.data

Numeric values:

    r w x
    0 0 0  off
    1 1 1  on in binary
    4 2 1  on in decimal

Change group:

    chgrp GROUP FILE_OR_DIRECTORY

Set file creation mask:

    umask [-S] [mode]

Use `-S` to use symbolic notation. `umask` takes away permissions! 7 = no permissions.

Special modes -> `umask` is displayed in four digits, e.g. 0022. If on, marked as `s`/`S` (or `t`/`T` in the case of sticky) in x field of user, group or other. If the underlying permission (execute) is not set, a capital letter is used.

E.g. `-rwSr--r--` (user execute not set)

`setuid` -> sets user ID on execution, not honored on shell scripts

`setgid` -> set group ID on execution

`sticky` -> use on a directory to allow only the owner of the file/directory to delete it

`setgid` on directory causes new files to inherit the group of the directory. `setgid` caues directories to inherit the setgid bit.

    setuid setgid sticky
    0      0      0
    1      1      1
    4      2      1

Add the setuid attribute:

    chmod u+s /path/to/file
    chmod 4755 /path/to/file

Remove the setuid attribute:

    chmod u-s /path/to/file
    chmod 0755 /path/to/file

Finding setuid files:

    find / -perm /4000 [-ls]

Finding setgid files:

    find / -perm /2000 [-ls]

Add setgid:

    chmod g+s /path/to/file
    chmod 2755 /path/to/file

Remove setgid:

    chmod g-s /path/to/file
    chmod 0755 /path/to/file

Set both setuid and setgid:

    chmod ug+s /path/to/file
    chmod 6755 /path/to/file

Add sticky:

    chmod 0+t /path/to/directory
    chmod 1777 /path/to/directory

Removing sticky:

    chmod 0-t /path/to/directory
    chmod 0777 /path/to/directory

## Viewing and editing files

Displaying contents:

    cat file
    more file # use less
    less file # less is more than more :)
    head file
    tail file

To follow the file:

    tail -f file

Start vim in read-only mode:

    view [file]

## Shell scripting

Conditions:

- `-d FILE` Is the file a directory
- `-e FILE` Does the file exist
- `-f FILE` Does the file exist and is it a regular file
- `-r FILE` Is the file readable by you
- `-s FILE` Does the file exist and is it not empty
- `-w FILE` Is the file writable by you
- `-x FILE` Is the file executable by you
- `-z STRING` Is the string empty
- `-n STRING` Is the string not empty
- `STRING1 = STRING2` Are strings equal
- `STRING1 != STRING2` Are strings unequal

Arithmetic test operators:

- `-eq`
- `-ne`
- `-lt`
- `-le`
- `-gt`
- `-ge`

E.g.:

    MY_SHELL="bash"
    
    if [ "$MY_SHELL" = "bash" ]
    then
        echo "You seem to like the bash shell."
    elif [ "$MY_SHELL" = "csh" ]
    then
        echo "You seem to like the csh shell."
    else
        echo "You don't seem to like the bash or csh shell."
    fi

For loop:

    for VARIABLE_NAME in ITEM_1 ITEM_N
    do
        command 1
        command 2
        command N
    done

Arguments accessed via `$n`. All arguments `$@`.

Read from STDIN:

    read -p "PROMPT" VARIABLE

Assign output of command to variable:

    VARIABLE_NAME=$(command)

## Miscellaneous

Create a symlink:

    ln -s /path/to/file /path/to/symlink

Create or update a symlink:

    ln -fs /path/to/file /path/to/symlink

Ese arguments from previous command:

    COMMAND !*

Use the most recent command starting with specified letters:

    ![LETTERS HERE]

For example:

    cat file1.txt
    cd ../../somewhere
    !ca # -> cat file.txt
