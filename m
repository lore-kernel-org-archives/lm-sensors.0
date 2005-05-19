From: sascha@akv-soft.de (Sascha Volkenandt)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: SAA1064 sensors chip driver
Message-Id: <200307172114.02097.sascha@akv-soft.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307131153.24333.sascha@akv-soft.de>
In-Reply-To: <200307131153.24333.sascha@akv-soft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

At Donnerstag, 17. Juli 2003 20:56 Jean Delvare wrote:
> I read the datasheet again and finally understood what I first got
> wrong. I thought that the saa1064 had 8 R/W registers. Actually it has 8
> (5 in use) write only registers, and one read only register. This means
> that you can't read back values you wrote in registers (not really
> practical, but you can still read the driver's values). What's more, the
> readable register doesn't seem to have an address. So whatever address
> you try to read, you read this register. Since only one bit in this
> register can be set, and it usually isn't, this explains why the i2cdump
> command I asked you to try returned only 00 values.

That's what I tried to explain - there's only one read register, and only 
one bit matters there :-)

> I think that if you power-off the saa1064, power it on again and run the
> i2cdump command once at this time, you will have all 00 bytes again,
> *except* the first one which will be 80. Could you try that? It would
> confirm my understanding is correct.

Exactly - on first readout (_before_ loading the driver the first time, 
that's why I didn't notice) it says 0x80 in the first byte.

> So, the way to detect it now seems clearer:
>
> 1* The most basic way is to read the whole range and say it is a saa1064
> if all bytes are 0x00 or 0x80 (that is, (a & 0x7F)=0).

Well - why all bytes? Only the very first read ever returns 0x80.

> 2* We can give it a greater confidence if the first read returns 0x80
> and the later ones return 0x00. I do something similar for the lm75

Yup that's what I thought, too - 0x80 followed by 0x00

> 3* Instead of 2*, we can re-read the same address if it returns 0x80
> once. It should return 0x00 next time, if it is a saa1064.

As I said - it only returns 0x80 in case of a power loss (which is the case 
after powering up the device). You'd have to force a hardware power-off of 
the chip before it would return 0x80 ever again.

> I like the ideas, but in fact 2* and 3* may not even be necessary. As
> far as I know, there are no other chips in our package at the adresses
> the saa1064 can use, so we don't need something bulletproof. Let's go
> for 1* with maybe a bit of 2*. I'll do it or you can do it if you want.
> If you do it, first checkout the latest version of sensors-detect and
> send back a patch, not the whole file.

The PCF8574A uses the range 0x38 to 0x3f, and detects a saa1064 as a 
pcf8574a when loaded first. I'll put the two-byte-sequence (0x80 followed 
by 0x00) into the module. Maybe you'll do something for sensors-detect?

I hope this weekend I'll find time to finish "the rest" (in-module 
detection, doc, and finally a complete patchset).

Greetings,
Sascha
