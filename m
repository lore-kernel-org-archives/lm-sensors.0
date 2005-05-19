From: Bram_Havers@nl.ibm.com (Bram Havers)
Date: Thu, 19 May 2005 06:24:13 +0000
Subject: sensors-detect segmentation fault.
Message-Id: <OFFE2F721F.216A742B-ONC1256D89.00360B8D-C1256D89.0039140A@nl.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <OF2A643F2F.52CE6915-ONC1256D86.0058E32A-C1256D86.005966AD@nl.ibm.com>
In-Reply-To: <OF2A643F2F.52CE6915-ONC1256D86.0058E32A-C1256D86.005966AD@nl.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark.

I checked and the i2c-viapro.o file is standard delivered with my current 
kernel: 2.4.20-19.9
In the i2c-2.8.0.tar file i couldn't find an update to it. The 
i2c-philips-par.c is in that file and when i run sensors-detect i see that 
it gets loaded (no clue why).
Is there an update for i2c-viapro ? I will add some listings at the end.
I also removed and reinstalled lm_sensors-2.8.0-1_15.rh9.at.i386.rpm but 
no difference.
One other thing, when i run sensors-detect it will normally also loads the 
i2c-philips-par module. When i don't load it it hangs after i2c-dev. Do i 
need to load i2c-philips-par and i2c-dev ?

.................
 We will now try to load each adapter module in turn.
Module `i2c-viapro' already loaded.
 Do you now want to be prompted for non-detectable adapters? (yes/NO): yes
Load `i2c-elektor' (say NO if built into your kernel)? (YES/no): no
Load `i2c-elv' (say NO if built into your kernel)? (YES/no): no
Load `i2c-philips-par' (say NO if built into your kernel)? (YES/no): no
Load `i2c-velleman' (say NO if built into your kernel)? (YES/no): no
 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no):
<now it hangs>
..............


OT: I just got this board three weeks ago and haven't had the time to do a 
lot with it. So far i only installed RH9, lm_sensors and configured samba.
As far as i can see now the support is not great but it could also be much 
worse (it ran out of the box without problems). For instance the hardware 
MPEG decoder is only supported on main distributions, when you compile a 
new kernel the hardware decoder isn't supported any more (caused by legal 
issues with MPEG2 patents).
Fortunately for my use i don't need these features (i only has to be a 
fileserver, play MP3s and run tomcat). The main thing for my interest is 
getting the system to sleep as much as possible as it will not be used 
most of its time.

Thanks for your help so far, and if you'd like to take a look at the 
system to check upon the problem i can create an account for you.

[root@bramhome root]# lspci
00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 3123
00:01.0 PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266 AGP]
00:0d.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host 
Controller (rev 80)
00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus 
Master IDE (rev 06)
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 
Audio Controller (rev 50)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 
74)
01:00.0 VGA compatible controller: VIA Technologies, Inc.: Unknown device 
3122 (rev 03)

[root@bramhome root]# lspci -n
00:00.0 Class 0600: 1106:3123
00:01.0 Class 0604: 1106:b091
00:0d.0 Class 0c00: 1106:3044 (rev 80)
00:10.0 Class 0c03: 1106:3038 (rev 80)
00:10.1 Class 0c03: 1106:3038 (rev 80)
00:10.2 Class 0c03: 1106:3038 (rev 80)
00:10.3 Class 0c03: 1106:3104 (rev 82)
00:11.0 Class 0601: 1106:3177
00:11.1 Class 0101: 1106:0571 (rev 06)
00:11.5 Class 0401: 1106:3059 (rev 50)
00:12.0 Class 0200: 1106:3065 (rev 74)
01:00.0 Class 0300: 1106:3122 (rev 03)

cat /proc/pci  (a part of it)
  Bus  0, device   0, function  0:
    Host bridge: PCI device 1106:3123 (VIA Technologies, Inc.) (rev 0).
      Master Capable.  Latency=8.
      Prefetchable 32 bit memory at 0xd0000000 [0xd7ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266 AGP] (rev 0).
      Master Capable.  No bursts.  Min Gnt.


Groeten, kind regards,
Bram Havers

IBM Global Services
Mobile E-business
Tel: +31 (0)6 - 531 77 950




"Mark M. Hoffman" <mhoffman@lightlink.com>
20-08-03 23:43
Please respond to Sensors

 
        To:     Bram Havers/Netherlands/IBM@IBMNL
        cc:     Sensors <sensors@stimpy.netroedge.com>
        Subject:        Re: sensors-detect segmentation fault.



* Bram Havers <Bram_Havers@nl.ibm.com> [2003-08-18 18:14:14 +0200]:
> Hi,
> I've installed lm_sensors and i2c on my Via Epia ME6000 with Red Hat 9.
> When i run sensors-detect it ends with a segmentation fault after which 
> only a reboot helps to kill the processes
> Below i've posted what appears on the console, dmseg and lsmod.
> Hope you can help. Thanks.

<snip>

> ----------dmesg ----
> via82cxxx: board #1 at 0xE400, IRQ 10
> i2c-core.o: i2c core module version 2.8.0 (20030714)
> i2c-viapro.o version 2.6.5 (20020915)
> i2c-viapro.o: Found Via VT8233A/8235 device
> i2c-viapro.o: Via Pro SMBus detected and initialized
> i2c-dev.o: i2c /dev entries driver module version 2.8.0 (20030714)
> i2c-dev.o: Registered 's Via Pro adapter at 0500' as minor 0

<snip>

You have version 2.8.0 of I2C but only 2.6.5 of sensors, not sure how.
Make sure to remove the sensors RH package, then rebuild and reinstall
from the 2.8.0 source - first i2c, then lm_sensors2.

OT: How is the Linux support for the rest of that board?

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com



-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030821/33992c8e/attachment.html
