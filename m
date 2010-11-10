From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 10 Nov 2010 15:42:35 +0000
Subject: Re: [lm-sensors] [PATCH 04/11] hwmon: applesmc: Introduce a
Message-Id: <20101110154235.GA31170@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1289315711-3011-1-git-send-email-rydberg@euromail.se>
 <1289315711-3011-5-git-send-email-rydberg@euromail.se>
 <1289329469.22931.221.camel@groeck-laptop>
 <4CD9A1DC.2000407@euromail.se>
 <1289336024.22931.243.camel@groeck-laptop>
 <4CDA7A94.7070302@euromail.se>
In-Reply-To: <4CDA7A94.7070302@euromail.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Nov 10, 2010 at 05:57:24AM -0500, Henrik Rydberg wrote:
> 
> >>
> >> mutex_destroy() is defined as a nop, so I guess the question is whether anything
> >> could be holding the lock when entering a second init. There are no sysfs files
> >> created at that point, so I would say no. The mutex could be put back with a
> >> static initializer, if this is not satisfactory. The real reason to move it to
> >> the smcreg struct was to force a rename of the mutex itself.
> >>
> > 
> > Alternatively, you could move the mutex initialization to the beginning
> > of applesmc_init_smcreg() and make it
> > 	mutex_init(&smcreg.mutex);
> 
> 
> Looking at this again, it seems there are two other problems as well. Firstly,
> the cache memory is not freed after probe failure, my apologies. Secondly,
> execution continues after a probe failure, and the initialization is retried. I
> would like to push the latter problem to some other occasion, since the whole
> platform logic should be rewritten for the new interface, anyways.
> 
I see the cache problem; this is indeed a tricky one, since it is actually not yet
a problem after this patch, but will be one after patch 5.

I don't understand the second problem, though. Looking into the code,
the probe function will return an error if applesmc_init_smcreg() fails.
Am I missing something ? What execution continues ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
