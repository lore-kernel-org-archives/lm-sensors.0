From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: SAA1064 sensors chip driver
Message-Id: <20030717205650.18247faa.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307131153.24333.sascha@akv-soft.de>
In-Reply-To: <200307131153.24333.sascha@akv-soft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I *think* I've found a way to detect this thing. WHen the chip is
> freshly powered on (nothing is displayed), a byte read results in 0x80
> (power failure indicator set to 1), while a subsequent byte read
> results in 0x00 (no power-failure since last read-out). So, if two
> byte reads result in 0x80, followed by 0x00, we'd probably have found
> a saa1064 chip. What do you think, is this secure enough or could it
> confuse other chips possibly using the same address?
> 
> Main problem will be that this will only work one time, after powering
> the chip.

Possible method, but as you say, it ain't really reliable.

I read the datasheet again and finally understood what I first got
wrong. I thought that the saa1064 had 8 R/W registers. Actually it has 8
(5 in use) write only registers, and one read only register. This means
that you can't read back values you wrote in registers (not really
practical, but you can still read the driver's values). What's more, the
readable register doesn't seem to have an address. So whatever address
you try to read, you read this register. Since only one bit in this
register can be set, and it usually isn't, this explains why the i2cdump
command I asked you to try returned only 00 values.

I think that if you power-off the saa1064, power it on again and run the
i2cdump command once at this time, you will have all 00 bytes again,
*except* the first one which will be 80. Could you try that? It would
confirm my understanding is correct.

So, the way to detect it now seems clearer:

1* The most basic way is to read the whole range and say it is a saa1064
if all bytes are 0x00 or 0x80 (that is, (a & 0x7F)=0).

2* We can give it a greater confidence if the first read returns 0x80
and the later ones return 0x00. I do something similar for the lm75
(greater confidence if the temperature limits are the default ones).

3* Instead of 2*, we can re-read the same address if it returns 0x80
once. It should return 0x00 next time, if it is a saa1064.

I like the ideas, but in fact 2* and 3* may not even be necessary. As
far as I know, there are no other chips in our package at the adresses
the saa1064 can use, so we don't need something bulletproof. Let's go
for 1* with maybe a bit of 2*. I'll do it or you can do it if you want.
If you do it, first checkout the latest version of sensors-detect and
send back a patch, not the whole file.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
