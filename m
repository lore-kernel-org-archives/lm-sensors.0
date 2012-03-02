From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 02 Mar 2012 20:02:44 +0000
Subject: Re: [lm-sensors] [PATCH v2 3/4] hwmon: (f75375s) Properly map the F75387 automatic modes to pwm_enab
Message-Id: <1330718564.23014.309.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1330463755-5763-4-git-send-email-mail@microschulz.de>
In-Reply-To: <1330463755-5763-4-git-send-email-mail@microschulz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 2012-03-02 at 14:47 -0500, Nikolaus Schulz wrote:
[ ... ]

> > > 
> > > Given my reasoning above, I consider this more a fix of seriously broken
> > > functionality, rather than an addition of new functionality.  We simply
> > > cannot ignore the automatic pwm mode, because it might already be
> > > enabled by the BIOS.  The board I use for testing does so, for example.
> > > 
> > > So I really think this should go into v3.3.
> > > 
> > > However, it might make sense to split out the inhibiting of switches
> > > between open and closed loop modes.
> > > 
> > That is why I suggested to split the patch into two parts. I don't mind
> > a fix for pwm_mode=3, limiting its scope. My concern is that pwm_mode=4
> > adds functionality which I would prefer to delay until 3.4.
> 
> Well, as I have said, this functionality may already be activated by the
> BIOS.  The driver has to deal with it, right?  It's not so much a matter
> of supporting something, but a matter of not messing it up.
> 
Hmm - good point. I'll accept that. I'll add your reasoning to the patch
description and apply it to 3.3.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
