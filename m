From: apel@human-solutions.com (Martin Apel)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: Sensor module hangs in 2.8.1, works fine with 2.6.1
Message-Id: <Pine.LNX.4.58.0311171503100.32590@tuxracer.humanmodeling.tecmath.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I have a problem with the w83781d module. It used to work just fine in version
2.6.1 on a 2.4.18 kernel, but just hangs the complete system with sensors 2.8.1
with a 2.4.21 kernel.

Details:
1. Mainboard is a ASUS CUR-DLS Dual Pentium III with Serverworks Serverset III LE
2. Sensor chip is a as99127f
3. Combination used to work under 2.6.1 under kernel 2.4.18 using the following setup:
   modprobe i2c-piix4
   modprobe w83781d force_as99127f=0,0x2d
4. When using the same commands under 2.8.1 on a 2.4.21 kernel, the system hangs
   Adding 'init=0' to the second command line doesn't change anything.
   sensors-detect hangs when probing piix4 devices.
5. Doing a 'modprobe i2c-piix4' generates the following kernel log messages:
   i2c-core.o: i2c core module version 2.8.1 (20031005)
   i2c-piix4.o version 2.8.1 (20031005)
   Found ServerWorks OSB4 South Bridge device
   dmi_scan.o version 2.8.1 (20031005)
   dmi_scan.o: SM BIOS found
   Worked around buggy BIOS (I2C)
6. Doing the same with 2.6.1 on the 2.4.18 kernel generates:
   i2c-core.o: i2c core module
   i2c-piix4.o version 2.6.1 (20010830)
   i2c-core.o: adapter SMBus OSB4/CSB5 adapter at e800 registered as adapter 0.
   i2c-piix4.o: PIIX4 bus detected and initialized
   modprobe w83781d generates:
   w83781d.o version 2.6.1 (20010830)
   i2c-core.o: driver W83781D sensor driver registered.
   i2c-core.o: client [AS99127F chip] registered to adapter [SMBus OSB4/CSB5 adapter at e800](pos. 0).
   i2c-core.o: client [AS99127F subclient] registered to adapter [SMBus OSB4/CSB5 adapter at e800](pos. 1).
   i2c-core.o: client [AS99127F subclient] registered to adapter [SMBus OSB4/CSB5 adapter at e800](pos. 2).

7. lspci -n generates:
   00:00.0 Class 0600: 1166:0009 (rev 06)
   00:00.1 Class 0600: 1166:0009 (rev 06)
   00:02.0 Class 0200: 8086:1229 (rev 08)
   00:07.0 Class 0300: 1002:4752 (rev 27)
   00:0f.0 Class 0601: 1166:0200 (rev 50)
   00:0f.1 Class 0101: 1166:0211
   01:02.0 Class 0100: 1119:016d
   01:05.0 Class 0100: 1000:0020 (rev 01)
   01:05.1 Class 0100: 1000:0020 (rev 01)

8. 'i2cdetect 0' generates (2.4.18 kernel with i2c-piix4 from 2.6.1
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: XX XX XX 03 XX XX XX XX XX XX XX XX 0c 0d 0e 0f
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX UU XX 2f
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX UU UU XX XX XX XX XX XX
50: XX XX XX XX 54 55 56 57 XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX

9. 'i2cdetect 0' hangs on 2.4.21 kernel with i2c-piix4 from 2.8.1

Any help for solving this problem would be very much appreciated.

Best Regards,

Martin
________________________________________________________________________
Martin Apel, Dipl.-Inform.                          Human Solutions GmbH
Group Manager Software Development
phone +49 (0)631 303-5600           Europaallee 10, 67657 Kaiserslautern
fax   +49 (0)631 303-5700                                        Germany
apel@human-solutions.com                  http://www.human-solutions.com
________________________________________________________________________
