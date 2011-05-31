From: "Yu, Fenghua" <fenghua.yu@intel.com>
Date: Tue, 31 May 2011 21:39:02 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Relax target temperature
Message-Id: <493994B35A117E4F832F97C4719C4C04011E34209F@orsmsx505.amr.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110531215051.663df5ef@endymion.delvare>
In-Reply-To: <20110531215051.663df5ef@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> -----Original Message-----
> From: Guenter Roeck [mailto:guenter.roeck@ericsson.com]
> Sent: Tuesday, May 31, 2011 1:29 PM
> To: Jean Delvare
> Cc: LM Sensors; Yu, Fenghua; Carsten Emde
> Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Relax target
> temperature range check
> 
> On Tue, 2011-05-31 at 15:50 -0400, Jean Delvare wrote:
> > The current temperature range check of MSR_IA32_TEMPERATURE_TARGET
> > seems too strict to me, some TjMax values documented in
> > Documentation/hwmon/coretemp wouldn't pass. Relax the check so that
> > all the documented values pass.
> >
> Maybe the reason is that the processors which support reading TjMax via
> the register are all in the 80 .. 120 range. Who knows - unfortunately,
> a simple table describing which processor supports which set of
> registers does not seem to exist, or at least I was unable to find it.
> 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > Cc: Carsten Emde <C.Emde@osadl.org>
> > Cc: Fenghua Yu <fenghua.yu@intel.com>
> 
> > ---
> > I'm not even sure why we need to check the range. Why would the
> > value read from the MSR be wrong?
> 
> If I understand correctly, some processors support the register but not
> the TjMax value in bits 16..23. Here is an exchange about it:
> 
> http://www.tomshardware.com/forum/230079-29-intel-tjunction-mean

I couldn't find " some processors support the register but not
the TjMax value in bits 16..23" in the above site.

Even if there is such hint in the site, I wouldn't use it as a reference for coding. Our coding needs to base on official Intel specifications.

I check the SDM about the MSR_TEMPERATURE_TARGET register. My understanding is if the MSR is implemented, its bits 16..23 have the Temperature Target. Otherwise it's a hardware bug.

There is no spec for the Temperature Target range in SDM (can you find one?). Whatever range we put in coretemp is just speculation. Strictly speaking, we shouldn't have the range check.

Thanks.

-Fenghua


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
