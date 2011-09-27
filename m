From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 27 Sep 2011 14:04:03 +0000
Subject: Re: [lm-sensors] [PATCH v3 1/2] hwmon: (coretemp) Don't use
Message-Id: <20110927160403.239a3baf@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1316536503-26883-2-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1316536503-26883-2-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 27 Sep 2011 06:50:14 -0700, Guenter Roeck wrote:
> On Tue, Sep 27, 2011 at 09:05:07AM -0400, Jean Delvare wrote:
> > On Wed, 21 Sep 2011 14:28:18 -0700, Guenter Roeck wrote:
> > > But how do we know that or if a reading of 0 would be wrong ? Or a reading
> > > larger than X ?
> > 
> > I'm not quite sure what your concern is. I never talked about filtering
> > large register values (which would mean low ttarget temperatures -
> > remember that ttarget = tjmax - register). All my proposal is about is
> > filtering register value of 0, because it means ttarget = tjmax, which
> > in turn means that the supposed effect of t > ttarget (all fans forced
> > to full speed) as no chance to happen because the CPU dies or stops at
> > tjmax. The only reason why I propose this is because the bits in
> > question are undocumented, so we can't rule out that there are models
> > out there which do support the MSR in general but don't implement the
> > specific bits.
>
> A value of 1 doesn't make much sense either, since t > ttarget means that the
> temperature already reached tjmax, and the CPU is just as dead. And a value of,
> say, 100 doesn't make sense either. So declaring that "0" is invalid but all
> other values are valid is pretty much arbitrary, as would any other limits.
> So why bother trying to declare what is valid and what isn't.

This is all based on the assumption that unused MSR bits read back 0.
An assumption which seems to correlate with the real world pretty well.

> > Anyway, I'll propose a patch, maybe it will make my intents clearer.
>
> I am actually ok with adding it in. I just would not bother myself.

Fine then, I'll do it.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
