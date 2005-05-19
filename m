From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: lm77 on national sc1100
Message-Id: <20040701171427.GB2597@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <1088690691.2862.25.camel@null>
In-Reply-To: <1088690691.2862.25.camel@null>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Jean Delvare <khali@linux-fr.org> [2004-07-01 17:45:29 +0200]:
> Do we have a dump of a LM75 chip? I think I remember Mark Hoffman has
> access to such a chip. Hopefully, LM75 compatible chips such as the DS75
> and DS1775 will behave likewise.

Two of them, actually.  Though they look suspiciously like subclients,
they're not.  I have confirmed by visual inspection that this board
has one LM79 and two LM75s.  Here they are:

[root@earth root]# i2cdump 0 0x4c
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x4c, mode byte
  You have five seconds to reconsider and press CTRL-C!
 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 1c 00 32 3c 3c 3c 3c 3c 1c 00 32 3c 3c 3c 3c 3c    ?.2<<<<<?.2<<<<<
10: 1c 00 32 3c 3c 3c 3c 3c 1c 00 32 3c 3c 3c 3c 3c    ?.2<<<<<?.2<<<<<
20: 1c 00 32 3c 3c 3c 3c 3c 1c 00 32 3c 3c 3c 3c 3c    ?.2<<<<<?.2<<<<<
30: 1c 00 32 3c 3c 3c 3c 3c 1c 00 32 3c 3c 3c 3c 3c    ?.2<<<<<?.2<<<<<
40: 1c 00 32 3c 3c 3c 3c 3c 1c 00 32 3c 3c 3c 3c 3c    ?.2<<<<<?.2<<<<<
50: 1c 00 32 3c 3c 3c 3c 3c 1c 00 32 3c 3c 3c 3c 3c    ?.2<<<<<?.2<<<<<
60: 1c 00 32 3c 3c 3c 3c 3c 1c 00 32 3c 3c 3c 3c 3c    ?.2<<<<<?.2<<<<<
70: 1c 00 32 3c 3c 3c 3c 3c 1c 00 32 3c 3c 3c 3c 3c    ?.2<<<<<?.2<<<<<
80: 1c 00 32 3c 3c 3c 3c 3c 1c 00 32 3c 3c 3c 3c 3c    ?.2<<<<<?.2<<<<<
90: 1c 00 32 3c 3c 3c 3c 3c 1c 00 32 3c 3c 3c 3c 3c    ?.2<<<<<?.2<<<<<
a0: 1c 00 32 3c 3c 3c 3c 3c 1c 00 32 3c 3c 3c 3c 3c    ?.2<<<<<?.2<<<<<
b0: 1c 00 32 3c 3c 3c 3c 3c 1c 00 32 3c 3c 3c 3c 3c    ?.2<<<<<?.2<<<<<
c0: 1c 00 32 3c 3c 3c 3c 3c 1c 00 32 3c 3c 3c 3c 3c    ?.2<<<<<?.2<<<<<
d0: 1c 00 32 3c 3c 3c 3c 3c 1c 00 32 3c 3c 3c 3c 3c    ?.2<<<<<?.2<<<<<
e0: 1c 00 32 3c 3c 3c 3c 3c 1c 00 32 3c 3c 3c 3c 3c    ?.2<<<<<?.2<<<<<
f0: 1c 00 32 3c 3c 3c 3c 3c 1c 00 32 3c 3c 3c 3c 3c    ?.2<<<<<?.2<<<<<

[root@earth root]# i2cdump 0 0x4d
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x4d, mode byte
  You have five seconds to reconsider and press CTRL-C!
 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 1e 00 32 3c 3c 3c 3c 3c 1e 00 32 3c 3c 3c 3c 3c    ?.2<<<<<?.2<<<<<
10: 1e 00 32 3c 3c 3c 3c 3c 1e 00 32 3c 3c 3c 3c 3c    ?.2<<<<<?.2<<<<<
20: 1e 00 32 3c 3c 3c 3c 3c 1e 00 32 3c 3c 3c 3c 3c    ?.2<<<<<?.2<<<<<
30: 1e 00 32 3c 3c 3c 3c 3c 1e 00 32 3c 3c 3c 3c 3c    ?.2<<<<<?.2<<<<<
40: 1e 00 32 3c 3c 3c 3c 3c 1e 00 32 3c 3c 3c 3c 3c    ?.2<<<<<?.2<<<<<
50: 1e 00 32 3c 3c 3c 3c 3c 1e 00 32 3c 3c 3c 3c 3c    ?.2<<<<<?.2<<<<<
60: 1e 00 32 3c 3c 3c 3c 3c 1e 00 32 3c 3c 3c 3c 3c    ?.2<<<<<?.2<<<<<
70: 1e 00 32 3c 3c 3c 3c 3c 1e 00 32 3c 3c 3c 3c 3c    ?.2<<<<<?.2<<<<<
80: 1e 00 32 3c 3c 3c 3c 3c 1e 00 32 3c 3c 3c 3c 3c    ?.2<<<<<?.2<<<<<
90: 1e 00 32 3c 3c 3c 3c 3c 1e 00 32 3c 3c 3c 3c 3c    ?.2<<<<<?.2<<<<<
a0: 1e 00 32 3c 3c 3c 3c 3c 1e 00 32 3c 3c 3c 3c 3c    ?.2<<<<<?.2<<<<<
b0: 1e 00 32 3c 3c 3c 3c 3c 1e 00 32 3c 3c 3c 3c 3c    ?.2<<<<<?.2<<<<<
c0: 1e 00 32 3c 3c 3c 3c 3c 1e 00 32 3c 3c 3c 3c 3c    ?.2<<<<<?.2<<<<<
d0: 1e 00 32 3c 3c 3c 3c 3c 1e 00 32 3c 3c 3c 3c 3c    ?.2<<<<<?.2<<<<<
e0: 1e 00 32 3c 3c 3c 3c 3c 1e 00 32 3c 3c 3c 3c 3c    ?.2<<<<<?.2<<<<<
f0: 1e 00 32 3c 3c 3c 3c 3c 1e 00 32 3c 3c 3c 3c 3c    ?.2<<<<<?.2<<<<<

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
