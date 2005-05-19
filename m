From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:24:29 +0000
Subject: [Fwd: Re: Ticket number 1467 - reply to comments by Khali]
Message-Id: <3FD77D42.2090908@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



-------- Original Message --------
From: 	- Wed Dec 10 12:04:10 2003
X-UIDL: 	6c2ac25ad1c644a2
X-Mozilla-Status: 	0011
X-Mozilla-Status2: 	00000000
Return-Path: 	<raj@ast.man.ac.uk>
Received: 	from Stimpy.netroedge.com (IDENT:root@Stimpy.netroedge.com 
[206.228.191.3]) by Ren.netroedge.com (8.12.10/8.12.10) with ESMTP id 
hBAJlIpT008330 for <phil@ren.netroedge.com>; Wed, 10 Dec 2003 11:47:18 
-0800
Received: 	from gannet.scg.man.ac.uk (gannet.scg.man.ac.uk 
[130.88.94.110]) by Stimpy.netroedge.com (8.12.10/8.12.10) with ESMTP id 
hBAK931s032375 for <nobody@stimpy.netroedge.com>; Wed, 10 Dec 2003 
12:09:04 -0800
Received: 	from axp0.ast.man.ac.uk ([130.88.9.45]) by 
gannet.scg.man.ac.uk with esmtp (Exim 4.20) id 1AUAX4-000IqK-BY for 
nobody@stimpy.netroedge.com; Wed, 10 Dec 2003 20:02:02 +0000
Received: 	from raj (helo=localhost) by axp0.ast.man.ac.uk with 
local-esmtp (Exim 2.12 #1) id 1AUAWx-00021y-00 for 
nobody@Stimpy.netroedge.com; Wed, 10 Dec 2003 20:01:55 +0000
Date: 	Wed, 10 Dec 2003 20:01:55 +0000 (GMT)
From: 	Richard James <raj@ast.man.ac.uk>
To: 	Nobody <nobody@stimpy.netroedge.com>
Subject: 	Re: Ticket number 1467 - reply to comments by Khali
In-Reply-To: 	<200312062207.hB6M7vD7002389@Stimpy.netroedge.com>
Message-ID: 	<Pine.OSF.4.53.0312102000150.4026@axp0.ast.man.ac.uk>
References: 	<200312062207.hB6M7vD7002389@Stimpy.netroedge.com>
MIME-Version: 	1.0
Content-Type: 	TEXT/PLAIN; charset=ISO-8859-1
X-Scanner: 	exiscan for exim4 (http://duncanthrax.net/exiscan/) 
*1AUAX4-000IqK-BY*72dnd958xvk*
Content-Transfer-Encoding: 	8bit
X-MIME-Autoconverted: 	from QUOTED-PRINTABLE to 8bit by 
Ren.netroedge.com id hBAJlIpT008330
X-Quarentine-Loop: 	Processed
X-Spambayes-Classification: 	ham; 0.02



1)      I run "sensors -s" during bootup so this is not the problem.

2)      As regards the version of sensors.conf, I have tried copying
lm_sensors-2.8.x/etc/sensors.conf.eg to sensors.conf for x = 0 and
1.  I have tried both versions of this file with both versions
(2.8.0 and 2.8.1) of the software.  The behaviour of each version is
independent of which sensors.conf file I use.  I also tried with the
old version of sensors.conf from 2.7.0 - this also made no
difference.

3)      My motherboard is a standard Asus p4b with monitor chip
as99127f.  I am using the chip driver w83781d working with i2c-proc,
i2c-dev, i2c-i801 and i2c-core.  As noted in ticket no 1466 the
module p4b_smbus is not required with the 2.4.23 kernel - this is a
new feature in the series of kernels.  I have tried installing
modules from versions 2.8.0 or 2.8.1, taking care to use matching
versions of i2c and lm_sensors.  Version 2.8.0 works fine but
version 2.8.1 does not.  I append the output from sensors for the
two cases:

Version 2.8.0:

w83782d-i2c-0-2d
Adapter: SMBus I801 adapter at e800
Algorithm: Non-I2C SMBus adapter
VCore 1:   +1.74 V  (min =  +1.74 V, max =  +1.93 V)       ALARM  (beep)
VCore 2:   +1.82 V  (min =  +1.74 V, max =  +1.93 V)              (beep)
+3.3V:     +3.28 V  (min =  +3.13 V, max =  +3.45 V)              (beep)
+5V:       +5.12 V  (min =  +4.72 V, max =  +5.24 V)              (beep)
+12V:     +11.97 V  (min = +10.79 V, max = +13.19 V)
-12V:     -12.13 V  (min = -13.21 V, max = -10.90 V)
-5V:       -5.10 V  (min =  -5.26 V, max =  -4.76 V)
V5SB:      +0.13 V  (min =  +0.13 V, max =  +0.13 V)
VBat:      +0.08 V  (min =  +0.08 V, max =  +0.08 V)
fan1:     6683 RPM  (min = 3000 RPM, div = 2)                     (beep)
fan2:      231 RPM  (min =  187 RPM, div = 32)                     (beep)
fan3:        0 RPM  (min = 3000 RPM, div = 2)
temp1:       +31?C  (limit =  +60?C)                       sensor = thermistor           (beep)
temp2:     +30.0?C  (limit =  +60?C, hysteresis =  +50?C) sensor = thermistor           (beep)
temp3:    +255.5?C  (limit =  +60?C, hysteresis =  +50?C) sensor = 3904 transistor
vid:      +1.850 V
alarms:
beep_enable:
          Sound alarm disabled


Version 2.8.1:

as99127f-i2c-0-2d
Adapter: SMBus I801 adapter at e800
Algorithm: Non-I2C SMBus adapter
VCore 1:   +1.74 V  (min =  +1.74 V, max =  +1.94 V)       ALARM
VCore 2:   +1.82 V  (min =  +1.74 V, max =  +1.94 V)
+3.3V:     +3.28 V  (min =  +3.14 V, max =  +3.46 V)
+5V:       +5.11 V  (min =  +4.74 V, max =  +5.24 V)
+12V:     +11.93 V  (min = +10.83 V, max = +13.19 V)              (beep)
-12V:      -2.15 V  (min = -13.23 V, max = -10.73 V)              (beep)
-5V:       -1.25 V  (min =  -5.25 V, max =  -4.74 V)              (beep)
fan1:     6683 RPM  (min = 3000 RPM, div = 2)
fan2:     3668 RPM  (min = 3000 RPM, div = 2)
fan3:        0 RPM  (min = 3000 RPM, div = 2)                     (beep)
M/B Temp:    +32?C  (limit =  +60?C)
CPU Temp:  +30.0?C  (limit = +120?C, hysteresis = +100?C)
temp3:    +255.4?C  (limit = +120?C, hysteresis = +100?C)        (beep)
vid:      +1.850 V
alarms:
beep_enable:
          Sound alarm disabled

        I would also comment that version 2.8.1 works perfectly on a
Pentium Pro system with a VS440FX motherboard.  Please let me know if
there is any more information I can supply.

                Yours sincerely,

                                Richard James.



