From: tenchy@pacbell.net (John Jones)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: lm_sensors problem booting after install
Message-Id: <1078427854.6610.35.camel@AMD64Home>
List-Id: <lm-sensors.vger.kernel.org>
References: <4044E51F.9050908@pacbell.net>
In-Reply-To: <4044E51F.9050908@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Sorry for the less then informative email.  Here is the particulars

i2c-2.8.4  lm_sensors-2.8.4

Linux AMD64Home 2.4.20-30.9 #1 Wed Feb 4 20:45:39 EST 2004 i686 athlon
i386 GNU/Linux

From the Motherboard book I have:
Nforce3 150 chip set
IT8712F I/O Controller

What I can see from the display as it was running was:

modprobe i2c-isa ran fine.
modprobe it87 did some strange things to the kernal which prevented the
mouse, iptables, and the Nvidia video drivers from working correctly. I
was going to include the boot.log sections but they are mysteriously
blank.

[root@AMD64Home doc]# /sbin/modprobe i2c-dev
[root@AMD64Home doc]# /sbin/modprobe i2c-isa
[root@AMD64Home doc]# /sbin/modprobe i2c-piix4
/lib/modules/2.4.20-30.9/kernel/drivers/i2c/busses/i2c-piix4.o:
unresolved symbol dmi_scan_mach
/lib/modules/2.4.20-30.9/kernel/drivers/i2c/busses/i2c-piix4.o: insmod
/lib/modules/2.4.20-30.9/kernel/drivers/i2c/busses/i2c-piix4.o failed
/lib/modules/2.4.20-30.9/kernel/drivers/i2c/busses/i2c-piix4.o: insmod
i2c-piix4 failed
[root@AMD64Home doc]# sensors -s
Can't access procfs/sysfs file
Unable to find i2c bus information;
For 2.6 kernels, make sure you have mounted sysfs!
For older kernels, make sure you have done 'modprobe i2c-proc'!
[root@AMD64Home doc]# /sbin/modprobe i2c-proc
[root@AMD64Home doc]# sensors -s
No sensors found!

Here is what happens when I manually type the commands sensor-detect
suggested except modprobe it87 ofcoarse.



[root@AMD64Home dump]# ./isadump 0x295 0x296
  WARNING! Running this program can cause system crashes, data loss and
worse!
  I will probe address register 0x0295 and data register 0x0296.
  You have five seconds to reconsider and press CTRL-C!
 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 13 10 00 00 37 ff 00 37 ff 07 1f 5b 5b 30 ff 3e
10: fe ff ff 71 87 fd 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f
20: 60 a3 ce 96 bf 8f 93 87 ff 19 28 2c 2c 2c 2c 2c
30: ff 00 ff 00 ff 00 ff 00 ff 00 ff 00 ff 00 ff 00
40: 7f 7f 3c 7f 7f 7f ff ff 2d ff ff ff ff ff ff ff
50: ff 1c 7f 7f 7f ff ff ff 90 8b fd 12 55 00 00 00
60: 00 00 28 32 3c 0c 14 1c 7f 7f 7f 7f 7f 00 00 00
70: 7f 7f 7f 7f 00 00 00 00 ff ff ff ff ff ff ff ff
80: 13 10 00 00 37 ff 00 37 ff 07 1f 5b 5b 30 ff 3e
90: fe ff ff 71 87 fd 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f
a0: 60 a3 ce 96 bf 8f 93 87 ff 19 28 2c 2c 2c 2c 2c
b0: ff 00 ff 00 ff 00 ff 00 ff 00 ff 00 ff 00 ff 00
c0: 7f 7f 3c 7f 7f 7f ff ff 2d ff ff ff ff ff ff ff
d0: ff 1c 7f 7f 7f ff ff ff 90 8b fd 12 55 00 00 00
e0: 00 00 28 32 3c 0c 14 1c 7f 7f 7f 7f 7f 00 00 00
f0: 7f 7f 7f 7f 00 00 00 00 ff ff ff ff ff ff ff ff
[root@AMD64Home dump]#


If you need any other info please just ask. 

Thanks Again,

John



On Tue, 2004-03-02 at 12:04, Jean Delvare wrote:
> > My system is an AMD64 with Nforce3 and ite8712f-A chips.
> > 
> > I was hoping to get partial info from the ite chip.
> > 
> > after placing the following in the /etc/modules.conf
> > 
> > > alias eth1 tulip
> > > alias char-major-195 nvidia
> > > # I2C module options
> > > alias char-major-89 i2c-dev
> > > options it87 ignore=-1,0x290
> > > # I2C adapter drivers
> > > #modprobe i2c-isa
> > > # I2C chip drivers
> > > #modprobe it87
> > > # sleep 2 # optional
> > > #/usr/local/bin/sensors -s # recommended
> > 
> > when modprobe it87 activates it shuts down all my internal fans.
> 
> Bad. Which kernel? Which version of lm_sensors?
> 
> > Also when I rebooted the first time there were massive failures from 
> > other devices such as mouse iptables ect...
> 
> I don't much see how this would be related. But if you can reproduce
> that and can provide some more details proving that lm_sensors is
> somehow responsible for it, we'll investigate.
