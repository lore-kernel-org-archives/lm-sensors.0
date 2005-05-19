From: mgiammarco@libero.it (Mario Giammarco)
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: ticket 863
Message-Id: <1018180116.1937.6.camel@cala>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thank you for so nice and fast support!

I am so sorry but there was an old sensors-detect floating around  in
the path.

Any way now I have again wrong values.

I send you output of sensors:

it87-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore 1:   +1.69 V  (min =  +1.53 V, max =  +1.87 V)   
VCore 2:   +2.62 V  (min =  +2.25 V, max =  +2.75 V)   
+3.3V:     +6.62 V  (min =  +2.96 V, max =  +3.60 V)   ALARM
+5V:       +4.97 V  (min =  +4.50 V, max =  +5.48 V)   
+12V:     +12.16 V  (min = +11.36 V, max = +13.80 V)   
-12V:      -1.51 V  (min = -15.86 V, max = -13.40 V)   ALARM
-5V:       -8.88 V  (min = -10.13 V, max =  -9.44 V)   ALARM
Stdby:     +4.80 V  (min =  +4.50 V, max =  +5.48 V)   
VBat:      +0.00 V
fan1:     4041 RPM  (min = 3000 RPM, div = 2)          
fan2:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
fan3:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
Temp1/MB:    +30?C  (min =  +20?C, max =  +60?C) 
Temp2/CPU:   -61?C  (min =  +20?C, max =  +60?C) 
Temp3:       -55?C  (min =  +20?C, max =  +60?C) 

I have only fan1 and temp1/2


and dump of 0x295 0x296:


     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 11 06 64 00 00 00 00 00 00 00 00 09 00 a7 ff ff 
10: e1 e1 e1 70 00 00 00 00 00 00 00 00 00 00 00 00 
20: 6a a4 cf b9 bd d3 45 b3 00 1e c3 c9 00 00 00 00 
30: 75 60 ac 8d 71 5d cc a8 d8 b2 72 5e 3d 33 cc a8 
40: 3c 14 3c 14 3c 14 00 00 2d 00 00 00 00 00 00 00 
50: ff 2a 7f 7f 7f 00 00 00 90 56 06 00 00 00 00 00 
60: 7f 7f 7f 7f 7f 00 00 00 7f 7f 7f 7f 7f 00 00 00 
70: 7f 7f 7f 7f 7f 00 00 00 00 00 00 00 00 00 00 00 
80: 11 06 00 00 00 00 00 00 00 00 00 09 00 a7 ff ff 
90: e1 e1 e1 70 00 00 00 00 00 00 00 00 00 00 00 00 
a0: 6a a4 cf b9 bd d3 45 b3 00 1e c3 c9 00 00 00 00 
b0: 75 60 ac 8d 71 5d cc a8 d8 b2 72 5e 3d 33 cc a8 
c0: 3c 14 3c 14 3c 14 00 00 2d 00 00 00 00 00 00 00 
d0: ff 2a 7f 7f 7f 00 00 00 90 56 06 00 00 00 00 00 
e0: 7f 7f 7f 7f 7f 00 00 00 7f 7f 7f 7f 7f 00 00 00 
f0: 7f 7f 7f 7f 7f 00 00 00 00 00 00 00 00 00 00 00 


Thank you again!
-- 
Mario Giammarco
Via Calamandrei,5-48022 Lugo (RA) ITALY
tel: +39054522965 cell: +39(0)3284146845
mgiammarco@galactica.it
mgiammarco@libero.it
giammarc@cs.unibo.it
