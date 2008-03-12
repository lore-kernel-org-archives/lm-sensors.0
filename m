From: Helmut Grohne <helmut@subdivi.de>
Date: Wed, 12 Mar 2008 13:17:01 +0000
Subject: Re: [lm-sensors] serious w83627ehf problem stopping cpu fan
Message-Id: <20080312131701.GA6772@alf.mars>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080312011430.GA20751@alf.mars>
In-Reply-To: <20080312011430.GA20751@alf.mars>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

> > The only thing I really need now is a stable cpu fan. Can I somehow lock
> > it to maximum speed or something similar? Can I somehow run w83627ehf
> If you disable Q-Fan in the BIOS, that's what should happen.

Ok.

> Did you try without the w83627ehf driver loaded? What makes you believe
> that the w83627ehf driver is responsible for your problem? This might
> as well be an ACPI issue.

I did not try unloading the driver permanently, because this would
effectively prevent me from monitoring temperature and fan speed and
would therefore not notice a temperature increase.

There are two things that made me believe w83627ehf is responsible:
1) It is possible to change the fan behaviour using this driver.
2) This is very unreliable. (see below)

I did not think about this having to do with ACPI, but it sounds
reasonable. Compiling dsdt.dsl again results in tons of errors (below).

> >         echo 255 > pwm2
> Note that the value written to pwm2 has no effect when pwm2_enable = 2,
> so there's nothing you can hope from this step.

Even with pwm2_enable = 1 the setting often does not change
(nondeterministically). That's the reason for doing these echos in a
loop: Hoping that a value will eventually change.

> >         echo 1000 > pwm2_target
> This is setting the target temperature to 1 degree C. That doesn't make
> any sense to me, as there is the way the chip can achieve this. On top
> of that, this setting is only valid fir pwm2_enable = 2, which isn't
> the case at this point.

What makes even less sense is taht pwm2_target only accepts two values:
1000 and 127000. Other values I tried simply do not change the contents
of the file.

Theoretically the fan should stop after the following.
echo 1 > pwm2_enable
echo 0 > pwm2

This works only in very rare occasions. Values written to pwm2 seem to
only sometimes change the value.

Helmut

root@# iasl -tc dsdt.dsl
Intel ACPI Component Architecture
ASL Optimizing Compiler version 20061109 [May 15 2007]
Copyright (C) 2000 - 2006 Intel Corporation
Supports ACPI Specification Revision 3.0a

dsdt.dsl   410:     Method (\_WAK, 1, NotSerialized)
Warning  1079 -                 ^ Reserved method must return a value (_WAK)

dsdt.dsl   452:             Store (Local0, Local0)
Error    4049 -                         ^ Method local variable is not initialized (Local0)

dsdt.dsl   460:             Store (Local0, Local0)
Error    4049 -                         ^ Method local variable is not initialized (Local0)

dsdt.dsl   786:                 Method (GHTF, 0, NotSerialized)
Warning  1086 -                            ^ Not all control paths return a value (GHTF)

dsdt.dsl  1697:                         Store (Local0, Local0)
Error    4049 -                                     ^ Method local variable is not initialized (Local0)

dsdt.dsl  1702:                         Store (Local0, Local0)
Error    4049 -                                     ^ Method local variable is not initialized (Local0)

dsdt.dsl  1707:                         Store (Local0, Local0)
Error    4049 -                                     ^ Method local variable is not initialized (Local0)

dsdt.dsl  2198:                 Method (STM, 0, Serialized)
Warning  1086 -                           ^ Not all control paths return a value (STM_)

dsdt.dsl  2757:                 Method (STM, 0, Serialized)
Warning  1086 -                           ^ Not all control paths return a value (STM_)

dsdt.dsl  3864:                 Method (RVLT, 1, NotSerialized)
Warning  1086 -                            ^ Not all control paths return a value (RVLT)

dsdt.dsl  3934:                 Method (RTMP, 1, NotSerialized)
Warning  1086 -                            ^ Not all control paths return a value (RTMP)

dsdt.dsl  4111:                     Store (GHTF (), Local1)
Warning  1091 -                               ^ Called method may not always return a value

dsdt.dsl  4156:                 Method (OCOP, 1, NotSerialized)
Warning  1086 -                            ^ Not all control paths return a value (OCOP)

dsdt.dsl  4182:                             Store (GHTF (), Local1)
Warning  1091 -                                       ^ Called method may not always return a value

dsdt.dsl  5963:                 Method (_STA, 0, NotSerialized)
Warning  1086 -                            ^ Not all control paths return a value (_STA)

dsdt.dsl  5963:                 Method (_STA, 0, NotSerialized)
Warning  1079 -                            ^ Reserved method must return a value (_STA)

dsdt.dsl  6035:                 Method (_PRS, 0, NotSerialized)
Warning  1086 -                            ^ Not all control paths return a value (_PRS)

dsdt.dsl  6035:                 Method (_PRS, 0, NotSerialized)
Warning  1079 -                            ^ Reserved method must return a value (_PRS)

dsdt.dsl  6111:                 Method (_STA, 0, NotSerialized)
Warning  1086 -                            ^ Not all control paths return a value (_STA)

dsdt.dsl  6111:                 Method (_STA, 0, NotSerialized)
Warning  1079 -                            ^ Reserved method must return a value (_STA)

dsdt.dsl  6166:                 Method (_PRS, 0, NotSerialized)
Warning  1086 -                            ^ Not all control paths return a value (_PRS)

dsdt.dsl  6166:                 Method (_PRS, 0, NotSerialized)
Warning  1079 -                            ^ Reserved method must return a value (_PRS)

dsdt.dsl  6293:                 Method (_PRS, 0, NotSerialized)
Warning  1086 -                            ^ Not all control paths return a value (_PRS)

dsdt.dsl  6293:                 Method (_PRS, 0, NotSerialized)
Warning  1079 -                            ^ Reserved method must return a value (_PRS)

dsdt.dsl  6429:                 Method (_PRS, 0, NotSerialized)
Warning  1086 -                            ^ Not all control paths return a value (_PRS)

dsdt.dsl  6429:                 Method (_PRS, 0, NotSerialized)
Warning  1079 -                            ^ Reserved method must return a value (_PRS)

dsdt.dsl  6475:                 Method (_CRS, 0, NotSerialized)
Warning  1086 -                            ^ Not all control paths return a value (_CRS)

dsdt.dsl  6475:                 Method (_CRS, 0, NotSerialized)
Warning  1079 -                            ^ Reserved method must return a value (_CRS)

ASL Input:  dsdt.dsl - 8614 lines, 278641 bytes, 3542 keywords
Compilation complete. 5 Errors, 23 Warnings, 0 Remarks, 1099 Optimizations
root@#

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
