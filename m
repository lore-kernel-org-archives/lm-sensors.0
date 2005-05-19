From: plukje@gmx.net (Eric)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: adm1021 (probably) does something VERY,VERY BAD
Message-Id: <40656F55.2080902@gmx.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4062C734.5000104@gmx.net>
In-Reply-To: <4062C734.5000104@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

root@pathfinder eric # i2cdump 0 0x4e w
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x4e, mode word
  You have five seconds to reconsider and press CTRL-C!
 
     0,8  1,9  2,a  3,b  4,c  5,d  6,e  7,f
00: ff6d ff2d ff10 ff72 ff00 ff80 ff0f ff00
08: ff00 ff00 ffff ff00 ff00 ff00 ffe0 ffff
10: ff00 ff00 ff00 ff00 ff00 ff00 ff00 ff00
18: ff00 ff00 ff00 ff00 ff00 ff00 ff00 ff00
20: ff00 ff00 ff00 ff00 ff00 ff00 ff00 ff00
28: ff00 ff00 ff00 ff00 ff00 ff00 ff00 ff00
30: ff00 ff00 ff00 ff00 ff00 ff00 ff00 ff00
38: ff00 ff00 ff00 ff00 ff00 ff00 ff00 ff00
40: ff00 ff00 ff00 ff00 ff00 ff00 ff00 ff00
48: ff00 ff00 ff00 ff00 ff00 ff00 ff00 ff00
50: ff00 ff00 ff00 ff00 ff00 ff00 ff00 ff00
58: ff00 ff00 ff00 ff00 ff00 ff00 ff00 ff00
60: ff00 ff00 ff00 ff00 ff00 ff00 ff00 ff00
68: ff00 ff00 ff00 ff00 ff00 ff00 ff00 ff00
70: ff00 ff00 ff00 ff00 ff00 ff00 ff00 ff00
78: ff00 ff00 ff00 ff00 ff00 ff00 ff00 ff00
80: ff00 ff00 ff00 ff00 ff00 ff00 ff00 ff00
88: ff00 ff00 ff00 ff00 ff00 ff00 ff00 ff00
90: ff00 ff00 ff00 ff00 ff00 ff00 ff00 ff00
98: ff00 ff00 ff00 ff00 ff00 ff00 ff00 ff00
a0: ff00 ff00 ff00 ff00 ff00 ff00 ff00 ff00
a8: ff00 ff00 ff00 ff00 ff00 ff00 ff00 ff00
b0: ff00 ff00 ff00 ff00 ff00 ff00 ff00 ff00
b8: ff00 ff00 ff00 ff00 ff00 ff00 ff00 ff00
c0: ff00 ff00 ff00 ff00 ff00 ff00 ff00 ff00
c8: ff00 ff00 ff00 ff00 ff00 ff00 ff00 ff00
d0: ff00 ff00 ff00 ff00 ff00 ff00 ff00 ff00
d8: ff00 ff00 ff00 ff00 ff00 ff00 ff00 ff00
e0: ff00 ff00 ff00 ff00 ff00 ff00 ff00 ff00
e8: ff00 ff00 ff00 ff00 ff00 ff00 ff00 ff00
f0: ff00 ff00 ff00 ff00 ff00 ff00 ff00 ff00
f8: ff00 ff00 ff00 ff00 ff00 ff00 ff00 ff00
root@pathfinder eric #

Regards,


Eric


Jean Delvare wrote:

>>This looks to me like a lm75-compatible or adm1021-compatible chip;
>>the address range 48-4f is traditionally for temperature sensors;
>>it wouldn't be that unusual for a board with a w83627hf (with 3 temp
>>sensors) to have another chip to provide additional temperatures.
>>
>
>Granted, it could be an extra temperature sensor. Except that it doesn't
>change values, and shuts the system down when you try to use it ;)
>
>
>>I agree w/ Khali that you can watch the registers with i2cdump
>>(esp. at data address 0x00) to see if it varies with CPU load,
>>if so try loading lm75.
>>
>>The first 4 locations look somewhat like temp, control, hyst, and max
>>to me.... then again, maybe not.
>>
>
>109 degrees C seems slightly excessive for early spring, don't you
>think? Plus there is too much difference between hyst and max, and
>anyway hyst = 16 degrees C doesn't make much sense, and max = 114
>degrees C doesn't make any sense either.
>
>I'm sorry but that chip doesn't look like an LM75 to me at all, and
>since it was already proved that it wasn't adm1021-compatible...
>
>
>>I see the lm75 section in sensors-detect has grown a lot,
>>I don't pretend to understand it all but perhaps there is a new
>>case here or perhaps it is too restrictive?
>>
>
>It hasn't changed much. The extra code is mainly there to refine the
>confidence value we give to the chip (from 6 down to 3). The main
>detection trick is unchanged, and relies of the fact that the LM75
>addresses registers over 3 bits only, so values cycle every 8 bytes.
>This is obviously not the case here, but I agree that a LM75-compatible
>chip wouldn't *have* to behave the same way.
>
>
>>Our first guess for a chip in the range 48-4f should always be lm75
>>or compatible.
>>
>
>I don't see no reason for this. There are many more chips that live in
>this area, especially at 0x4c-0x4e, that are not compatible with the
>LM75 at all, and that are much more likely to be found in modern
>computers (Winbond-like emulation left apart).
>
>
>>Eric perhaps you can look at your board and find out what chip this
>>is, that would be a big help to us.
>>
>
>Sure it would.
>
>Also, Eric, could you try dumping the chip in word mode (i2cdump 0 0x4e
>w)? This will let us know is some registers are word-sized, which would
>help identify the chip.
>
>Thanks.
>
>
