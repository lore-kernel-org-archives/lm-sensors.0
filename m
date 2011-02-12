From: Andrew Lutomirski <luto@mit.edu>
Date: Sat, 12 Feb 2011 16:01:11 +0000
Subject: Re: [lm-sensors] [PATCH v3 7/7] hwmon: (w83627ehf) Use 16 bit fan
Message-Id: <AANLkTimuqznZU1-=yxRLKjaCoO1Y6Q2ArU9z=rOLcnJt@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1297444832-10874-8-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1297444832-10874-8-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Feb 12, 2011 at 10:48 AM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> On Sat, Feb 12, 2011 at 08:53:51AM -0500, Andrew Lutomirski wrote:
> [ ...]
> 16 bit mode is always active.
>
> Register 0x29 and 0x632/0x0633 are in sync, though. What is odd is that
> the value is 0x0 in both registers when it should be 0xff or above.
> This is a problem, because if it returns 0x0 in register 0x29 if the divisor
> value is too low, we can not detect that it is too low, and the code
> to automatically increase the divisor does not work.
>
> Can you check what you get for other fan_min values, specifically for 200 ?
> Also, can you check the return values of registers 0x656..0x65d ?
> That should be the direct RPM values. Maybe we have to use the RPM registers
> for the new chips instead of using the fan count.

fan2_min = 200 (div = 64):
fan2_input = 138 (read at a different time, so may differ a little)

[56013.556233] Reg 0028 = 46
[56013.556243] Reg 0029 = 99
[56013.556252] Reg 002a = 00
[56013.556261] Reg 003f = 00
[56013.556286] Reg 0630 = 0046
[56013.556302] Reg 0631 = 4600
[56013.556319] Reg 0632 = 0099
[56013.556336] Reg 0633 = 9900
[56013.556352] Reg 0634 = 0000
[56013.556369] Reg 0635 = 0000
[56013.556386] Reg 0636 = 0000
[56013.556403] Reg 0637 = 0000
[56013.556419] Reg 0656 = 025a
[56013.556436] Reg 0657 = 5a00
[56013.556453] Reg 0658 = 0089
[56013.556469] Reg 0659 = 8900
[56013.556486] Reg 065a = 0000
[56013.556502] Reg 065b = 0000
[56013.556519] Reg 065c = 0000
[56013.556536] Reg 065d = 0000


fan2_min = 502 (div = 32):
fan2_input = 0 (read at a different time, so may differ a little)

[56085.471272] w83627ehf: Found NCT6775F chip at 0x290
[56085.471557] Reg 0028 = 45
[56085.471567] Reg 0029 = 00
[56085.471575] Reg 002a = 00
[56085.471584] Reg 003f = 00
[56085.471610] Reg 0630 = 0045
[56085.471627] Reg 0631 = 4500
[56085.471644] Reg 0632 = 0000
[56085.471661] Reg 0633 = 0000
[56085.471677] Reg 0634 = 0000
[56085.471694] Reg 0635 = 0000
[56085.471711] Reg 0636 = 0000
[56085.471728] Reg 0637 = 0000
[56085.471751] Reg 0656 = 0263
[56085.471780] Reg 0657 = 6300
[56085.471804] Reg 0658 = 0000
[56085.471829] Reg 0659 = 0000
[56085.471846] Reg 065a = 0000
[56085.471864] Reg 065b = 0000
[56085.471881] Reg 065c = 0000
[56085.471898] Reg 065d = 0000

I assume it's 0x658 that should hold the RPM value.

If you haven't solved it remotely by Monday, I'll email Nuvoton and
ask for that datasheet...

--Andy

>
> Thanks,
> Guenter
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
