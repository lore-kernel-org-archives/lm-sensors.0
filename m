From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 25 Oct 2007 11:59:56 +0000
Subject: Re: [lm-sensors] [PATCH] On n2100 systems,
Message-Id: <20071025135956.6be6a7a3@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071016100857.GA25544@kos.to>
In-Reply-To: <20071016100857.GA25544@kos.to>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Riku,

On Wed, 24 Oct 2007 17:03:28 +0300, Riku Voipio wrote:
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 01 03 82 40 5c 18 ff ff ff ff ff ff ff ff ff ff    ???@\?..........
> 10: d8 a8 d7 72 24 22 ff ff ff ff ff ff ff ff ff ff    ???r$"..........
> 20: ff 00 ff 00 ff 00 ff 00 3c 37 3c 37 ff ff ff ff    ........<7<7....
> 30: 00 00 00 00 00 f0 00 03 00 ff ff ff ff ff ff ff    .....?.?........
> 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 50: ff ff ff ff ff ff ff ff ff ff 03 06 15 19 34 ff    ..........????4.
> 60: 50 02 09 00 00 00 09 89 89 30 30 10 10 33 32 00    P??...???00??32.
> 70: ff ff ff ff ff ff 00 05 0a ff ff ff f5 00 ff ff    .......??...?...
> 80: ff ff ff ff ff ff 00 05 0a ff ff ff f5 00 ff ff    .......??...?...
> 90: 00 00 0d ff ff ff ff ff ff ff ff ff ff ff ff ff    ..?.............
> a0: 3c 32 28 1e ff ff ff ff ff ff ff ff ff ff ff ff    <2(?............
> b0: 3c 32 28 1e ff ff ff ff ff ff ff ff ff ff ff ff    <2(?............
> c0: ae 04 ae 04 ff ff ff ff ff ff ff ff ff ff ff ff    ????............
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> f0: 80 80 00 00 00 03 5b 06 c0 00 00 ff ff ff ff 1d    ??...?[??......?

Register 0x60 has value 0x50, meaning that both fans are in manual
mode. This is _not_ the chip default according to the datasheet.
Registers 0x76 and 0x86 have value 0x00, which mean PWM duty cycle at
0% for both fans. Again this is _not_ the chip default according to the
datasheet.

So, assuming that the dump above was really taken right after boot
before the Linux kernel driver had a chance to change register values,
and also assuming that the datasheet provided by Fintek is correct,
this really means that Thecus are voluntarily stopping the fans at boot
time. That's a pretty stupid thing to do.

This doesn't imply whether we should or shouldn't start the fans at a
later point, of course. But at least it explains why the fans aren't
spinning at boot when the datasheet defaults suggested that they should.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
