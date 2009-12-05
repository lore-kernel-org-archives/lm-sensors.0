From: Adam Nielsen <a.nielsen@shikadi.net>
Date: Sat, 05 Dec 2009 02:14:45 +0000
Subject: Re: [lm-sensors] Drivers/motherboards with wattage & amperage
Message-Id: <4B19C215.1030404@shikadi.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <9871ee5f0912041515o5cebdb20sb00a241df1bf5ca9@mail.gmail.com>
In-Reply-To: <9871ee5f0912041515o5cebdb20sb00a241df1bf5ca9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Some colleagues of mine are doing some experiments where they would
> like to monitor power and current of different system components in
> real time while running various HPC workloads.  They're willing to buy
> whatever kind of motherboards they need that provide the sensors they
> need.  They're aware that, for instance, Apple computers provide all
> these sensors, but buying a cluster of MacBook Pros would be too
> expensive.
>
> Can anyone recommend a motherboard with these sensors that are
> supported by lm_sensors?

I don't think there are any motherboards that have wattage sensors, but there 
are power supplies that can report these figures (e.g. over USB.)

See http://www.nvidia.com/object/nvidia_esa.html for a few.  I don't know 
whether there is Linux support for ESA yet, but the standard appears to be 
open.  I did ask nVidia for a copy but never heard back though :-(

Cheers,
Adam.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
