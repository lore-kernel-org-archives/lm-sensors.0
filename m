From: Andreas Werner <andreas.werner@men.de>
Date: Thu, 10 Dec 2015 18:03:14 +0000
Subject: Re: [lm-sensors] LM90 driver and ti tmp461 detection
Message-Id: <20151210180314.GB28022@awelinux>
List-Id: <lm-sensors.vger.kernel.org>
References: <20151210120856.GA27765@awelinux>
 <5669AB55.5030309@roeck-us.net>
 <20151210171231.GA28022@awelinux>
 <5669B9D9.9050908@roeck-us.net>
In-Reply-To: <5669B9D9.9050908@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Andreas Werner <andreas.werner@men.de>, linux-kernel@vger.kernel.org, jdelvare@suse.com, lm-sensors@lm-sensors.org, wni@nvidia.com

...
> On Thu, Dec 10, 2015 at 09:43:53AM -0800, Guenter Roeck wrote:
> >
> >There is one difference. The temperature ranges differ:
> >
> >TMP451:
> >Standard Mode: 0 to +127
> >Extended Mode: -64 to +191
> >
> >TMP461:
> >Standard Mode: -40 to +127
> >Extended Mode: -64 to +191
> >
> >Therefore the calcualtion is different then the tmp451 one.
> >
> Not really. The tmp451 will return 0 for negative temperatures in standard mode,
> the tmp461 will return negative (signed) values. Temperatures are stored
> as signed values, so the code should be ok as is. Am I missing something ?
> 

It will work to read the local and external temperature yes, but not
for setting the temperatur.
If setting in standard mode, the tmp451 part fix the value to 0-127
but for the tmp461 we have -40 to 127.

I'v currently no chip here in the office to test it, hopefully I will
get one next week.

> >I also aggree with you with the magical ID register. I hate such
> >kind of register with are not documented and may have a value.
> >
> >I have a DT based board yes, but i have also planed to submit my changes
> >and also wanted to implement the autodetection of the chip.
> 
> I don't think auto-detection (other than handling the chip as tmp451)
> will be possible, but I am looking forward to seeing your patch(es).
> 

Yes, i think autodetection makes it very crapy. May be i will find
another solution.

> >
> >I have also planned (or need) to implement the "n-Factor Correction" for the
> >CPU diodes. There is a register to set this value in the tmp451 and tmp461.
> >Would that make sense to add a DT property for the driver to be able
> >to set this value? What do you think?
> >
> Yes, since this is a board (hardware) property. Other chips have similar
> registers. We'll just have to find a good set of property names and descriptions.
> 

Ok, I will find a way to do it :-)

> Thanks,
> Guenter
> 

Regards
Andy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
