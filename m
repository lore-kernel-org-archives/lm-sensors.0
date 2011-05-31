From: "Yu, Fenghua" <fenghua.yu@intel.com>
Date: Tue, 31 May 2011 22:56:11 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Relax target temperature
Message-Id: <493994B35A117E4F832F97C4719C4C04011E342190@orsmsx505.amr.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110531215051.663df5ef@endymion.delvare>
In-Reply-To: <20110531215051.663df5ef@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> -----Original Message-----
> From: Guenter Roeck [mailto:guenter.roeck@ericsson.com]
> Sent: Tuesday, May 31, 2011 3:17 PM
> To: Yu, Fenghua
> Cc: Jean Delvare; LM Sensors; Carsten Emde
> Subject: RE: [lm-sensors] [PATCH] hwmon: (coretemp) Relax target
> temperature range check
> 
> On Tue, 2011-05-31 at 17:39 -0400, Yu, Fenghua wrote:
> > > -----Original Message-----
> > > From: Guenter Roeck [mailto:guenter.roeck@ericsson.com]
> > > Sent: Tuesday, May 31, 2011 1:29 PM
> > > To: Jean Delvare
> > > Cc: LM Sensors; Yu, Fenghua; Carsten Emde
> > > Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Relax target
> > > temperature range check
> > >
> > > On Tue, 2011-05-31 at 15:50 -0400, Jean Delvare wrote:
> > > > The current temperature range check of
> MSR_IA32_TEMPERATURE_TARGET
> > > > seems too strict to me, some TjMax values documented in
> > > > Documentation/hwmon/coretemp wouldn't pass. Relax the check so
> that
> > > > all the documented values pass.
> > > >
> > > Maybe the reason is that the processors which support reading TjMax
> via
> > > the register are all in the 80 .. 120 range. Who knows -
> unfortunately,
> > > a simple table describing which processor supports which set of
> > > registers does not seem to exist, or at least I was unable to find
> it.
> > >
> > > > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > > > Cc: Carsten Emde <C.Emde@osadl.org>
> > > > Cc: Fenghua Yu <fenghua.yu@intel.com>
> > >
> > > > ---
> > > > I'm not even sure why we need to check the range. Why would the
> > > > value read from the MSR be wrong?
> > >
> > > If I understand correctly, some processors support the register but
> not
> > > the TjMax value in bits 16..23. Here is an exchange about it:
> > >
> > > http://www.tomshardware.com/forum/230079-29-intel-tjunction-mean
> >
> > I couldn't find " some processors support the register but not
> > the TjMax value in bits 16..23" in the above site.
> 
> Not directly, but it says:
> 
> "Note Tj is not a fixed value and the IA32_TEMPERATURE_TARGET[15:8]
> value can vary from part to part. Tj is also not software readable."
> 

"vary from model to model" would be more accurate, I think. But again this kind of words and info may not be accurate or misleading and shouldn't be used for our coding.

> which, as I read it, seems to imply that TjMax is not returned when
> reading IA32_TEMPERATURE_TARGET on the CPUs mentioned in the article.
> 
> > Even if there is such hint in the site, I wouldn't use it as a
> reference for coding. Our coding needs to base on official Intel
> specifications.
> >
> Agreed, if one is available...
> 
> > I check the SDM about the MSR_TEMPERATURE_TARGET register. My
> understanding is if the MSR is implemented, its bits 16..23 have the
> Temperature Target. Otherwise it's a hardware bug.
> >
> > There is no spec for the Temperature Target range in SDM (can you
> find one?). Whatever range we put in coretemp is just speculation.
> Strictly speaking, we shouldn't have the range check.
> >
> I'd be somewhat hesitant to make such a change right away. Maybe we can
> replace the check with a check against 0 and display a warning (or even
> an error) if it reads 0. Would that make sense ?

After a CPU model comes out, the number of Temperature Target is fixed for whatever value. If that value doesn't meet design spec, it could be:
1. a design issue which should be detected and fixed during internal design validation;
2. a manufacture issue which should be detected and fixed during manufacture process.

There is no spec to claim 0 is wrong for bits 16..23. Check against 0 is still a speculation. If checking against 0, why not check against 1, 2, etc?

Without any spec guidline, a sanity checking on the bits is trying to capture either a hardware design bug or a hardware manufacture bug. This is not based on any spec. And the effort is very likely fruitless.

A lot of similar places in kernel don't do sanity checking, e.g. bits 0..15 in MSR_IA32_PERF_STATUS.

Thanks.

-Fenghua
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
