From: BGardner@Wabtec.com (BGardner@Wabtec.com)
Date: Fri, 10 Jun 2005 16:55:41 +0000
Subject: [lm-sensors] How can I skip i2c detection?
Message-Id: <F06EB2894F3F0D45AD9BEA7246DE9C9085549D@WCSEXCMBS1.ad.wabtec.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <F06EB2894F3F0D45AD9BEA7246DE9C90854F15@WCSEXCMBS1.ad.wabtec.com>
In-Reply-To: <F06EB2894F3F0D45AD9BEA7246DE9C90854F15@WCSEXCMBS1.ad.wabtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean,

Here's the i2cdump output.  
I did not run sensors-detect on my target, as perl isn't installed.

Ben

~ # i2cdump 0 0x4c
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and
worse!
I will probe file /dev/i2c/0, address 0x4c, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 20 2f 00 3c 00 2d 2d 50 50 50 50 50 50 50 50 50     /.<.--PPPPPPPPP
10: 50 50 50 50 50 50 50 50 50 50 50 50 50 50 50 50    PPPPPPPPPPPPPPPP
20: 50 50 50 50 50 50 50 50 50 50 50 50 50 50 50 50    PPPPPPPPPPPPPPPP
30: 7f 7f 7f 7f 7f 24 24 24 7f 7f 7f 7f 7f 7f 7f 7f    ?????$$$????????
40: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f    ????????????????
50: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f    ????????????????
60: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f    ????????????????
70: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f    ????????????????
80: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f    ????????????????
90: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f    ????????????????
a0: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f    ????????????????
b0: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f    ????????????????
c0: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f    ????????????????
d0: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f    ????????????????
e0: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f    ????????????????
f0: 00 01 0f 34 26 26 26 00 0d 03 02 02 02 02 01 03    .??4&&&.????????

Wow, i2cdump runs MUCH faster with those timing changes!


-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org] 
Sent: Friday, June 10, 2005 2:13 AM
To: Gardner, Ben
Cc: LM Sensors
Subject: RE: [lm-sensors] How can I skip i2c detection?


Hi Ben,

> Good point about the 127.
> Perhaps there isn't a reliable way to distinguish the two chips. =(

Does sensors-detect find an LM82, or an LM83? Or both? Or none?

Could you please provide a dump of your LM82 chip (use i2cdump)? I could
compare with my LM83.

If there really is no way to differenciate between both chips, well,
we'll simply document that fact, and invite LM82 owners to ignore the
two irrelevant temperature channels.

Thanks,
--
Jean Delvare


