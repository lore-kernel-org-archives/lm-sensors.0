From: Andreas Werner <andreas.werner@men.de>
Date: Thu, 10 Dec 2015 18:09:28 +0000
Subject: Re: [lm-sensors] LM90 driver and ti tmp461 detection
Message-Id: <20151210180928.GC28022@awelinux>
List-Id: <lm-sensors.vger.kernel.org>
References: <20151210120856.GA27765@awelinux>
 <5669AB55.5030309@roeck-us.net>
 <20151210171231.GA28022@awelinux>
 <5669BB37.3050207@roeck-us.net>
In-Reply-To: <5669BB37.3050207@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Andreas Werner <andreas.werner@men.de>, linux-kernel@vger.kernel.org, jdelvare@suse.com, lm-sensors@lm-sensors.org, wni@nvidia.com

...
>On Thu, Dec 10, 2015 at 09:49:43AM -0800, Guenter Roeck wrote:
> >
> >I have a DT based board yes, but i have also planed to submit my changes
> >and also wanted to implement the autodetection of the chip.
> >
> >I have also planned (or need) to implement the "n-Factor Correction" for the
> >CPU diodes. There is a register to set this value in the tmp451 and tmp461.
> >Would that make sense to add a DT property for the driver to be able
> >to set this value? What do you think?
> >
> 
> See max6697.c for some examples. Maybe we can use similar bindings.
> 

Seems to be a good way. I think I will also add the extended mode selection
via DT.

> Guenter
> 

Regards
Andy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
