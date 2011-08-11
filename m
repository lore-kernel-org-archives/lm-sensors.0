From: Rajendra Nayak <rnayak@ti.com>
Date: Thu, 11 Aug 2011 14:37:22 +0000
Subject: Re: [lm-sensors] [RFC PATCH 6/6] hwmon: OMAP4: On die temperature
Message-Id: <4E43E652.5020303@ti.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1312979122-5896-1-git-send-email-j-keerthy@ti.com> <1312979122-5896-7-git-send-email-j-keerthy@ti.com> <20110810124629.GJ12882@legolas.emea.dhcp.ti.com> <CAJ6a13Z=u=exWUHLotw8jpHMv-hKpE+fvg_1hq7=gtMiuJKxOA@mail.gmail.com> <20110811103658.GG27742@legolas.emea.dhcp.ti.com> <CAJ6a13bxg8po-Csc10LsFH-oES4YOKkqFoTm3kG4XzS=b2boMw@mail.gmail.com> <20110811141248.GK28500@legolas.emea.dhcp.ti.com>
In-Reply-To: <20110811141248.GK28500@legolas.emea.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: balbi@ti.com
Cc: "J, KEERTHY" <j-keerthy@ti.com>, lm-sensors@lm-sensors.org, vishwanath.bs@ti.com, linux-omap@vger.kernel.org, b-cousson@ti.com, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, khali@linux-fr.org, guenter.roeck@ericsson.com

On 8/11/2011 7:42 PM, Felipe Balbi wrote:
> Hi,
>
> On Thu, Aug 11, 2011 at 06:30:04PM +0530, J, KEERTHY wrote:
>>>>>> >  >>  >>  diff --git a/drivers/hwmon/omap_temp_sensor.c b/drivers/hwmon/omap_temp_sensor.c
>>>>>> >  >>  >>  new file mode 100644
>>>>>> >  >>  >>  index 0000000..15e2559
>>>>>> >  >>  >>  --- /dev/null
>>>>>> >  >>  >>  +++ b/drivers/hwmon/omap_temp_sensor.c
>>>>>> >  >>  >>  @@ -0,0 +1,950 @@
>>>>>> >  >>  >>  +/*
>>>>>> >  >>  >>  + * OMAP4 Temperature sensor driver file
>>>>>> >  >>  >>  + *
>>>>>> >  >>  >>  + * Copyright (C) 2011 Texas Instruments Incorporated -http://www.ti.com/
>>>>>> >  >>  >>  + * Author: J Keerthy<j-keerthy@ti.com>
>>>>>> >  >>  >>  + * Author: Moiz Sonasath<m-sonasath@ti.com>
>>>>>> >  >>  >>  + *
>>>>>> >  >>  >>  + * This program is free software; you can redistribute it and/or
>>>>>> >  >>  >>  + * modify it under the terms of the GNU General Public License
>>>>>> >  >>  >>  + * version 2 as published by the Free Software Foundation.
>>>>>> >  >>  >>  + *
>>>>>> >  >>  >>  + * This program is distributed in the hope that it will be useful, but
>>>>>> >  >>  >>  + * WITHOUT ANY WARRANTY; without even the implied warranty of
>>>>>> >  >>  >>  + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>>>>>> >  >>  >>  + * General Public License for more details.
>>>>>> >  >>  >>  + *
>>>>>> >  >>  >>  + * You should have received a copy of the GNU General Public License
>>>>>> >  >>  >>  + * along with this program; if not, write to the Free Software
>>>>>> >  >>  >>  + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
>>>>>> >  >>  >>  + * 02110-1301 USA
>>>>>> >  >>  >>  + *
>>>>>> >  >>  >>  + */
>>>>>> >  >>  >>  +
>>>>>> >  >>  >>  +#include<linux/interrupt.h>
>>>>>> >  >>  >>  +#include<linux/clk.h>
>>>>> >  >>  >
>>>>> >  >>  >  why ??
>>>> >  >>
>>>> >  >>  Clock rate setting functions.
>>> >  >
>>> >  >  you shouldn't need in drivers.
>> >
>> >  It is a one time setting of the rate so keeping it in drivers.
> you need some other way to handle this. Why do you need to manually set
> the rate rather than having hwmod handle this for you ?

Because hwmod has not idea about what rate a device needs to operate
in any point.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
