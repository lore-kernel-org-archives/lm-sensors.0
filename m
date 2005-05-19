From: mgc8@totalnet.ro (Mihnea-Costin Grigore)
Date: Thu, 19 May 2005 06:23:37 +0000
Subject: all ok except for a few mis-readings on a it87 chip
Message-Id: <Pine.LNX.4.31.0208160144340.8118-100000@tenebus.tenebus.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


     Hi there!

     I've been using lm_sensors for some time on my older computer, but
now I got a new motherboard and a few things changed.
     It is a Gigabyte 7vtxh+ with a VIA 8233A SouthBridge, and
sensors-detect found an it87-isa chip to go with that. Everything seems
fine, but the reading from -12V and -5V are all wrong. Here's a sample:

===[cut here]==it87-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore:     +1.74 V  (min =  +1.69 V, max =  +1.80 V)
+3.3V:     +3.20 V  (min =  +3.13 V, max =  +3.45 V)
+5V:       +4.84 V  (min =  +4.72 V, max =  +5.24 V)
+12V:     +12.16 V  (min = +11.36 V, max = +12.60 V)
-12V:      -7.42 V  (min = -12.63 V, max = -11.41 V)   ALARM
-5V:       -5.89 V  (min =  -5.28 V, max =  -4.81 V)   ALARM
Stdby:     +4.91 V  (min =  +4.72 V, max =  +5.24 V)
CPU Fan:  3292 RPM  (min = 3000 RPM, div = 2)
MB Temp:     +41C  (min =  +20C, max =  +45C)
CPU Temp:    +66C  (min =  +30C, max =  +75C)
===[and here]==
     I used the default compute lines for this chip from sensors.conf...
Also, if I comment out the in5/in6 compute lines, this is the output:

===[cut here]==-12V:      +2.56 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
-5V:       +1.34 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
===[and here]==
     One thing to note is that the values for these two inputs keep
changing more often than the others, so I guess there must be something
wrong with the formula...

     I was hoping you could give me some hints as to how I might fix this,
if possible... other than this, everything's fine, thanks for the great
package and keep up the good work!

Regards,

--
Mihnea-Costin Grigore          [ "Tenebus Ipsilo Ibinem Catehens" ]
E-mail: mgc8@totalnet.ro       Home Page: http://mgc8.virtualave.net
