From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:27 +0000
Subject: Summit SMM605 Supply Voltage Monitor?
Message-Id: <41CAF84A.1000109@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <41C9D71E.7050500@sandburst.com>
In-Reply-To: <41C9D71E.7050500@sandburst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Interesting chip.
Haven't heard of it before. I'll add it to our 'new drivers' page.
Are you working on a driver?
For a model of a chip driver with multiple i2c addresses, look at w83781d.
We call the additional addresses 'subclients'.

Travis B. Sawyer wrote:
> Greetings!
> 
> Anyone doing any driver work for the Summit SMM605 Supply Voltage Monitor?
> 
> 
> I have a bit of a conumdrum.
> 
> This device shows up at the following addresses (all for the same chip):
> 
> 0x4b, 0x50, 0x51, & 0x53
> 
> 0x50 & 0x51 are the two 2k bits eeproms
> 0x53 are the voltage configuration registers
> 0x4b are the write protect and 2 config regs.
> 
> I'm not too worried about the eeprom pages.  However, the 0x4b & 0x53 
> register banks _*SHOULD*_ look like one device to the user.
> 
> Is there any way to do that?
> 
> With the eeprom module loaded, 0x50, 0x51, & 0x53 show up as eeproms 
> (0x53 should show up as the SMM605 when I do the driver, as long as I 
> can figure out a detection scheme).
> 
> Are there other devices (SuperIO) that I can use as a template that have 
>  register banks at different addresses, yet show up as a 'single' entry 
> in procfs/sysfs?
> 
> I've included a register dump of 0x4b and 0x53 in the hope that it may 
> help.
> 
> Datasheet:
> http://www.summitmicro.com/prod_select/summary/smm605/SMM605DS.pdf
> http://tinyurl.com/42tge
> 
> 
> AppNote: (contains the register defn's)
> http://www.summitmicro.com/tech_support/notes/note40/note40.pdf
> http://tinyurl.com/4w2cf
> 
> 
> Thanx in advance,
> 
> Travis Sawyer
> 
> bash-2.05b# i2cdump 1 0x4b
> No size specified (using byte-data access)
>   WARNING! This program can confuse your I2C bus, cause data loss and 
> worse!
>   I will probe file /dev/i2c/1, address 0x4b, mode byte
>   You have five seconds to reconsider and press CTRL-C!
> 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 80: 00 07 ff 05 00 00 00 ff 03 ff ff ff ff ff ff ff    .?.?....?.......
> 90: 00 07 ff 05 00 00 00 ff 03 ff ff ff ff ff ff ff    .?.?....?.......
> a0: 00 07 ff 05 00 00 00 ff 03 ff ff ff ff ff ff ff    .?.?....?.......
> b0: 00 07 ff 05 00 00 00 ff 03 ff ff ff ff ff ff ff    .?.?....?.......
> c0: 00 07 ff 05 00 00 00 ff 03 ff ff ff ff ff ff ff    .?.?....?.......
> d0: 00 07 ff 05 00 00 00 ff 03 ff ff ff ff ff ff ff    .?.?....?.......
> e0: 00 07 ff 05 00 00 00 ff 03 ff ff ff ff ff ff ff    .?.?....?.......
> f0: 00 07 ff 05 00 00 00 ff 03 ff ff ff ff ff ff ff    .?.?....?.......
> 
> bash-2.05b# i2cdump 1 0x53
> No size specified (using byte-data access)
>   WARNING! This program can confuse your I2C bus, cause data loss and 
> worse!
>   I will probe file /dev/i2c/1, address 0x53, mode byte
>   You have five seconds to reconsider and press CTRL-C!
> 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 0d 83 0d ff 0e 61 0e c7 0f 54 0b 20 3f 3f 03 40    ???.?a???T? ???@
> 10: 8f 9f af bf cf df 00 00 00 02 00 02 00 02 00 02    ??????...?.?.?.?
> 20: 2f 85 5d 00 21 1f 00 00 00 00 00 00 00 00 00 00    /?].!?..........
> 30: 0d 60 0d dc 0e 45 0e a2 0f 08 0f d6 00 12 50 00    ?`???E??????.?P.
> 40: 0d b9 0e 39 0e a4 0f 16 0f b4 06 81 00 00 00 00    ???9????????....
> 50: ba 59 12 73 14 79 12 7c 14 81 00 00 00 00 00 00    ?Y?s?y?|??......
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 70: ba 59 00 6d 00 36 00 c0 00 88 00 80 00 00 00 00    ?Y.m.6.?.?.?....
> 80: 42 48 82 3e 2a b8 12 f6 41 c8 81 b9 2a 34 12 49    BH?>*???A???*4?I
> 90: 49 5c 81 52 29 d7 11 eb 41 3e 81 33 29 9a 11 ae    I\?R)???A>?3)???
> a0: 41 0b 80 f6 29 5d 11 71 40 ce 80 8f 29 1f 11 33    A???)]?q@???)??3
> b0: 2a 67 0a 52 03 ff 03 ff 0d 9a 0d 56 0f e0 0f e0    *g?R?.?.???V????
> c0: 0b 38 0b 38 09 90 09 90 0c 00 0c 00 0f ff 0f ff    ?8?8?????.?.?.?.
> d0: 0c 00 0c 00 0f d8 0f d8 00 00 00 00 00 00 00 00    ?.?.????........
> e0: 00 3d 00 3d 00 3d 00 3d 00 3d 00 3d 00 00 00 00    .=.=.=.=.=.=....
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 
> 
