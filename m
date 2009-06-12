From: tomaz.mertelj@guest.arnes.si
Date: Fri, 12 Jun 2009 14:46:21 +0000
Subject: [lm-sensors] =?UTF-8?Q?Re: [PATCH] hwmon: Add driver for VIA CPU
Message-Id: <20090612_144621_045117.tomaz.mertelj@guest.arnes.si>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Welte <HaraldWelte@viatech.com>, "Michael S. Zick" <lkml@morethan.org>
Cc: Jean Delvare <khali@linux-fr.org>, Tomaz Mertelj <tomaz.mertelj@guest.arnes.si>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

> > 
> > Ah, 25 degrees C is room temperature - real hard for the junction 
temperature
> > to be 25 degrees C with power applied; lacking an infinitely perfect 
heatsink.
> > 
> > Look for an "off by one" error in shifting or masking the value.
> 
> there is no shifting and the masking is 0xffffffff :)
> 
> it might be that the BIOS is doing something wrong when programming the
> calibration MSR's at early botoup.  I would need the contents of MSR 
> 0x1160 ... 0x116C as well as 0x1152 and 0x1153 to be able to determine 
that.
> 

This is what I get on VB7002.. vith C7-D cpu:


DEBNAS:/home# sensors

via-cputemp-isa-0000
Adapter: ISA adapter
Core 0:      +27.0 C 

DEBNAS:/home# for r in 0x1160 0x1161 0x1162 0x1163 0x1164 0x1165 0x1166 
0x1167
0x1168 0x1169 0x116a 0x116b 0x116c 0x1152 0x1153 ; do ./rdmsr $r ; done
MSR register 0x1160 => 08:04:98:10:b8:0b:6f:f4
MSR register 0x1161 => 08:04:98:10:b8:0a:8f:f4
MSR register 0x1162 => 08:04:98:10:b7:f7:7f:f4
MSR register 0x1163 => 08:04:98:10:b7:f1:1f:f4
MSR register 0x1164 => 08:04:98:10:b7:ee:cf:f4
MSR register 0x1165 => 08:04:98:10:b8:0b:4f:f4
MSR register 0x1166 => 08:04:98:10:b7:f7:7f:f4
MSR register 0x1167 => 08:04:98:10:b7:ef:8f:f4
MSR register 0x1168 => 08:04:98:10:b7:fc:3f:f4
MSR register 0x1169 => 08:04:98:10:b8:0d:6f:f4
MSR register 0x116a => 08:04:98:10:b7:f3:8f:f4
MSR register 0x116b => 08:04:98:10:b8:0b:bf:f4
MSR register 0x116c => 08:04:98:10:b8:00:6f:f4
MSR register 0x1152 => 08:04:98:10:b7:f2:2f:f4
MSR register 0x1153 => 08:04:98:10:b8:0b:3f:f4
DEBNAS:/home#


Tomaz Mertelj


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
