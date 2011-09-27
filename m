From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 27 Sep 2011 13:05:07 +0000
Subject: Re: [lm-sensors] [PATCH v3 1/2] hwmon: (coretemp) Don't use
Message-Id: <20110927150507.4d767a83@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1316536503-26883-2-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1316536503-26883-2-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

Sorry for the late reply.

On Wed, 21 Sep 2011 14:28:18 -0700, Guenter Roeck wrote:
> On Wed, Sep 21, 2011 at 05:01:58PM -0400, Jean Delvare wrote:
> > On Wed, 21 Sep 2011 13:35:28 -0700, Guenter Roeck wrote:
> > > Not sure about discarding the value either. If we drop the attribute if
> > > ttarget is 0, people will wonder where tempX_max disappeared to. Worst
> > > case tempX_max will show up at the same temperature as tempX_crit, so we
> > > would know (or learn) about it and users would still have the attribute
> > > available.
> > 
> > This is a read-only value, there's no point in making it "available" if
> > the value is known to be wrong.
>
> But how do we know that or if a reading of 0 would be wrong ? Or a reading
> larger than X ?

I'm not quite sure what your concern is. I never talked about filtering
large register values (which would mean low ttarget temperatures -
remember that ttarget = tjmax - register). All my proposal is about is
filtering register value of 0, because it means ttarget = tjmax, which
in turn means that the supposed effect of t > ttarget (all fans forced
to full speed) as no chance to happen because the CPU dies or stops at
tjmax. The only reason why I propose this is because the bits in
question are undocumented, so we can't rule out that there are models
out there which do support the MSR in general but don't implement the
specific bits.

Anyway, I'll propose a patch, maybe it will make my intents clearer.

> > Here again, I'm fine if your patch doesn't include that change, after
> > all you're mainly reverting to pre 3.0 behavior so it makes sense to
> > stick to what we had before for now. I can submit patches for the
> > proposed changes later, and we can discuss them again then.
>
> Let's do it that way. I really want to limit the changes to 3.1
> at this point - we are a bit too close to release for my liking.

Agreed. But anyway, with kernel.org being MIA for so long, this release
cycle is nothing I like to start with.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
