From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 08 Nov 2005 16:25:43 +0000
Subject: [lm-sensors] adm1027 on 2.6.9-5.EL
Message-Id: <R3lZsKn9.1131462666.7528580.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <XVkq04oM.1131444138.7357880.khali@localhost>
In-Reply-To: <XVkq04oM.1131444138.7357880.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi again Paul,

> > vid:      -3.425 V  (VRM Version 9.1)
>
> Wow. Not good. What value does /sys/bus/i2c/devices/0-002e/cpu0_vid
> contain?

That and the missing +12V reading make me suspicious about the fact that
you actually have an ADM1027 chip. I suspect that you actually have an
ADT7463 chip, misdetected (which is plausible when I look at the driver
code in 2.6.9). Do you confirm this? If you do not know which chip you
do have, please provide the output of "i2cdump 0 0x2e b", this should
answer my question.

According to the datasheet, the ADT7463 can use VRM 10 (i.e. 6-bit VID
values), while other chips in the family couldn't (5-bit VID values).
This is done by connecting VID5 to the +12V input, and changing a
configuration bit in the chip. This would explain the lack of +12V
reading. This also explains the bogus VID reading, as the driver code
didn't expect the new configuration bits in the VID register.

We'll need to update the lm85 driver to support that case.

Thanks,
--
Jean Delvare
