From: geoff.leach@bigpond.com (Geoff Leach)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: W83627THF and fan speed
Message-Id: <40721FE7.40504@bigpond.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I've just upgraded to 2.6.5 and saw that it has a driver for the Winbond 
W83627THF. Now I get some sensor values. Thanks.

My temperature and voltage readings look ok, and are a good match for 
the values reported by the BIOS. However, my fan values are all 0 
whereas the BIOS reports them generally in the range 1000-2500 rpm.

My motherboard is an MSI 865PE Neo2-P. My CPU fan is an Artic Cooling 
Super Silent 4 Pro TC. I've attached an Artic Cooling Artic Fan Pro TC 
to the NBFAN1 3 pin connector on the motherboard. Both fans are 3 wire.

sensors-detect finds the W83627THF and I've loaded the modules.

I'm not too sure about the next phase of trying to find what is wrong 
with my fans, but it looks like isadump may be needed.

gl@gl ~ % sudo /usr/local/sbin/isadump 0x295 0x296
   WARNING! Running this program can cause system crashes, data loss and 
worse!
   I will probe address register 0x0295 and data register 0x0296.
   You have five seconds to reconsider and press CTRL-C!
 

      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 01 1f 01 ff 00 00 00 00 01 01 01 01 3c 3c 0a 0a
10: 01 ff 00 00 00 01 01 3c 43 00 ff ff 24 32 00 de
20: 8a cc c2 b8 24 09 00 07 ff ff ff 00 00 d9 b2 d9
30: c4 c5 b2 15 32 61 10 02 46 08 18 00 00 10 00 00
40: 03 04 10 fe ff 00 00 48 1f 03 89 c4 50 95 00 a3
50: ff ff 00 ff ff ff 00 00 90 70 ff ff 11 01 ff 05
60: 8a cc c2 b8 24 09 00 07 ff ff ff 00 00 d9 b2 d9
70: c4 c5 b2 15 32 61 10 02 46 08 18 00 00 10 00 00
80: 01 1f 01 ff 00 00 00 00 01 01 01 01 3c 3c 0a 0a
90: 01 ff 00 00 00 01 01 3c 43 00 ff ff 24 32 00 de
a0: 8a cc c2 b8 24 09 00 07 ff ff ff 00 00 d9 b2 d9
b0: c4 c5 b2 15 32 61 10 02 46 08 18 00 00 10 00 00
c0: 03 00 00 fe ff 00 00 48 1f 03 89 c4 50 95 00 a3
d0: ff ff 00 ff ff ff 00 00 90 70 ff ff 11 01 ff 05
e0: 8a cc c2 b8 24 09 00 07 ff ff ff 00 00 d9 b2 d9
f0: c4 c5 b2 15 32 61 10 02 46 08 18 00 00 10 00 00

 From the little I understand of the W83627THF manual (and this stuff 
generally) it is values 28h, 29h and 2Ah which are the fan rotation 
counts, and they are stuck at Oxff.
