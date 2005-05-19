From: whitney@math.berkeley.edu (Wayne Whitney)
Date: Thu, 19 May 2005 06:23:27 +0000
Subject: Ticket # 765
Message-Id: <Pine.LNX.4.33.0112292058540.24047-100000@mf1.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

lm_sensors support worte:

> You?ve verified it?s a 627HF (by looking at the board) but the driver
> recognizes a 782d?

Sorry, I've not yet had a chance to check the motherboard, as I'm not
physically near it, but I'll have someone check as soon as I can and let
you know.  FWIW, the manual for the board (Tyan S2460) is somewhat
contradictory--on the motherboard block diagram it shows a 627HF but in
the hardware specifications it lists a 782D.

> Please send us the output of prog/dump/i2cdump 0 0x2d.

OK, I had been using lm_sensors 2.6.2 with kernel 2.4.16, i.e. i2c 2.6.1.  
So I thought I'd try i2c 2.6.2 to see if it made a difference, but no 
luck.  The following is with kernel 2.4.16, i2c 2.6.2, and lm_sensors 
2.6.2:

[root@redstart dump]# ./i2cdump 0 0x2d
Warning: no size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x2d, mode byte
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
20: 6d 86 60 b4 4d 9b cf 3c ff ff ff 79 6d 79 6d d8 
30: c4 c3 b0 d9 b2 15 31 31 3b 00 00 04 00 00 00 00 
40: 01 01 00 00 00 00 00 54 2d 02 01 44 01 15 00 a3 
50: ff ff 00 ff ff ff 00 80 30 00 ff ff 11 0e ff ff 
60: 6f 86 60 b4 4d 9b d0 3c ff ff ff 79 6d 79 6d d8 
70: c4 c3 b0 d9 b2 15 31 31 3b 00 00 04 00 00 00 00 
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
a0: 6d 86 60 b4 4d 9b d0 3c ff ff ff 79 6d 79 6d d8 
b0: c4 c3 b0 d9 b2 15 31 31 3b 00 00 04 00 00 00 00 
c0: 01 00 00 00 00 00 00 54 2d 02 01 44 01 15 00 a3 
d0: ff ff 80 ff ff ff 00 80 30 00 ff ff 11 0e ff ff 
e0: 6d 86 60 b4 4d 9b d0 3c ff ff ff 79 6d 79 6d d8 
f0: c4 c3 b0 d9 b2 15 31 31 3b 00 00 04 00 00 00 00 

> You do have two processors?

Yes, this is Tyan's second dual Athlon motherboard.

> Follow up by emailing sensors@stimpy.netroedge.com and reference your
> ticket #.
> 
> MDS 12/28/01

Let me know if there is anything else you'd like me to provide..

Thanks,
Wayne

