From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 18 Dec 2007 17:39:25 +0000
Subject: Re: [lm-sensors] Working on adt7475 driver
Message-Id: <20071218183925.56e951ac@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4705F127.8010600@hhs.nl>
In-Reply-To: <4705F127.8010600@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Tue, 18 Dec 2007 11:24:04 +0100, Hans de Goede wrote:
> I'm afraid that the motherboard used by the student has broken down somehow, so 
> they can no longer continue their work. I've attached their latest wip, perhaps 
> that can come in handy for you when working on a driver. The motherboard has 
> been send in for repair once it returns I can use it for testing your work.

Please update wiki/Devices accordingly.

> /* 
>  *  New merged Fujitsu Siemens hwmon driver, supporting the Poseidon, Hermes,
>  *  Scylla, Hercules and Heimdall chips
>  *
>  *  Based on the original 2.4 fscscy, 2.6 fscpos, 2.6 fscher and 2.6
>  *  (candidate) fschmd drivers:
>  *  Copyright (C) 2006 Thilo Cestonaro <thilo.cestonaro.external@fujitsu-siemens.com>
>  *  Copyright (C) 2003, 2004 Reinhard Nissl <rnissl@gmx.de>
>  *  Copyright (C) 2000 Hermann Jung <hej@odn.de>
>  *  Copyright (C) 1998, 1999 Frodo Looijaard <frodol@dds.nl>
>  *  and Philip Edelbrock <phil@netroedge.com>
>  */

This part looks completely bogus to me.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
