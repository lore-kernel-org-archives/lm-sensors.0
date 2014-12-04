From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 04 Dec 2014 17:32:28 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: tmp401: add support for TI TMP435
Message-Id: <20141204183228.0b8cbbe3@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1417687048-21455-1-git-send-email-bgolaszewski@baylibre.com>
	<1417687048-21455-2-git-send-email-bgolaszewski@baylibre.com>
	<54806D6C.7060009@roeck-us.net>
	<CAMpxmJUVQyU_NC=7wByinboM-n9kvQoDALZ3-ZiDmRatKQp8Rg@mail.gmail.com>
In-Reply-To: <CAMpxmJUVQyU_NC=7wByinboM-n9kvQoDALZ3-ZiDmRatKQp8Rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Patrick Titiano <ptitiano@baylibre.com>, LKML <linux-kernel@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, LM Sensors <lm-sensors@lm-sensors.org>

On Thu, 4 Dec 2014 15:33:47 +0100, Bartosz Golaszewski wrote:
> 2014-12-04 15:19 GMT+01:00 Guenter Roeck <linux@roeck-us.net>:
> > The datasheet claims otherwise (0x31, specifically).
> > Is this based on real chip information ?
> > Can you send me the output from i2cdump for the chip ?
> >
> 
> This is what I'm reading:
> 
> # i2cdump -y 1 0x4c
> No size specified (using byte-data access)
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 1a 1b 00 00 05 55 00 55 00 00 05 55 00 55 00 0d    ??..?U.U..?U.U.?
> 10: 70 00 00 00 00 90 00 00 00 55 1c XX XX XX XX 00    p....?...U?XXXX.
> 20: 55 0a 70 XX XX 0f XX XX XX XX XX XX XX XX XX XX    U?pXX?XXXXXXXXXX
> 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> f0: XX XX XX XX XX XX XX XX XX XX XX XX 00 35 55 35    XXXXXXXXXXXX.5U5
> 
> # i2cget -y 1 0x4c 0xff b
> 0x35

That makes sense for a chip named TMP435. Looks like TI forgot to
update the value when copying the datasheet from TMP431 to TMP435.

Thanks for the dump, by the way :)

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
