From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Thu, 04 Dec 2014 14:33:47 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: tmp401: add support for TI TMP435
Message-Id: <CAMpxmJUVQyU_NC=7wByinboM-n9kvQoDALZ3-ZiDmRatKQp8Rg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1417687048-21455-1-git-send-email-bgolaszewski@baylibre.com>
	<1417687048-21455-2-git-send-email-bgolaszewski@baylibre.com>
	<54806D6C.7060009@roeck-us.net>
In-Reply-To: <54806D6C.7060009@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, LM Sensors <lm-sensors@lm-sensors.org>

2014-12-04 15:19 GMT+01:00 Guenter Roeck <linux@roeck-us.net>:
> The datasheet claims otherwise (0x31, specifically).
> Is this based on real chip information ?
> Can you send me the output from i2cdump for the chip ?
>

This is what I'm reading:

# i2cdump -y 1 0x4c
No size specified (using byte-data access)
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 1a 1b 00 00 05 55 00 55 00 00 05 55 00 55 00 0d    ??..?U.U..?U.U.?
10: 70 00 00 00 00 90 00 00 00 55 1c XX XX XX XX 00    p....?...U?XXXX.
20: 55 0a 70 XX XX 0f XX XX XX XX XX XX XX XX XX XX    U?pXX?XXXXXXXXXX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
f0: XX XX XX XX XX XX XX XX XX XX XX XX 00 35 55 35    XXXXXXXXXXXX.5U5

# i2cget -y 1 0x4c 0xff b
0x35

Bart

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
