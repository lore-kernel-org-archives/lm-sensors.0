From: hamletmun@fibertel.com.ar (Hamlet)
Date: Wed, 18 Oct 2006 18:55:10 +0000
Subject: [lm-sensors] ASUS P5B DELUXE WiFi with Winbond W83627DHG
Message-Id: <4536788E.8010504@fibertel.com.ar>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Winbond W83627DHG seems to be compatible with lm78

# sensors
lm78-isa-0290
Adapter: ISA adapter
VCore 1:   +2.43 V  (min =  +2.85 V, max =  +3.15 V)
VCore 2:   +3.66 V  (min =  +2.85 V, max =  +3.15 V)
+3.3V:     +3.31 V  (min =  +3.14 V, max =  +3.47 V)
+5V:       +5.56 V  (min =  +4.76 V, max =  +5.24 V)
+12V:     +12.77 V  (min = +11.37 V, max = +12.59 V)
-12V:     -11.24 V  (min = -12.63 V, max = -11.40 V)
-5V:       -4.98 V  (min =  -5.25 V, max =  -4.74 V)
fan1:        0 RPM  (min = 337500 RPM, div = 2)
fan2:     20149 RPM  (min = 10074 RPM, div = 1)
fan3:        0 RPM  (min = 112500 RPM, div = 2)
temp:      +41.0?C  (high =   +81?C, hyst =  -124?C

# isadump 0x295 0x296
WARNING! Running this program can cause system crashes, data loss and worse!
I will probe address register 0x295 and data register 0x296.
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 04 ff 04 4b 31 00 4c 10 01 4b 01 01 3c 3c 0a 05
10: 04 ff 50 00 00 01 01 3c 43 17 00 00 ff ff ff c7
20: 98 e5 cf cf d2 ca cf 29 ff 43 ff c5 b2 c5 b2 d9
30: c4 c3 b1 cf bb e3 cd da c5 51 84 02 86 06 85 ff
40: 03 00 00 de ff ff 00 15 2d 00 20 44 18 95 06 a3
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
60: 01 9b 31 56 9b 01 3c ff 12 ff 0a ff ff ff ff ff
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
80: 04 ff 04 4b 31 00 4c 10 01 4b 01 01 3c 3c 0a 05
90: 04 ff 50 00 00 01 01 3c 43 17 00 00 ff ff ff c7
a0: 98 e5 cf cf d2 ca cf 29 ff 43 ff c5 b2 c5 b2 d9
b0: c4 c3 b1 cf bb e3 cd da c5 51 84 02 86 06 85 ff
c0: 03 00 00 de ff ff 00 15 2d 00 20 44 18 95 06 a3
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: 01 9b 31 56 9b 01 3c ff 12 ff 0a ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

I will stay with lm78 because w83627ehf doesn't work, at least for now.

http://forums.gentoo.org//viewtopic-t-508476.html

