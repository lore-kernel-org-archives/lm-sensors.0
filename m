From: jim.chen@hytec-electronics.co.uk (Jim Chen)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: lm_sensors doesn't detect voltage measurements on HP Proliant
Message-Id: <000401c49b19$1c9a2bd0$aa790251@hytecelectronics.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <000201c49a51$c73208b0$aa790251@hytecelectronics.co.uk>
In-Reply-To: <000201c49a51$c73208b0$aa790251@hytecelectronics.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean,

Thanks a lot.

Please see attached file after using i2cdump 0 0x60. Does that give any
hint?

I am struggling installing HP system inside manager at the moment. It
takes many many steps and very easy to go wrong. I will let you know the
result once I get it running.

Cheers,

Jim

-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org] 
Sent: 15 September 2004 11:06
To: Jim Chen
Cc: sensors@Stimpy.netroedge.com
Subject: Re: lm_sensors doesn't detect voltage measurements on HP
Proliant DL320 G2 machine

On Wed, 15 Sep 2004 09:20:30 +0100, Jim Chen wrote
> Hi Jean,
> 
> Thank you very much for your help.
> 
> The attached file contains the results by using i2cdump. Hope this
help.

First device at 0x33 is "nothing" as expected (most likely the
protection
settings address of the eeprom at 0x53). You missed the second dump, I
asked
for 0x60 and you did 0x69, so you dump the clock device instead of the
unknown
device. You're lucky it didn't freeze your system, since some clock
chips are
known for they moderatrely appreciate being dumped. Please try 0x60 now.

> I have contacted HP. They recommended me to use their "System Inside
> Manager" utility which can show all the measurements. That sounds 
> like they must have a sensor or sensors on the board. But they might 
> not provide the interface for the user to integrate. Is there 
> anything we can do about this that we can get the measurements out?

Sounds much like Compaq and their proprietary "cpqhealth" tool of yore.
These
folks don't seem to like cooperating with us, which is quite strange
since HP
seems to have embraced the open-source movement by now (they even were
the
main sponsor for the Sucon '04 in Zurich in early september).

I would suggest that you give a try to their tool. If it does what you
want, I
guess there is no need to complain. If not, tell them why. And if you
think we
are more likely to provide what you need than they are, tell them, and
ask
them to release details specs for their implementation. Maybe they'll
listen...

As a paying customer, you have much more power than we will ever have,
especially if you have a large number of these machines and are likely
to buy
more at some point in the future.

-- 
Jean Delvare
http://khali.linux-fr.org/

-------------- next part --------------
[root@localhost root]# i2cdump 0 0x60
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x60, mode byte
  You have five seconds to reconsider and press CTRL-C!
 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: XX e0 XX e0 XX 00 XX 00 XX XX XX XX XX XX XX XX    X?X?X.X.XXXXXXXX
10: XX 84 XX 00 XX 08 XX 08 XX XX XX XX XX XX XX XX    X?X.X?X?XXXXXXXX
20: XX 04 XX XX XX XX XX XX XX XX XX XX XX XX XX XX    X?XXXXXXXXXXXXXX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
[root@localhost root]#
