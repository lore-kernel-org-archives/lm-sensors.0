From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Mon, 03 Jan 2011 15:23:59 +0000
Subject: Re: [lm-sensors]
Message-Id: <D6D887BA8C9DFF48B5233887EF04654105C125176B@bgsmsx502.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <D6D887BA8C9DFF48B5233887EF04654105C1251710@bgsmsx502.gar.corp.intel.com>
 <20110103150328.GB25600@ericsson.com>
In-Reply-To: <20110103150328.GB25600@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, "khali@linux-fr.org" <khali@linux-fr.org>, "Brown, Len" <len.brown@intel.com>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

Hi Guenter,

> > From: Durgadoss R <durgadoss.r@intel.com>
> >
> > Date: Sun, 19 Dec 2010 22:42:45 +0530
> > Subject: [PATCH 1/2] X86:Adding_core_threshold_notification_to_therm_throt.c
> >
> > This patch adds code to therm_throt.c to notify core thermal threshold
> > events. These thresholds are supported by the IA32_THERM_INTERRUPT register.
> > The status/log for the same is monitored using the IA32_THERM_STATUS
> register.
> > The necessary #defines are in msr-index.h. A call back is added to mce.h, to
> > further notify the thermal stack, about the threshold events.
> >
> > Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> >
> If this is just a resubmit, you might instead consider trying to figure out
> why none of the x86 maintainers replied. Documentation/Submit* might help,
> as well as comparing your set of patches with other (accepted) patches.
> 

This is a resubmission. I thought people might be on holidays..that's why
resubmitted today. Anyway, I shall try to figure out the reason. Thanks
for pointing it out Guenter..

Any comments on the hwmon patch 2/2 ?

Thanks,
Durga

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
