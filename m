From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: LM75 detection reworked
Message-Id: <20040708044334.GA2579@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040703105636.6ba726d6.khali@linux-fr.org>
In-Reply-To: <20040703105636.6ba726d6.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2004-07-03 10:56:36 +0200]:
> As a consequence of the discovery that the LM77 is not compatible with
> the LM75, I have been reworking the LM75 detection process in both
> sensors-detect (yesterday) and the lm75 driver (today). The main idea is
> to take benefits of the no register addresse which always return the
> last read value. Additionally, the driver now checks the unused bits (I
> was surprises that it wasn't done yet, since it's a common technique).
> Anyone with a good old LM75 chip, or supposedly compatible chip, or
> reputedly not compatible and possibly misdetected chip, is welcome to
> give it a try and report.
> 
> If it works OK, I'll send a similar change to Greg for 2.6.

Bad news: I up'd to 1.334 of sensors-detect and 1.48 of lm75.c... now
my two lm75s are not detected by the script nor by the driver.

Here's what I guess happened: earlier, when you asked me to test, I
unloaded all the i2c/sensors drivers, rebuilt and tested; you saw
the results.  Now when I tested again tonight, it's the first try
since a reboot.

Certainly, I can't believe that the changes between 1.332 and 1.334 of
sensors-detect should affect me w.r.t. the lm75s.

I apologize for the mixup; from now on I'll be sure to test following
a fresh reboot as well as re-inserting the modules.  Here are the dumps
immediately following a reboot for two lm75s.  Let me know if there's
anything else I can provide.

[root@earth root]# i2cdump 0 0x4c
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x4c, mode byte
  You have five seconds to reconsider and press CTRL-C!
                                                                                
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 1c 00 4b 50 50 50 50 50 1c 00 4b 50 50 50 50 50    ?.KPPPPP?.KPPPPP
10: 1c 00 4b 50 50 50 50 50 1c 00 4b 50 50 50 50 50    ?.KPPPPP?.KPPPPP
20: 1c 00 4b 50 50 50 50 50 1c 00 4b 50 50 50 50 50    ?.KPPPPP?.KPPPPP
30: 1c 00 4b 50 50 50 50 50 1c 00 4b 50 50 50 50 50    ?.KPPPPP?.KPPPPP
40: 1c 00 4b 50 50 50 50 50 1c 00 4b 50 50 50 50 50    ?.KPPPPP?.KPPPPP
50: 1c 00 4b 50 50 50 50 50 1c 00 4b 50 50 50 50 50    ?.KPPPPP?.KPPPPP
60: 1c 00 4b 50 50 50 50 50 1c 00 4b 50 50 50 50 50    ?.KPPPPP?.KPPPPP
70: 1c 00 4b 50 50 50 50 50 1c 00 4b 50 50 50 50 50    ?.KPPPPP?.KPPPPP
80: 1c 00 4b 50 50 50 50 50 1c 00 4b 50 50 50 50 50    ?.KPPPPP?.KPPPPP
90: 1c 00 4b 50 50 50 50 50 1c 00 4b 50 50 50 50 50    ?.KPPPPP?.KPPPPP
a0: 1c 00 4b 50 50 50 50 50 1c 00 4b 50 50 50 50 50    ?.KPPPPP?.KPPPPP
b0: 1c 00 4b 50 50 50 50 50 1c 00 4b 50 50 50 50 50    ?.KPPPPP?.KPPPPP
c0: 1c 00 4b 50 50 50 50 50 1c 00 4b 50 50 50 50 50    ?.KPPPPP?.KPPPPP
d0: 1c 00 4b 50 50 50 50 50 1c 00 4b 50 50 50 50 50    ?.KPPPPP?.KPPPPP
e0: 1c 00 4b 50 50 50 50 50 1c 00 4b 50 50 50 50 50    ?.KPPPPP?.KPPPPP
f0: 1c 00 4b 50 50 50 50 50 1c 00 4b 50 50 50 50 50    ?.KPPPPP?.KPPPPP

[root@earth root]# i2cdump 0 0x4c w
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x4c, mode word
  You have five seconds to reconsider and press CTRL-C!
                                                                                
     0,8  1,9  2,a  3,b  4,c  5,d  6,e  7,f
00: 7f1c ff00 7f4b 7f50 7f50 7f50 7f50 7f50
08: 7f1c ff00 7f4b 7f50 7f50 7f50 7f50 7f50
10: 7f1c ff00 7f4b 7f50 7f50 7f50 7f50 7f50
18: 7f1c ff00 7f4b 7f50 7f50 7f50 7f50 7f50
20: 7f1c ff00 7f4b 7f50 7f50 7f50 7f50 7f50
28: 7f1c ff00 7f4b 7f50 7f50 7f50 7f50 7f50
30: 7f1c ff00 7f4b 7f50 7f50 7f50 7f50 7f50
38: 7f1c ff00 7f4b 7f50 7f50 7f50 7f50 7f50
40: 7f1c ff00 7f4b 7f50 7f50 7f50 7f50 7f50
48: 7f1c ff00 7f4b 7f50 7f50 7f50 7f50 7f50
50: 7f1c ff00 7f4b 7f50 7f50 7f50 7f50 7f50
58: 7f1c ff00 7f4b 7f50 7f50 7f50 7f50 7f50
60: 7f1c ff00 7f4b 7f50 7f50 7f50 7f50 7f50
68: 7f1c ff00 7f4b 7f50 7f50 7f50 7f50 7f50
70: 7f1c ff00 7f4b 7f50 7f50 7f50 7f50 7f50
78: 7f1c ff00 7f4b 7f50 7f50 7f50 7f50 7f50
80: 7f1c ff00 7f4b 7f50 7f50 7f50 7f50 7f50
88: 7f1c ff00 7f4b 7f50 7f50 7f50 7f50 7f50
90: 7f1c ff00 7f4b 7f50 7f50 7f50 7f50 7f50
98: 7f1c ff00 7f4b 7f50 7f50 7f50 7f50 7f50
a0: 7f1c ff00 7f4b 7f50 7f50 7f50 7f50 7f50
a8: 7f1c ff00 7f4b 7f50 7f50 7f50 7f50 7f50
b0: 7f1c ff00 7f4b 7f50 7f50 7f50 7f50 7f50
b8: 7f1c ff00 7f4b 7f50 7f50 7f50 7f50 7f50
c0: 7f1c ff00 7f4b 7f50 7f50 7f50 7f50 7f50
c8: 7f1c ff00 7f4b 7f50 7f50 7f50 7f50 7f50
d0: 7f1c ff00 7f4b 7f50 7f50 7f50 7f50 7f50
d8: 7f1c ff00 7f4b 7f50 7f50 7f50 7f50 7f50
e0: 7f1c ff00 7f4b 7f50 7f50 7f50 7f50 7f50
e8: 7f1c ff00 7f4b 7f50 7f50 7f50 7f50 7f50
f0: 7f1c ff00 7f4b 7f50 7f50 7f50 7f50 7f50
f8: 7f1c ff00 7f4b 7f50 7f50 7f50 7f50 7f50

[root@earth root]# i2cdump 0 0x4d
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x4d, mode byte
  You have five seconds to reconsider and press CTRL-C!
                                                                                
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 1e 00 4b 50 50 50 50 50 1e 00 4b 50 50 50 50 50    ?.KPPPPP?.KPPPPP
10: 1e 00 4b 50 50 50 50 50 1e 00 4b 50 50 50 50 50    ?.KPPPPP?.KPPPPP
20: 1e 00 4b 50 50 50 50 50 1e 00 4b 50 50 50 50 50    ?.KPPPPP?.KPPPPP
30: 1e 00 4b 50 50 50 50 50 1e 00 4b 50 50 50 50 50    ?.KPPPPP?.KPPPPP
40: 1e 00 4b 50 50 50 50 50 1e 00 4b 50 50 50 50 50    ?.KPPPPP?.KPPPPP
50: 1e 00 4b 50 50 50 50 50 1e 00 4b 50 50 50 50 50    ?.KPPPPP?.KPPPPP
60: 1e 00 4b 50 50 50 50 50 1e 00 4b 50 50 50 50 50    ?.KPPPPP?.KPPPPP
70: 1e 00 4b 50 50 50 50 50 1e 00 4b 50 50 50 50 50    ?.KPPPPP?.KPPPPP
80: 1e 00 4b 50 50 50 50 50 1e 00 4b 50 50 50 50 50    ?.KPPPPP?.KPPPPP
90: 1e 00 4b 50 50 50 50 50 1e 00 4b 50 50 50 50 50    ?.KPPPPP?.KPPPPP
a0: 1e 00 4b 50 50 50 50 50 1e 00 4b 50 50 50 50 50    ?.KPPPPP?.KPPPPP
b0: 1e 00 4b 50 50 50 50 50 1e 00 4b 50 50 50 50 50    ?.KPPPPP?.KPPPPP
c0: 1e 00 4b 50 50 50 50 50 1e 00 4b 50 50 50 50 50    ?.KPPPPP?.KPPPPP
d0: 1e 00 4b 50 50 50 50 50 1e 00 4b 50 50 50 50 50    ?.KPPPPP?.KPPPPP
e0: 1e 00 4b 50 50 50 50 50 1e 00 4b 50 50 50 50 50    ?.KPPPPP?.KPPPPP
f0: 1e 00 4b 50 50 50 50 50 1e 00 4b 50 50 50 50 50    ?.KPPPPP?.KPPPPP

[root@earth root]# i2cdump 0 0x4d w
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x4d, mode word
  You have five seconds to reconsider and press CTRL-C!
 
     0,8  1,9  2,a  3,b  4,c  5,d  6,e  7,f
00: 7f1e ff00 7f4b 7f50 7f50 7f50 7f50 7f50
08: 7f1e ff00 7f4b 7f50 7f50 7f50 7f50 7f50
10: 7f1e ff00 7f4b 7f50 7f50 7f50 7f50 7f50
18: 7f1e ff00 7f4b 7f50 7f50 7f50 7f50 7f50
20: 7f1e ff00 7f4b 7f50 7f50 7f50 7f50 7f50
28: 7f1e ff00 7f4b 7f50 7f50 7f50 7f50 7f50
30: 7f1e ff00 7f4b 7f50 7f50 7f50 7f50 7f50
38: 7f1e ff00 7f4b 7f50 7f50 7f50 7f50 7f50
40: 7f1e ff00 7f4b 7f50 7f50 7f50 7f50 7f50
48: 7f1e ff00 7f4b 7f50 7f50 7f50 7f50 7f50
50: 7f1e ff00 7f4b 7f50 7f50 7f50 7f50 7f50
58: 7f1e ff00 7f4b 7f50 7f50 7f50 7f50 7f50
60: 7f1e ff00 7f4b 7f50 7f50 7f50 7f50 7f50
68: 7f1e ff00 7f4b 7f50 7f50 7f50 7f50 7f50
70: 7f1e ff00 7f4b 7f50 7f50 7f50 7f50 7f50
78: 7f1e ff00 7f4b 7f50 7f50 7f50 7f50 7f50
80: 7f1e ff00 7f4b 7f50 7f50 7f50 7f50 7f50
88: 7f1e ff00 7f4b 7f50 7f50 7f50 7f50 7f50
90: 7f1e ff00 7f4b 7f50 7f50 7f50 7f50 7f50
98: 7f1e ff00 7f4b 7f50 7f50 7f50 7f50 7f50
a0: 7f1e ff00 7f4b 7f50 7f50 7f50 7f50 7f50
a8: 7f1e ff00 7f4b 7f50 7f50 7f50 7f50 7f50
b0: 7f1e ff00 7f4b 7f50 7f50 7f50 7f50 7f50
b8: 7f1e ff00 7f4b 7f50 7f50 7f50 7f50 7f50
c0: 7f1e ff00 7f4b 7f50 7f50 7f50 7f50 7f50
c8: 7f1e ff00 7f4b 7f50 7f50 7f50 7f50 7f50
d0: 7f1e ff00 7f4b 7f50 7f50 7f50 7f50 7f50
d8: 7f1e ff00 7f4b 7f50 7f50 7f50 7f50 7f50
e0: 7f1e ff00 7f4b 7f50 7f50 7f50 7f50 7f50
e8: 7f1e ff00 7f4b 7f50 7f50 7f50 7f50 7f50
f0: 7f1e ff00 7f4b 7f50 7f50 7f50 7f50 7f50
f8: 7f1e ff00 7f4b 7f50 7f50 7f50 7f50 7f50

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
