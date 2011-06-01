From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 01 Jun 2011 20:18:07 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Relax target temperature
Message-Id: <20110601221807.341a2d41@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110531215051.663df5ef@endymion.delvare>
In-Reply-To: <20110531215051.663df5ef@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 1 Jun 2011 09:12:11 -0700, Guenter Roeck wrote:
> On Wed, 2011-06-01 at 05:40 -0400, Jean Delvare wrote:
> > I would be perfectly happy to not have any sanity check on the value,
> > but this requires that we know upfront which CPU models have bits 23:16
> > of MSR 0x1a2 implemented, and which do not. As my experiment above
> > shows, some models have the MSR implemented but not bits 23:16, and
> > checking for value 0 is the only way to handle them in a generic way.
> > 
> > According to the SDM, MSR 0x1a2 is supposed to only exist in Nehalem
> > (i.e. family 6 model 0x1a) and Sandy Bridge CPUs (family and model
> > unknown to me) but I guess it will also exist in future CPUs.
> > 
> > I see two possible implementations:
> > 
> > 1* Go by the SDM. First check that we are on a model which supports
> > MSR_TEMPERATURE_TARGET before calling it, and always trust the result.
> > For other models, use the heuristic we had before (adjust_tjmax). The
> > major drawback is that we will have to update the list of CPU models
> > supporting MSR_TEMPERATURE_TARGET as they are released by Intel. We
> > just went away from having to continuously maintain a device list in
> > the coretemp driver and it seems wrong to go back to this situation
> > again.
> > 
> > 2* Go by my experimental result. Read MSR_TEMPERATURE_TARGET
> > unconditionally, but only use the result if there was no I/O error and
> > the value isn't 0. In other cases, don't emit any warning message and
> > simply fallback to the heuristic we had before (adjust_tjmax). This is
> > closer to what we have at the moment, and has the advantage that it
> > won't require further updates.
> > 
> > Implementation 2 clearly has my favors.
> > 
> Definitely. 1* doesn't look like very compelling.
> 
> > For stable kernel series, I'd rather just apply the patch I submitted,
> > because it is the least intrusive option and we aren't aware of any
> > actual system requiring a more intrusive fix.
>
> Do we really want/need this in -stable ? Just wondering. 

In all honesty, I don't know. I did not have any bug report, but if
someone were to hit that one, all they would get is a wrong TjMax,
that's not necessarily something people will notice.

In fact it depends when MSR_TEMPERATURE_TARGET started reporting valid
values in bits 23:16. I know models 0xe, 0xf and 0x1c do not, but I am
unsure about 0x16 and 0x17 (for which we know some models have TjMax
outside the original range check.) Officially supported started with
Nehalem but you never know...

Also, I can only suppose that bits 23:16 of the MSR will be supported
by all Intel CPUs moving forward, and it seems reasonable to imagine
that at least one model will get outside the current check at some
point in the future (if it isn't already the case.) Pushing the fix to
stable now would anticipate this. Best would be to find an actual CPU
model affected by the bug, but I don't have one at hand and finding one
would take much time, which I suspect would be better spent differently.

> We do need the second part of 2*, ie unconditionally calling
> adjust_tjmax().

Yes we do.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
