From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 05 Jun 2009 15:12:29 +0000
Subject: Re: [lm-sensors] hwmon-vid driver from linux 2.6.29
Message-Id: <20090605171229.5e557efb@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A0C6BF7.9010107@assembler.cz>
In-Reply-To: <4A0C6BF7.9010107@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hleb,

On Thu, 14 May 2009 22:14:36 +0300, Hleb Valoshka wrote:
> Vendor ID: "AuthenticAMD"; CPUID level 1
> 
> AMD-specific functions
> Version 00060fb1:
> Family: 15 Model: 11 []

This is a BH-G1 core, family 0Fh, it does have 6 VID pins, so VRM
version "25" (in hwmon-vid's terms) is correct. Is it the value
returned in /sys/bus/platform/devices/it87.552/vrm? I suppose the value
returned in that file in kernel 2.6.26 was "24" instead?

> >> Module hwmon_vid (drivers/hwmon/hwmon-vid.c) from linux-2.6.29(.3) returns
> >>
> >> incorrect voltage for my CPU from it8716f sensor (real/2).
> >> With module from 2.6.26 voltage is correct.

What was the voltage value before, and what is it now?

> >> Code changed between versions:
> >>
> >>  int vid_from_reg(int val, u8 vrm)
> >>  {
> >>         int vid;
> >> @@ -96,9 +102,16 @@
> >>                 if (val < 0x02 || val > 0xb2)
> >>                         return 0;
> >>                 return((1600000 - (val - 2) * 6250 + 500) / 1000);
> >> -       case 24:                /* Opteron processor */
> >> +
> >> +       case 24:                /* Athlon64 & Opteron */
> >>                 val &= 0x1f;
> >> -               return(val = 0x1f ? 0 : 1550 - val * 25);
> >> +               if (val = 0x1f)
> >> +                       return 0;
> >> +                               /* fall through */
> >> +       case 25:                /* AMD NPT 0Fh */
> >> +               val &= 0x3f;
> >> +               return (val < 32) ? 1550 - 25 * val
> >> +                       : 775 - (25 * (val - 31)) / 2;
> >>
> >> May be you should revert old code.
> >>
> >> My CPU is AMD BE-2350 stepping 01. IT87 sensor: IT8716F chip at 0x228,
> >> revision 0.

The hwmon-vid code looks correct, and I think you are the first person
complaining since the code was changed (while we did have success
reports.) It could be that VID5 pin is not properly wired on your
system. Or a bug in the it87 driver.

Please provide a dump of your IT8716F chip:

isadump 0x22d 0x22e

As well as a dump of the Super-I/O config space:

isadump -k 0x87,0x01,0x55,0x55 0x2e 0x2f 4

Also, if you use the powernow-k8 driver, it should print the available
VIDs when the driver is loaded, please report what the driver says.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
