From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 02 Nov 2012 03:20:57 +0000
Subject: Re: [lm-sensors] f71882fg not showing motherboard temps
Message-Id: <20121102032057.GA9162@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <5091A80D.3090101@embarqmail.com>
In-Reply-To: <5091A80D.3090101@embarqmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On Thu, Nov 01, 2012 at 01:34:35PM -0400, Logan Freijo wrote:

[ ... ]

> >
> After my last reply I searched the web again and noticed that some
> places indicate "acpi-enforce-resources=lax" and others
> "acpi_enforce_resources=lax". So I decided to try all options again.
> I found after several reboots that "pnpacpi=off" did when I passed
> it by itself. I now have a full range of sensor readings. Is there

Would be great if you can provide the logs Hans asked for.

> anyway to determine which sensor is which? My output for sensors is
> below. in1 - in6 seem to be reading incorrect values.
> 
Not incorrect - simple reason is that there are voltage dividers on the board.
Tricky part now is to find out what the divider values are. A good starting point
is http://www.lm-sensors.org/wiki/VoltageLabelsAndScaling.

Thanks,
Guenter

> Thanks,
> 
> Logan
> 
> f71882fg-isa-0220
> Adapter: ISA adapter
> +3.3V:        +3.50 V
> in1:          +1.06 V  (max =  +2.04 V)
> in2:          +0.42 V
> in3:          +0.98 V
> in4:          +1.13 V
> in5:          +0.96 V
> in6:          +0.75 V
> 3VSB:         +3.31 V
> Vbat:         +3.33 V
> fan1:        1492 RPM
> fan2:           0 RPM  ALARM
> fan3:        1007 RPM
> fan4:           0 RPM  ALARM
> temp1:        +33.0 C  (high = +85.0 C, hyst = +81.0 C)
>                        (crit = +100.0 C, hyst = +96.0 C)  sensor > transistor
> temp2:        +32.0 C  (high = +85.0 C, hyst = +81.0 C)
>                        (crit = +100.0 C, hyst = +96.0 C)  sensor > transistor
> temp3:        +32.0 C  (high = +70.0 C, hyst = +68.0 C)
>                        (crit = +85.0 C, hyst = +83.0 C)  sensor > transistor
> 
> k10temp-pci-00c3
> Adapter: PCI adapter
> CPU Temp:     +26.1 C  (high = +70.0 C)
> 
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
