From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 31 Mar 2006 12:35:28 +0000
Subject: [lm-sensors] 2.6.16-rc5: unreasonable temperature reported by
Message-Id: <20060331143528.49a916b6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44144A01.2050207@t-online.de>
In-Reply-To: <44144A01.2050207@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Harald,

> Sorry for the late response. See below.

What can I say... ;)

> {root at bugs:harri 1001} i2cdump 0 0x2d b
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0, address 0x2d, mode byte
> Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 01 07 00 40 5a ff ff ff ff ff ff ff ff ff ff ff    ??. at Z...........
> 10: c5 72 7e 85 25 22 01 df 0f fe 00 00 1c 80 ad 07    ?r~?%"????..????
> 20: ff 00 ff 00 ff 00 ff 00 4b 4b 4b 4b 3c 37 00 ff    ........KKKK<7..
> 30: 00 b0 b0 00 00 00 30 ff ff ff ff ff ff ff ff ff    .??...0.........
> 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 50: ff ff ff ff ff ff ff ff ff ff 04 10 20 19 34 ff    ..........?? ?4.
> 60: bb 0a 90 00 01 00 00 0f ff 55 64 46 64 46 ff ff    ???.?..?.UdFdF..
> 70: 02 ab ff ff 00 00 ff ff ff ff ff ff ff ff ff ff    ??..............
> 80: 0f ff ff ff 00 00 ff ff ff ff ff ff ff ff ff ff    ?...............
> 90: 00 00 0d ff ff ff ff ff ff ff ff ff ff ff ff ff    ..?.............
> a0: 46 3c 32 28 ff d9 b2 99 80 ff ff ff ff ff ff ff    F<2(.????.......
> b0: 46 3c 32 28 ff d9 b2 99 80 ff ff ff ff ff ff ff    F<2(.????.......
> c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> f0: 00 00 00 00 00 00 39 38 01 45 00 ff ff ff ff 27    ......98?E.....'

This could be a hardware monitoring chip, according to the number of
registers, and some interesting patterns (0xff and 0x00 repeated at
0x20-0x27 could be input voltage low and high limits, 0x64 and 0x46
repeated at 0x6a could be temperature limits...) but the mapping is not
usual and I can't find any obvious ID register.

You'll have to search the available technical documentation for your
system and/or ask Aopen for information. There's nothing we can do as
long as we don't know what chip we are dealing with.

> {root at bugs:harri 1002} i2cdump 0 0x2f b
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0, address 0x2f, mode byte
> Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: ff 03 07 f0 22 08 ff ff ff ff ff ff ff ff ff ff    .???"?..........
> 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 50: ff ff ff ff ff ff ff ff ff ff 03 02 12 19 34 ff    ..........????4.
> 60: ff ff ff ff ff ff ff ff ff ff a0 a0 ff ff ff ff    ..........??....
> 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> f0: 00 80 ff ff ff ff ff ff ff ff ff ff ff ff ff 5e    .?.............^

I was about to say "No idea about this one", as it has very few
registers and no noticeable patterns, but that "19 34" at 0x5d reminds
me of the Fintek signature in my F71805F Super-I/O chip. Can you please
search your motherboard for a Fintek chip, presumably small?

And now I realize that the chip at 0x2d has the same values at address
0x5d, so it must be a Fintek chip too.

I'll go ask my Fintek contact for additional information while you try
to locate the chips on your board.

-- 
Jean Delvare

