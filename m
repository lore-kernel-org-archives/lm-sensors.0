From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:23:58 +0000
Subject: [Fwd: DPMS problem with lm_sensors 2.7.0]
Message-Id: <3EDE486F.9010505@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This got tagged as spam.

-------- Original Message --------
From: 	- Wed Jun 4 12:21:08 2003
X-UIDL: 	50e9c174766b9cb2
X-Mozilla-Status: 	0001
X-Mozilla-Status2: 	10000000
Return-Path: 	<lm78@Stimpy.netroedge.com>
Received: 	from Stimpy.netroedge.com (IDENT:root@Stimpy.netroedge.com 
[206.228.191.3]) by Ren.netroedge.com (8.12.8p1/8.9.1) with ESMTP id 
h54HY7vL031893 for <phil@ren.netroedge.com>; Wed, 4 Jun 2003 10:34:07 -0700
Received: 	from Stimpy.netroedge.com (IDENT:lm78@localhost [127.0.0.1]) 
h54HfDBI028847; Wed, 4 Jun 2003 10:41:13 -0700
Received: 	(from lm78@localhost) by Stimpy.netroedge.com 
(8.12.8p1/8.12.8/Submit) id h54HfB9c028846; Wed, 4 Jun 2003 10:41:11 -0700
Received: 	from mion.elka.pw.edu.pl (root@mion.elka.pw.edu.pl 
[194.29.160.35]) by Stimpy.netroedge.com (8.12.8p1/8.11.1) with ESMTP id 
h54Hf6BI028820 for <sensors@stimpy.netroedge.com>; Wed, 4 Jun 2003 
10:41:09 -0700
Received: 	from waw03213071.visp.energis.pl ([62.29.213.71]:32773 "EHLO 
w.pl") by mion.elka.pw.edu.pl with ESMTP id <S313832AbTFDRbl>; Wed, 4 
Jun 2003 19:31:41 +0200
Message-ID: 	<3EC89E5D.2090208@w.pl>
Date: 	Mon, 19 May 2003 11:05:33 +0200
From: 	Pawe? Tobi? <pawel@w.pl>
User-Agent: 	Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.0.2) 
Gecko/20030208 Netscape/7.02
X-Accept-Language: 	pl, en
MIME-Version: 	1.0
To: 	sensors@Stimpy.netroedge.com
Subject: 	DPMS problem with lm_sensors 2.7.0
X-Security: 	MIME headers sanitized on Stimpy.netroedge.com See 
http://www.impsec.org/email-tools/procmail-security.html for details. 
$Revision: 1.129 $Date: 2001-04-14 20:20:43-07
Content-Type: 	multipart/mixed; 
boundary="------------030502090505060102000605"
X-Virus-Scanned: 	by AMaViS perl-11 mion
X-SpamBouncer: 	1.5 (8/16/02)
X-SBClass: 	OK
X-Spambayes-Classification: 	spam; 1.00



Hi,

Your package is extremely helpful in monitoring the system health status.
However, the last version of lm_sensors (and/or i2c) perhaps needs some fixing to
provide a stability for monitored system.
Please help me to solve a problem described below.

with best regards
Pawel Tobis

Description of problem:
I found a problem using lm_sensors and DPMS power saving. Reading sensor chip
measures from /proc/sys/dev/sensors/*/* (by a daemon for example) causes the screen
to wake up from a DPMS-powerdown state. It's a problem when I'm using any of these
gui-monitors under X, because DPMS screen powersaving simply doesn't want to work.
The problem also exists with any of mrtg-kind sensor monitors.

Another issue connected with double registering i2c-dev and i2c-proc (if compiled
into kernel) may be solved by patching files i2c-dev.c and i2c-proc.c in the kernel
tree in the same way as it was done with i2c-core.c, I mean adding #ifdef MODULE and 
#endif MODULE into the ending module-registration section. I've attached these patches
just in case...

Below comes necessary information about my machine and Linux system:

Software spec:
lm_sensors:	2.7.0
i2c:		2.7.0 patched against double "/proc/bus/i2c" entry
linux:		2.4.20 (kernel patched with i2c & lm_sensors)
drivers:	i2c-core i2c-algo-bit i2c-dev i2c-proc i2c-via lm75
			(all statically compiled into kernel)
compiler:	gcc version 2.95.3 20010315 (release)

Hardware spec:
mb chipset:	VIA Apollo VP3 (year 1998)
sensor chipset:	NS LM75
cpu:		AMD K6-2 (CTX)
gpu:		ATI Rage Fury OR nVidia Riva TNT2 M64 (problem seen on both)

Contents of specific files and command outputs:
/proc/bus/i2c :
i2c-0   i2c             VIA i2c                                 Bit-shift algorithm

/proc/bus/i2c-0 :
4c      LM75 chip                               LM75 sensor chip driver

/proc/sys/dev/sensors/chips :
256     lm75-i2c-0-4c

/proc/sys/dev/sensors/lm75-i2c-0-4c/temp :
60.0 50.0 39.0

lspci -n :
00:00.0 Class 0600: 1106:0597 (rev 01)
00:01.0 Class 0604: 1106:8597
00:07.0 Class 0601: 1106:0586 (rev 41)
00:07.1 Class 0101: 1106:0571 (rev 06)
00:07.2 Class 0c03: 1106:3038 (rev 02)
00:07.3 Class 0680: 1106:3040 (rev 10)
00:0b.0 Class 0200: 8086:1030 (rev 08)
01:05.0 Class 0300: 1002:5246

i2cdetect 0:
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
40: XX XX XX XX XX XX XX XX XX XX XX XX UU XX XX XX 
50: 50 51 XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX 
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 

i2cdump 0 0x4c :
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x4c, mode byte
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 24 00 32 3c 3c 3c 3c 3c 24 00 32 3c 3c 3c 3c 3c    $.2<<<<<$.2<<<<<
10: 24 00 32 3c 3c 3c 3c 3c 24 00 32 3c 3c 3c 3c 3c    $.2<<<<<$.2<<<<<
20: 24 00 32 3c 3c 3c 3c 3c 24 00 32 3c 3c 3c 3c 3c    $.2<<<<<$.2<<<<<
30: 24 00 32 3c 3c 3c 3c 3c 24 00 32 3c 3c 3c 3c 3c    $.2<<<<<$.2<<<<<
40: 24 00 32 3c 3c 3c 3c 3c 24 00 32 3c 3c 3c 3c 3c    $.2<<<<<$.2<<<<<
50: 24 00 32 3c 3c 3c 3c 3c 24 00 32 3c 3c 3c 3c 3c    $.2<<<<<$.2<<<<<
60: 24 00 32 3c 3c 3c 3c 3c 24 00 32 3c 3c 3c 3c 3c    $.2<<<<<$.2<<<<<
70: 24 00 32 3c 3c 3c 3c 3c 24 00 32 3c 3c 3c 3c 3c    $.2<<<<<$.2<<<<<
80: 24 00 32 3c 3c 3c 3c 3c 24 00 32 3c 3c 3c 3c 3c    $.2<<<<<$.2<<<<<
90: 24 00 32 3c 3c 3c 3c 3c 24 00 32 3c 3c 3c 3c 3c    $.2<<<<<$.2<<<<<
a0: 24 00 32 3c 3c 3c 3c 3c 24 00 32 3c 3c 3c 3c 3c    $.2<<<<<$.2<<<<<
b0: 24 00 32 3c 3c 3c 3c 3c 24 00 32 3c 3c 3c 3c 3c    $.2<<<<<$.2<<<<<
c0: 24 00 32 3c 3c 3c 3c 3c 24 00 32 3c 3c 3c 3c 3c    $.2<<<<<$.2<<<<<
d0: 24 00 32 3c 3c 3c 3c 3c 24 00 32 3c 3c 3c 3c 3c    $.2<<<<<$.2<<<<<
e0: 24 00 32 3c 3c 3c 3c 3c 24 00 32 3c 3c 3c 3c 3c    $.2<<<<<$.2<<<<<
f0: 24 00 32 3c 3c 3c 3c 3c 24 00 32 3c 3c 3c 3c 3c    $.2<<<<<$.2<<<<<

dmesg (partially):
Linux version 2.4.20 (root@delta) (gcc version 2.95.3 20010315 (release)) #2 pon maj 5 02:22:21 CEST 2003

i2c-core.o: i2c core module version 2.7.0 (20021208)
i2c-dev.o: i2c /dev entries driver module version 2.7.0 (20021208)
i2c-algo-bit.o: i2c bit algorithm module version 2.7.0 (20021208)
i2c-proc.o version 2.7.0 (20021208)
i2c-via.o version 2.7.0 (20021208)
i2c-dev.o: Registered 'VIA i2c' as minor 0
i2c-via.o: Module succesfully loaded

lm75.o version 2.7.0 (20021208)






-------------- next part --------------
*** i2c-dev.c.orig	Wed Jan 22 01:24:53 2003
--- i2c-dev.c	Mon May 19 09:43:55 2003
***************
*** 535,540 ****
--- 535,541 ----
  
  EXPORT_NO_SYMBOLS;
  
+ #ifdef MODULE
  MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl> and Simon G. Vogl <simon@tk.uni-linz.ac.at>");
  MODULE_DESCRIPTION("I2C /dev entries driver");
  #ifdef MODULE_LICENSE
***************
*** 543,545 ****
--- 544,547 ----
  
  module_init(i2c_dev_init);
  module_exit(i2cdev_cleanup);
+ #endif


-------------- next part --------------
*** i2c-proc.c.orig	Wed Jan 22 01:24:53 2003
--- i2c-proc.c	Mon May 19 09:44:48 2003
***************
*** 920,925 ****
--- 920,926 ----
  EXPORT_SYMBOL(i2c_register_entry);
  EXPORT_SYMBOL(i2c_sysctl_real);
  
+ #ifdef MODULE
  MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>");
  MODULE_DESCRIPTION("i2c-proc driver");
  #ifdef MODULE_LICENSE
***************
*** 928,930 ****
--- 929,932 ----
  
  module_init(sensors_init);
  module_exit(i2c_cleanup);
+ #endif

