From: ballen@gravity.phys.uwm.edu (Bruce Allen)
Date: Wed, 01 Mar 2006 22:07:12 +0000
Subject: [lm-sensors] HT1000 support (see lm_sensors ticket 2031,
Message-Id: <Pine.LNX.4.62.0603011604060.27761@trinity.phys.uwm.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.62.0603010955280.24174@trinity.phys.uwm.edu>
In-Reply-To: <Pine.LNX.4.62.0603010955280.24174@trinity.phys.uwm.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>> I loaded the adm1026 module by hand:
>> 
>> [root at nemo-slave0017 ~]# lsmod | egrep '(i2c|adm)'
>> adm1026                46736  0
>> i2c_piix4              14480  0
>> adm1025                27156  0
>> hwmon_vid               7040  2 adm1026,adm1025
>> i2c_isa                10624  0
>> i2c_dev                17408  0
>> i2c_core               30720  6 
>> adm1026,i2c_piix4,adm1025,eeprom,i2c_isa,i2c_dev
>> 
>> I have:
>> [root at nemo-slave0017 ~]# ls /sysfs
>> block  bus  class  devices  firmware  kernel  module  power
>> [root at nemo-slave0017 ~]# ls /sys
>> block  bus  class  devices  firmware  kernel  module  power
>> 
>
> send
> dmesg|tail -n 30

[root at nemo-slave0017 ~]# modprobe i2c_piix4
[root at nemo-slave0017 ~]# modprobe adm1026
[root at nemo-slave0017 ~]# dmesg | tail -n 30
md: ... autorun DONE.
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel at redhat.com
cdrom: open failed.
cdrom: open failed.
EXT3 FS on sda3, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 5116692k swap on /dev/sda2.  Priority:-1 extents:1 across:5116692k
tg3: eth0: Link is up at 1000 Mbps, full duplex.
tg3: eth0: Flow control is off for TX and off for RX.
i2c /dev entries driver
lp: driver loaded but no devices found
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
Installing knfsd (copyright (C) 1996 okir at monad.swb.de).
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: recovery directory /var/lib/nfs/v4recovery doesn't exist
NFSD: starting 90-second grace period
ipmi message handler version 38.0
IPMI System Interface driver.
ipmi_si: Trying "kcs" at I/O port 0xca8
  IPMI kcs interface initialized
ipmi device interface
eth0: no IPv6 routers present

> and try
> ls /sys/class
> (there is typicaly hwmon class, if yes, list it too)

[root at nemo-slave0017 ~]# ls /sys/class/
cpuid  firmware  graphics  hwmon  i2c-adapter  i2c-dev  input  ipmi  mem 
misc  msr  net  pci_bus  printer  scsi_device  scsi_host  tty  usb 
usb_device  usb_host  vc
[root at nemo-slave0017 ~]# ls /sys/class/hwmon/
[root at nemo-slave0017 ~]# ls /sys/class/i2c-adapter/
i2c-9191
[root at nemo-slave0017 ~]# ls /sys/class/i2c-dev/
[root at nemo-slave0017 ~]#


