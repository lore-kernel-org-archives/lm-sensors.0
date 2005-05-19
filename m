From: sascha@akv-soft.de (Sascha Volkenandt)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: SAA1064 sensors chip driver
Message-Id: <200307142015.09017.sascha@akv-soft.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307131153.24333.sascha@akv-soft.de>
In-Reply-To: <200307131153.24333.sascha@akv-soft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

At Montag, 14. Juli 2003 13:46 you wrote:
> Here you are:
> #define I2C_DRIVERID_SAA1064 1041

Thanks :-)

> You should take a look at our matorb driver, which handles Matrix
> Orbital LCD displays. There may be similar mechanisms with the hardware
> you are writing a driver for. Probably not enough to make a similar
> driver (not even the same I2C address) but worth the look anyway.

Yes, I have used pcf8574.c as a template, and matorb.c to "steal" the code 
for the digit registers, but I implemented communication differently, since 
this chip doesn't react to smbus-like commands (like those two do), but 
needs real i2c-com.

I have to look about the addresses, my devices are hardwired on 0x38 and 
0x3b, but the datasheet says something completely different about possible 
addresses. Also, the datasheet says reading (one status byte with one bit 
indicating a power loss) is on a different address than writing. By now, I 
have these two addresses as the only probed ones (which also conflict with 
the pcf8574a driver :-( ).

> Once you have your driver ready, send it to us so that we can have a
> look and tell you what we think about it. If you follow the guidelines
> as found in our docs, it should be OK. Howevern, due to a recent change
> in our structures, if you have written your driver for the 2.4.21 Linux
> kernel, it won't integrate directly into lm_sensors CVS. Don't worry,
> we'll take care of this point.

Currently I'm using a sensors- and i2c-2.7.0 patched kernel. But I guess 
"recent" doesn't include that :-)

> We also have to find a detection mechanism for the SAA1064. It doesn't
> seem to have any register dedicated to identification, so it will be
> tricky. However, it looks like there are only three wires for register
> selection, so maybe the data will "cycle" over 8-byte boundaries (the
> same way the LM75 cycles over 4-byte boundaries. That, plus the fact
> that the SAA1064 uses an unusual address range (0x38-0x3b), should make
> the detection possible. Could you send us the output of i2cdump for
> confirmation? Also, bit 7 of the control register seems to be unused, as
> seem to be the registers 0x05 to 0x07. That may help for the detection
> too.

The chip receives an register-address byte followed by n (don't know how 
many, datasheet only specifies 6 at once) data bytes. The register address 
is encreased by every data byte, wrapping around at 7. The data has to be 
written in one physical block, since the device expects a new block 
starting with the register-address after a stop-condition. That's why 
smbus-commands don't work either, I guess.

Well i2cdump doesn't give ME much info, maybe it does for you (output for 
modes byte, word and i2cblock attached).

> Phil will do so when he's back, I hope.

Thx.

Greetings,
Sascha
-------------- next part --------------
# i2cdump 2 0x38 b
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................


# i2cdump 2 0x38 w
     0,8  1,9  2,a  3,b  4,c  5,d  6,e  7,f
00: 0000 0000 0000 0000 0000 0000 0000 0000 
08: 0000 0000 0000 0000 0000 0000 0000 0000 
10: 0000 0000 0000 0000 0000 0000 0000 0000 
18: 0000 0000 0000 0000 0000 0000 0000 0000 
20: 0000 0000 0000 0000 0000 0000 0000 0000 
28: 0000 0000 0000 0000 0000 0000 0000 0000 
30: 0000 0000 0000 0000 0000 0000 0000 0000 
38: 0000 0000 0000 0000 0000 0000 0000 0000 
40: 0000 0000 0000 0000 0000 0000 0000 0000 
48: 0000 0000 0000 0000 0000 0000 0000 0000 
50: 0000 0000 0000 0000 0000 0000 0000 0000 
58: 0000 0000 0000 0000 0000 0000 0000 0000 
60: 0000 0000 0000 0000 0000 0000 0000 0000 
68: 0000 0000 0000 0000 0000 0000 0000 0000 
70: 0000 0000 0000 0000 0000 0000 0000 0000 
78: 0000 0000 0000 0000 0000 0000 0000 0000 
80: 0000 0000 0000 0000 0000 0000 0000 0000 
88: 0000 0000 0000 0000 0000 0000 0000 0000 
90: 0000 0000 0000 0000 0000 0000 0000 0000 
98: 0000 0000 0000 0000 0000 0000 0000 0000 
a0: 0000 0000 0000 0000 0000 0000 0000 0000 
a8: 0000 0000 0000 0000 0000 0000 0000 0000 
b0: 0000 0000 0000 0000 0000 0000 0000 0000 
b8: 0000 0000 0000 0000 0000 0000 0000 0000 
c0: 0000 0000 0000 0000 0000 0000 0000 0000 
c8: 0000 0000 0000 0000 0000 0000 0000 0000 
d0: 0000 0000 0000 0000 0000 0000 0000 0000 
d8: 0000 0000 0000 0000 0000 0000 0000 0000 
e0: 0000 0000 0000 0000 0000 0000 0000 0000 
e8: 0000 0000 0000 0000 0000 0000 0000 0000 
f0: 0000 0000 0000 0000 0000 0000 0000 0000 
f8: 0000 0000 0000 0000 0000 0000 0000 0000 


# i2cdump 2 0x38 i
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
