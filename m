From: mihcom@via.com.ua (Mihcom)
Date: Fri, 17 Feb 2006 16:42:42 +0000
Subject: [lm-sensors] Can't access procfs/sysfs file with kernel
Message-Id: <1896546447.20060217184242@via.com.ua>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
I tried to get lm_sensors run on my Red Hat Fedora Core 3 (native kernel 2.6.9-1.667smp). The motherboard is Intel SE7221BK1-E. From the documentation on the motherboard I learned that this motherboard uses LM96000 sensor for hardware monitoring (ftp://download.intel.com/support/motherboards/server/sb/se7221bk1tps1.pdf page 80). From LM-Sensors website I learned that I have to use lm85 driver with this chipset. So I got the latest version of lm_sensors (2.10.0) and tried to force this driver to run as it subscribed in http://secure.netroedge.com/~lm78/newdrivers.html. Here are my actions:

$ i2cdetect -l
i2c-0   smbus           SMBus I801 adapter at 0400              Non-I2C SMBus adapter

$ i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX 08 XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
30: XX XX 32 XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX 42 XX 44 XX XX XX XX XX XX XX XX XX XX XX
50: UU XX UU XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX 64 XX XX XX XX 69 XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX

The output is involved - which address should I use? So I tried the following:

$ modprobe lm85 force_LM96000=0,0x08

$ lsmod
Module                  Size  Used by
lm85                   23273  0
i2c_dev                13249  0
ipt_REDIRECT            5953  1
ip_nat_irc              8369  0
ip_nat_ftp              8881  0
ip_conntrack_irc       75505  1 ip_nat_irc
ip_conntrack_ftp       76145  1 ip_nat_ftp
ipt_limit               6337  2
ipt_LOG                10049  2
iptable_mangle          6721  0
iptable_nat            27237  4 ipt_REDIRECT,ip_nat_irc,ip_nat_ftp
ipt_REJECT             10433  1
ipt_state               5825  5
ip_conntrack           45701  6 ip_nat_irc,ip_nat_ftp,ip_conntrack_irc,ip_conntrack_ftp,iptable_nat,ipt_state
iptable_filter          6721  1
ip_tables              20929  8 ipt_REDIRECT,ipt_limit,ipt_LOG,iptable_mangle,iptable_nat,ipt_REJECT,ipt_state,iptable_filter
eeprom                 12385  0
i2c_sensor              7489  2 lm85,eeprom
i2c_i801               11597  0
i2c_core               25921  5 lm85,i2c_dev,eeprom,i2c_sensor,i2c_i801
md5                     8001  1
ipv6                  235105  30
ppp_synctty            14017  0
ppp_async              15041  1
crc_ccitt               6081  1 ppp_async
ppp_generic            31061  6 ppp_synctty,ppp_async
slhc                   11073  1 ppp_generic
button                 10449  0
battery                12485  0
ac                      8773  0
uhci_hcd               32729  0
ehci_hcd               31941  0
hw_random               9301  0
8139too                27329  0
mii                     8641  1 8139too
e1000                  80205  0
floppy                 57297  0
dm_snapshot            20837  0
dm_zero                 6337  0
dm_mirror              24989  2
ext3                  117961  2
jbd                    59353  1 ext3
dm_mod                 56773  6 dm_snapshot,dm_zero,dm_mirror
ata_piix               12357  3
libata                 43077  1 ata_piix
sd_mod                 20289  5
scsi_mod              112136  2 libata,sd_mod

So lm86 module loaded but in the dmesg I read this - lm85: Unknown parameter `force_LM96000'
Now when I'm trying to run sensors:

$ sensors -s
Can't access procfs/sysfs file
Unable to find i2c bus information;
For 2.6 kernels, make sure you have mounted sysfs and libsensors
was compiled with sysfs support!
For older kernels, make sure you have done 'modprobe i2c-proc'!

I have mouted sysfs:
$ mount
/dev/mapper/VolGroup00-LogVol00 on / type ext3 (rw)
none on /proc type proc (rw)
none on /sys type sysfs (rw)
none on /dev/pts type devpts (rw,gid=5,modeb0)
usbfs on /proc/bus/usb type usbfs (rw)
/dev/sda1 on /boot type ext3 (rw)
none on /dev/shm type tmpfs (rw)
none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)

And also I suppose that the latest version lm_sensors is compiled with sysfs support.

What is the problem?
-- 
? ?????????,
 Mihcom                          mailto:mihcom at via.com.ua
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060217/6f081721/attachment-0001.html
