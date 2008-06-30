From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 30 Jun 2008 13:18:50 +0000
Subject: Re: [lm-sensors] Only coretemp is found by sensors-detect
Message-Id: <20080630151850.7183fa46@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <8bdcba610806250808x6dae4815h7272666180d133b7@mail.gmail.com>
In-Reply-To: <8bdcba610806250808x6dae4815h7272666180d133b7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 25 Jun 2008 21:40:50 -0400, Chris Friedline wrote:
> Here is the output from i2cdump.  Does anyone see anything?
> 
> Here is the output from i2cdump 0 0x2e:
> 
> No size specified (using byte-data access)
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0, address 0x2e, mode byte
> Continue? [Y/n] y
>     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 80    ...............?
> 10: 00 00 00 00 00 00 00 00 0f 07 07 07 07 0f 0f 0f    ........????????
> 20: 00 95 bf 96 00 95 5e 5c 5d 5c 57 5c 2c 14 fe 0b    .???.?^\]\W\,???
> 30: f4 11 83 0a ff ff 2a 57 25 01 00 1a a1 00 5c a0    ????..*W%?.??.\?

According to doc/chips/SUMMARY, 0x5c at 0x3e hints at an SMSC chip. The
chip id would be 0xa0 at 0x3f, but this isn't one we know of.

> 40: 01 00 00 00 00 00 00 b8 1e 00 00 00 5a da b3 cd    ?......??...Z???
> 50: 8d a7 00 00 5a da 00 a4 00 a4 00 a4 00 a4 00 ff    ??..Z?.?.?.?.?..
> 60: 00 ff 50 46 50 46 50 46 50 46 50 46 00 05 00 00    ..PFPFPFPFPF.?..
> 70: 00 00 00 00 00 00 00 00 00 00 b9 3e 00 00 00 00    ..........?>....
> 80: 00 00 00 bb bb dd dd c8 08 88 51 60 54 00 00 00    ...???????Q`T...
> 90: 83 83 83 83 59 6a a9 a9 a9 a9 00 00 00 00 00 00    ????Yj????......
> a0: ea ea 2a 00 04 04 04 04 00 00 00 00 0a 2a 88 88    ??*.????....?*??
> b0: 88 88 6d 76 00 00 ff de 40 00 10 5e 00 00 00 00    ??mv...?@.?^....
> c0: 00 00 00 00 ff ff ff ff ff ff 00 02 00 00 00 00    ...........?....
> d0: 00 e5 00 00 00 00 ff 00 00 00 00 ff 00 00 00 00    .?..............
> e0: 00 00 08 e0 60 00 4f 00 08 00 d5 d5 d5 d5 0f 32    ..??`.O.?.?????2
> f0: 30 b0 31 b1 9a 00 40 00 40 00 00 00 00 00 00 00    0?1??.@.@.......

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
