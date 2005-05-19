From: beejay@gentoo.org (Benjamin Judas)
Date: Thu, 19 May 2005 06:25:21 +0000
Subject: Bug #1807: sensors with kernel 2.4, but not with kernel 2.6
Message-Id: <1099499003.11618.13.camel@antares.hausnetz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I was told to continue on this list, so...here's the additional info
requested:

> Second, you do not mention the version of lm_sensors you are using, 
> just like it doesn?t matter for a 2.6 kernel. It does. The lm_sensors
> package may not providekernel drivers for the 2.6 series, but it still
> provides the user-space library and tools. Since the 
> kernel-space/user-space interface changed several times between the 
> early 2.6 kernels, you should ensure that you use a recent version. 
> 2.8.6 or later is required for proper operations with a 2.6.8 kernel.
> Newer is even better.

I have lm-sensors-2.8.7 installed. (And before you ask, yes - I also
compiled it without any CFLAGS set to be sure ;) )



> You should take a look at the logs 
> (/var/log/syslog, /var/log/messages, dmesg) when you load the i2c 
> kernel modules. If anything goes wrong it
> should tell you. If you compiled your kernel with I2C debugging 
> enabled, you may also gather useful additional information.

Syslog doesn't show any error-messages when asb100.ko and i2c-viapro are
loaded. However when I enable really verbose logging, I get a bunch of
messages that look like this:

Oct 31 22:01:02 antares kernel: i2c_adapter i2c-0: master_xfer: with 1
msgs.
Oct 31 22:01:02 antares kernel: i2c_adapter i2c-0: i2c-0 ioctl, cmd:
0x703, arg: 4c.
Oct 31 22:01:03 antares kernel: i2c_adapter i2c-0: i2c-0 ioctl, cmd:
0x720, arg: 8377858.
Oct 31 22:01:03 antares kernel: i2c_adapter i2c-0: master_xfer: with 1
msgs.
Oct 31 22:01:03 antares kernel: i2c_adapter i2c-0: i2c-0 ioctl, cmd:
0x703, arg: 4d.
Oct 31 22:01:03 antares kernel: i2c_adapter i2c-0: i2c-0 ioctl, cmd:
0x720, arg: 8377858.
Oct 31 22:01:03 antares kernel: i2c_adapter i2c-0: master_xfer: with 1
msgs.
Oct 31 22:01:03 antares kernel: i2c_adapter i2c-0: i2c-0 ioctl, cmd:
0x703, arg: 4e.
Oct 31 22:01:03 antares kernel: i2c_adapter i2c-0: i2c-0 ioctl, cmd:
0x720, arg: 8377858.
Oct 31 22:01:03 antares kernel: i2c_adapter i2c-0: master_xfer: with 1
msgs.
Oct 31 22:01:03 antares kernel: i2c_adapter i2c-0: i2c-0 ioctl, cmd:
0x703, arg: 4f.
Oct 31 22:01:03 antares kernel: i2c_adapter i2c-0: i2c-0 ioctl, cmd:
0x720, arg: 8377858.
Oct 31 22:01:03 antares kernel: i2c_adapter i2c-0: master_xfer: with 1
msgs.
Oct 31 22:01:03 antares kernel: i2c_adapter i2c-0: i2c-0 ioctl, cmd:
0x703, arg: 50.
Oct 31 22:01:03 antares kernel: i2c_adapter i2c-0: i2c-0 ioctl, cmd:
0x720, arg: 8377858.



> If both drivers load properly, you should take a look 
> at /sys/bus/i2c/devices/.
> In this directory, you should find a subdirectory for the asb100. If you don?t,
> then either kernel driver is faulty. If you do, then the kernel is fine and the
> user-space if faulty.

The modules themselves load properly, the directory in /sys/bus/i2c/drivers gets created:

antares /home/benni # cd /sys/bus/i2c/drivers/
antares /sys/bus/i2c/drivers # ls -al
insgesamt 0
drwxr-xr-x  11 root root 0  3. Nov 16:54 .
drwxr-xr-x   4 root root 0  3. Nov 2004  ..
drwxr-xr-x   2 root root 0  3. Nov 16:54 asb100
drwxr-xr-x   2 root root 0  3. Nov 2004  generic i2c audio driver
drwxr-xr-x   2 root root 0  3. Nov 2004  i2c_adapter
drwxr-xr-x   2 root root 0  3. Nov 2004  i2c msp3400 driver
drwxr-xr-x   2 root root 0  3. Nov 2004  i2c tda7432 driver
drwxr-xr-x   2 root root 0  3. Nov 2004  i2c tda9875 driver
drwxr-xr-x   2 root root 0  3. Nov 2004  i2c tda9887 driver
drwxr-xr-x   2 root root 0  3. Nov 2004  i2c TV tuner driver
drwxr-xr-x   2 root root 0  3. Nov 2004  ir remote kbd driver


Thanks

Regards,
  Benjamin
-- 

Benjamin Judas

---------------------------------------------------------------------                                  
Gentoo-developer                        http://dev.gentoo.org/~beejay
Giessen, Germany                                http://www.gentoo.org

GPG-Key         : 0xC31DEDD8
Key-Fingerprint : 4E65 AAFE 785B 61D8 E4D9  1671 E017 87B7 C31D EDD8
Jabber          : beejay@im.gentoo.org


-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: Dies ist ein digital signierter Nachrichtenteil
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20041103/00bcdb5d/attachment.bin
