From: "Yu, Fenghua" <fenghua.yu@intel.com>
Date: Thu, 09 Jun 2011 21:01:22 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Further relax
Message-Id: <493994B35A117E4F832F97C4719C4C04012FEF5FC9@orsmsx505.amr.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <493994B35A117E4F832F97C4719C4C04011E3427A6@orsmsx505.amr.corp.intel.com>
In-Reply-To: <493994B35A117E4F832F97C4719C4C04011E3427A6@orsmsx505.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> -----Original Message-----
> From: Jean Delvare [mailto:khali@linux-fr.org]
> Sent: Thursday, June 09, 2011 1:19 AM
> To: Yu, Fenghua
> Cc: Guenter Roeck; lm-sensors@lm-sensors.org; Carsten Emde; R,
> Durgadoss
> Subject: Re: [PATCH] hwmon: (coretemp) Further relax temperature range
> checks
> 
> Hi Fenghua,
> 
> On Wed, 8 Jun 2011 18:01:12 -0700, Yu, Fenghua wrote:
> > > From: Jean Delvare [mailto:khali@linux-fr.org]
> > > Sent: Wednesday, June 08, 2011 2:31 AM
> > > To: Guenter Roeck
> > > Cc: lm-sensors@lm-sensors.org; Carsten Emde; Yu, Fenghua; R,
> Durgadoss
> > > Subject: Re: [PATCH] hwmon: (coretemp) Further relax temperature
> range
> > > checks
> > >
> > > I have investigated this a little further, and have questions /
> action
> > > items for Fenghua and Durgadoss (or anyone else at Intel...)
> > >
> > > The Software Developer's Manual says that MSR 1A2h has scope
> "Thread"
> > > for Nehalem, but scope "Unique" for Sandy Bridge.
> > >
> > > 1* "Unique" isn't a valid scope value for a Sandy Bridge MSR. It
> should
> > >    be one of "Package", "Core" or "Thread". "Unique" is only used
> for
> > >    Pentium 4 and Atom models. This should be fixed by whoever is
> > >    responsible for the document at Intel.
> > >
> > > 2* "Thread" seems wrong for Nehalem. Experience shows that thermal
> > >    sensors are per-core [1], so I would expect scope "Core" for
> > >    MSR_TEMPERATURE_TARGET. I would love to have confirmation from
> > >    someone at Intel, and documentation fixed if needs be.
> > >
> > > [1] See commit d883b9f0977269d519469da72faec6a7f72cb489,
> > >     "hwmon: (coretemp) Skip duplicate CPU entries".
> > >
> > > 3* Assuming that "Unique" becomes "Package" for Sandy Bridge, this
> can
> > >    mean two things: either the MSR was actually changed from
> > >    per-thread/core to per-package when Sandy Bridge was developed,
> or
> > >    it was already per-package in Nehalem and documentation is
> wrong. I
> > >    would love to have someone at Intel clarify this point, and
> > >    documentation fixed if needs be.
> > >
> > > 4* Regardless of the technically correct answer to point 3 above, I
> > >    have never seen any multi-core CPU supported by the coretemp
> driver
> > >    report different tjmax values for different cores. Did anyone
> ever
> > >    see this? If not, I would feel comfortable reading tjmax from
> > >    MSR_TEMPERATURE_TARGET only once per package for all models.
> This
> > >    would make driver initialization faster.
> >
> > I contacted SDM author and hardware architect.
> 
> Thanks a lot for doing this!
> 
> > Yes, the "Unique" term for Sandy Bridge is wrong. It should be
> "Thread" instead. Next SDM will fix this..
> 
> This would bring it in line with Nehalem. However this doesn't look
> right. Remember that IA32_THERM_STATUS (MSR 19Ch) has scope "Core", so
> IA32_TEMPERATURE_TARGET (MSR 1A2h) can't have scope "Thread", because
> you need to combine the values from both MSRs to return the current
> temperature. IA32_TEMPERATURE_TARGET must have a scope equal to or
> broader than the scope of IA32_THERM_STATUS, otherwise the computation
> is not possible. What do the SDM author and hardware architect have to
> say about this?
> 
> Furthermore, on Sandy Bridge, IA32_PACKAGE_THERM_STATUS (MSR 1B1h) has
> scope "Package" but it is a relative value (just as IA32_THERM_STATUS.)
> To what can it be relative, if there is no package-level Temperature
> Target available? For this reason I really believe that
> IA32_TEMPERATURE_TARGET (MSR 1A2h) has scope "Package" on Sandy Bridge.
> Again, I am curious what your contacts will have to say about this.
> 

Your argument is valid. Next SDM will change the scope to "Package" for SNB. The scope for Nehalem is still "Thread". I think they just want to keep it a quirk of legacy on Nehalem.

> > The interface was defined by in P4 as per thread. They believe there
> is no viable usage of setting different temp targets on siblings.
> > So one could say the architecture of per-thread interface is a quirk
> of legacy.
> >
> > And you can read the target temperature on one thread and it will
> apply to all cores in a package.
> 
> OK, great. I'll prepare a patch, I'll post it when I am done testing
> it.

I think we can work on the patch to view the package scope for this MSR. I believe you will add a comment to explain why we need this patch.

> 
> Thanks,
> --
> Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
