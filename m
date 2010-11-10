From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 10 Nov 2010 17:57:41 +0000
Subject: Re: [lm-sensors] [PATCH 04/11] hwmon: applesmc: Introduce a
Message-Id: <20101110175741.GB18472@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1289315711-3011-1-git-send-email-rydberg@euromail.se>
 <1289315711-3011-5-git-send-email-rydberg@euromail.se>
 <1289329469.22931.221.camel@groeck-laptop>
 <4CD9A1DC.2000407@euromail.se>
 <1289336024.22931.243.camel@groeck-laptop>
 <4CDA7A94.7070302@euromail.se>
 <20101110154235.GA31170@ericsson.com>
 <4CDAD2FE.3020506@euromail.se>
In-Reply-To: <4CDAD2FE.3020506@euromail.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Nov 10, 2010 at 12:14:38PM -0500, Henrik Rydberg wrote:
> >>
> 
> >> Looking at this again, it seems there are two other problems as well. Firstly,
> >> the cache memory is not freed after probe failure, my apologies. Secondly,
> >> execution continues after a probe failure, and the initialization is retried. I
> >> would like to push the latter problem to some other occasion, since the whole
> >> platform logic should be rewritten for the new interface, anyways.
> >>
> > I see the cache problem; this is indeed a tricky one, since it is actually not yet
> > a problem after this patch, but will be one after patch 5.
> > 
> > I don't understand the second problem, though. Looking into the code,
> > the probe function will return an error if applesmc_init_smcreg() fails.
> > Am I missing something ? What execution continues ?
> 
> 
> I think drivers/base/dd.c:142 shows the problem clearly. Basically, the probe
> function is supposed to do the proper initialization, if successful. The driver
> code has been rewritten heavily since the days of the applesmc, and the actual
> probe error is now masked in a rather ugly fashion to allow the driver matching
> to continue. It seems to me that the only clean way around this is to actually
> implement the correct platform driver logic.
> 
Ok, guess there is nothing we can do about that. I'll apply the rest of your series.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
