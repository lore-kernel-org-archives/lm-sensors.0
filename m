From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: [Fwd: sensor issues]
Message-Id: <40C6098A.8020101@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



-------- Original Message --------
From: 	- Tue Jun 8 11:46:05 2004
X-UIDL: 	a14f2574076f64db
X-Mozilla-Status: 	0001
X-Mozilla-Status2: 	00000000
Return-Path: 	<carl@personnelware.com>
Received: 	from rwcrmhc11.comcast.net (rwcrmhc11.comcast.net 
[204.127.198.35]) by Ren.netroedge.com (8.12.10/8.12.10) with ESMTP id 
i58IQOhl003490 for <phil@netroedge.com>; Tue, 8 Jun 2004 11:26:24 -0700
Received: 	from cnt496 (c-24-13-54-45.client.comcast.net[24.13.54.45]) 
by comcast.net (rwcrmhc11) with SMTP id <2004060818285101300cv60te>; 
Tue, 8 Jun 2004 18:28:51 +0000
Message-ID: 	<04bf01c44d87$20068b40$1e01a8c0@cnt496>
From: 	Carl Karsten <carl@personnelware.com>
To: 	<phil@netroedge.com>
Subject: 	sensor issues
Date: 	Tue, 8 Jun 2004 13:33:42 -0500
MIME-Version: 	1.0
Content-Type: 	text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 	7bit
X-Priority: 	3
X-MSMail-Priority: 	Normal
X-Mailer: 	Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: 	Produced By Microsoft MimeOLE V6.00.2800.1409
X-Quarentine-Loop: 	Processed
X-Spambayes-Classification: 	ham; 0.00



Philip,

Not sure who to tell, and you were the first addr on
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/lm_sensors-FAQ.html#Top
so you win.

The min/max on most of these are reversed.  /etc/sensors.conf seemed to have
them right, but the display has them flipped.

Let me know if you want me to send /etc/sensors.conf

LinuxBook1 root # sensors
it87-isa-0290
Adapter: ISA adapter
VCore 1:   +1.47 V  (min =  +2.68 V, max =  +1.40 V)   ALARM
VCore 2:   +1.56 V  (min =  +0.12 V, max =  +3.77 V)
+3.3V:     +3.28 V  (min =  +1.02 V, max =  +1.02 V)   ALARM
+5V:       +4.37 V  (min =  +5.38 V, max =  +3.68 V)   ALARM
+12V:     +11.96 V  (min =  +0.48 V, max =  +4.08 V)   ALARM
-12V:      -9.26 V  (min =  -3.74 V, max = -11.71 V)   ALARM
-5V:       -4.72 V  (min =  -3.42 V, max =  -8.05 V)   ALARM
Stdby:     +2.47 V  (min =  +0.10 V, max =  +1.93 V)   ALARM
VBat:      +3.08 V
fan1:        0 RPM  (min =    0 RPM, div = 8)
fan2:        0 RPM  (min =    0 RPM, div = 8)
fan3:        0 RPM  (min =    0 RPM, div = 2)
M/B Temp:    +45 C  (low  =    +2 C, high =   -96 C)   sensor = thermistor
CPU Temp:    +46 C  (low  =   +64 C, high =   -36 C)   sensor = thermistor
ALARM
Temp3:       +50 C  (low  =   -64 C, high =   -64 C)   sensor = thermistor



Carl K
http://www.personnelware.com/carl/resume.html

