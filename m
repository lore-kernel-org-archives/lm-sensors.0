From: jim.chen@hytec-electronics.co.uk (Jim Chen)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: lm_sensors doesn't detect voltage measurements on HP Proliant
Message-Id: <000001c49afc$e17d0700$aa790251@hytecelectronics.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <000201c49a51$c73208b0$aa790251@hytecelectronics.co.uk>
In-Reply-To: <000201c49a51$c73208b0$aa790251@hytecelectronics.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Thank you very much for your help.

The attached file contains the results by using i2cdump. Hope this help.


I have contacted HP. They recommended me to use their "System Inside
Manager" utility which can show all the measurements. That sounds like
they must have a sensor or sensors on the board. But they might not
provide the interface for the user to integrate. Is there anything we
can do about this that we can get the measurements out?

Kindly regards,

Jim

-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org] 
Sent: 14 September 2004 17:30
To: Jim Chen
Cc: sensors@Stimpy.netroedge.com
Subject: Re: lm_sensors doesn't detect voltage measurements on HP
Proliant DL320 G2 machine

> Please see attached file for details done by sensors-detectprogram. I
am
> using Linux Enterprise 3 (Red Hat 2.4.21).

Actually Red Hat Enterprise 3 (Linux 2.4.21), I presume.

> I have downloaded the lm_sensors2.8.7 and installed on my mahcine and
it
> works fine with the detecting the eepromand AMBus adaptor but couldn't
list
> the voltages, fan speeds and temperatures.It sounds like it couldn't
detect
> the sensors chip. Could you help to have lookwhat exactly happened and
any
> possible solution for this? I have also raised aticket in the forum
with No.
> of 1774.

The output from sensors-detect reveals that you have no known ISA chip,
one
Super-I/O chipset but known not to have integrated sensors, and a few
I2C/SMBus chips (including your memory module EEPROM at 0x53 and
presumably a
clock chip at 0x69). There are two more (unknown) I2C chips at 0x33 and
0x60.
The former is probably the same EEPROM as 0x53 but maybe not.

Both addresses are not typical addresses for hardware monitoring
devices, but
who knows... Please provide the output of "i2cdump 0 0x33" and "i2cdump
0
0x60" (assuming that this is I2C bus 0; if not, pick the correct number
from
/proc/bus/i2c).

Note that i2cdump is potentially dangerous to use especially on unknown
chips,
so run it at your own risk and only if rebooting the machine afterwards
is an
option.

-- 
Jean Delvare 
http://khali.linux-fr.org/

-------------- next part --------------
[root@localhost bus]# i2cdump 0 0x33
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x33, mode byte
  You have five seconds to reconsider and press CTRL-C!
 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
[root@localhost bus]# i2cdump 0 0x69
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x69, mode byte
  You have five seconds to reconsider and press CTRL-C!
 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
10: 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
20: 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
30: 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
40: 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
50: 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
60: 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
70: 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
80: 9b 87 7f c7 3f 00 ff 01 0f 0a 80 95 a3 ed 0f 00    ?????..????????.
90: 84 08 04 03 40 aa aa 20 00 00 00 00 00 d3 XX XX    ????@?? .....?XX
a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
[root@localhost bus]#
