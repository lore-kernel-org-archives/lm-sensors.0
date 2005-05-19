From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: I have information on Winbond W83627EHF Chip
Message-Id: <20050209202017.21805a7f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050208060234.44864.qmail@web50702.mail.yahoo.com>
In-Reply-To: <20050208060234.44864.qmail@web50702.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

> Do you use any instant message programs? I have Yahoo Messenger, MSN
> Messenger, and AIM, and it might be easier to communicate instead of
> waiting for e-mails.

Don't know if that counts as an instant message protocol but I'm on IRC
most of the time (freenode network, #linux-sensors).

> Well, I can look at the motherboard and actually see the Winbond chip
> right there on the board. It has the winbond logo and the number on it
> is W83627EHF-A.
> 
> I didn't notice the "-A" before, but I'm not sure if that means
> anything.

I don't think it does, most Winbond chips seem to have that kind of name
extention and it never meant anything (to me at least).

> I have gone into my BIOS settings and looked at the hardware monitor
> and here are some of the settings it monitors:
> --------------
> CPU Temp
> MB Temp
> CPU Q-Fan Control
> CPU Q-Fan Mode
> CPU Fan Ratio
> CPU Target Temperature
> CPU Fan Speed
> Chassis Fan Speed
> Vcore Voltage
> 3.3V Voltage
> 5V Voltage
> 12V Voltage
> --------------

I take good note, for the time we'll have lm_sensors values to compare
with.

> The Q-fan thing is specific to Asus and can automatically turn fan
> speeds up and down depending on temperatures.

Asus wants you to believe it's specific to them, while it's not. This is
a feature of the Winbond chip itself ("Thermal Cruise" as they call it).
Asus gives it a different name for obvious marketing reasons, but no way
this is theirs.

> Here is the output from "isadump 0x295 0x296":
> WARNING! Running this program can cause system crashes, data loss and
> worse!
> I will probe address register 0x295 and data register 0x296.
> Continue? [Y/n] Y
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 01 bf 04 c8 11 00 47 30 01 c8 01 c8 3c 3c 01 0a
> 10: 01 00 10 00 00 01 01 3c 43 00 ff ff 24 32 00 e3
> 20: a0 e6 cd cc ff cb 89 29 ff d3 ff e7 00 00 00 00
> 30: 10 00 00 00 0c 03 00 00 00 04 00 00 40 40 01 ff
> 40: 03 de 2f de ff 00 03 74 2d 44 01 c4 18 95 06 a3
> 50: e4 1f 59 96 3a 39 3d 3d e4 1f 59 96 3a 39 3d 3d
> 60: a0 e6 cd cc ff cb 89 29 ff d3 ff e7 00 00 00 00
> 70: 10 00 00 00 0c 03 00 00 00 04 00 00 40 40 01 ff
> 80: 01 bf 04 c8 11 00 47 30 01 c8 01 c8 3c 3c 01 0a
> 90: 01 00 10 00 00 01 01 3c 43 00 ff ff 24 32 00 e3
> a0: a0 e6 cd cc ff cb 89 29 ff d3 ff e7 00 00 00 00
> b0: 10 00 00 00 0c 03 00 00 00 04 00 00 40 40 01 ff
> c0: 03 00 00 de ff 00 03 74 2d 44 01 c4 18 95 06 a3
> d0: e4 1f 59 96 3a 39 3d 3d e4 1f 59 96 3a 39 3d 3d
> e0: a0 e6 cd cc ff cb 89 29 ff d3 ff e7 00 00 00 00
> f0: 10 00 00 00 0c 03 00 00 00 04 00 00 40 40 01 ff

OK... Your chip is stuck with bank 6 selected. Sensors-detect can only
detect Winbond chips on bank 0 (the default). Please do:

isaset 0x295 0x296 0x4e 0

then again:

isadump 0x295 0x296

You may even try sensors-detect and see if the W83627EHF is now found as
an ISA chip as well.

Thanks!
-- 
Jean Delvare
