From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 08 Jun 2011 18:32:40 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Further relax
Message-Id: <20110608203240.7bed7aed@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <493994B35A117E4F832F97C4719C4C04011E3427A6@orsmsx505.amr.corp.intel.com>
In-Reply-To: <493994B35A117E4F832F97C4719C4C04011E3427A6@orsmsx505.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Fenghua,

On Wed, 8 Jun 2011 09:45:03 -0700, Yu, Fenghua wrote:
> > -----Original Message-----
> > From: R, Durgadoss
> > Sent: Wednesday, June 08, 2011 3:06 AM
> > To: Jean Delvare; Guenter Roeck
> > Cc: lm-sensors@lm-sensors.org; Carsten Emde; Yu, Fenghua
> > Subject: RE: [PATCH] hwmon: (coretemp) Further relax temperature range
> > checks
> > 
> > Hi Jean,
> > 
> > > 4* Regardless of the technically correct answer to point 3 above, I
> > >    have never seen any multi-core CPU supported by the coretemp driver
> > >    report different tjmax values for different cores. Did anyone ever
> > >    see this? If not, I would feel comfortable reading tjmax from
> > >    MSR_TEMPERATURE_TARGET only once per package for all models. This
> > >    would make driver initialization faster.
> > >
> > 
> > When I tested in 3 of my machines, it did not Show different TjMax.
> > So, I agree that we should have the TjMax per package.
> 
> According to SDM, MSR_TEMPERATURE_TARGET scope is thread. Reading it per package is not correct.

As I explained in my original post, the SDM says something different
for Nehalem (scope thread) and Sandy Bridge (unique/package scope).
This is what I would like to see clarified. Please refer to my
questions in the original post.

Plus, we already don't follow the SDM to the letter, as we currently
read TjMax per core, rather than per thread. Which makes sense given
that MSR 19Ch (temperature measurement) is described as having scope
core. Obviously it makes no sense to have per-thread limits and
per-core measurements. In fact it is not even possible, as the
measurements are relative to the limit. So, the SDM is wrong with
regards to scope for either IA32_TEMPERATURE_TARGET (1A2h) or
IA32_THERM_STATUS (19Ch) on Nehalem.

> Coding this MSR based on observation is not right and may cause problem in other cases or in the future.

If you have actual examples of "other cases", I'm all ears.

I wouldn't care too much about the future. The fact that the package
TjMax is currently read from the same MSR bits as the per-core TjMax
implies that the value _is_ per-package for Sandy Bridge (as
documented, BTW.) If a future microarchitecture really offers a
per-package limit distinct from per-core limits, this will have to be
read from different MSR bits, so the coretemp driver will have to be
updated anyway.

As a summary, I'm fine following the documentation, but only as long as
it doesn't contradict logic and real-world experiments.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
