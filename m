From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 04 Jan 2012 16:20:36 +0000
Subject: Re: [lm-sensors] [linux-pm] [RFC PATCH 2/3] thermal: exynos4:
Message-Id: <1325694036.26706.27.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1324468798-20423-1-git-send-email-amit.kachhap@linaro.org>
	 <1324468798-20423-3-git-send-email-amit.kachhap@linaro.org>
	 <1325629553.26706.11.camel@groeck-laptop>
	 <CAK44p20XeLVkJyox2SsDqyy=RYgEQNpyGGypwTMPXpueQT1T3g@mail.gmail.com>
	 <4D68720C2E767A4AA6A8796D42C8EB5901B976@BGSMSX101.gar.corp.intel.com>
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB5901B976@BGSMSX101.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: Amit Kachhap <amit.kachhap@linaro.org>, Donggeun Kim <dg77.kim@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>, "patches@linaro.org" <patches@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>

On Wed, 2012-01-04 at 05:23 -0500, R, Durgadoss wrote:
> Hi Amit Daniel,
> 
> > Hi Guenter,
> > 
> > The main idea of this work is to leave the current userspace based
> > notification scheme and add the kernel based cooling scheme on top of
> > it. Anyway, It is a good idea to move the file hwmon/exynos4_tmu.c as
> 
> But, What I feel is, kernel based cooling scheme will work only for
> Controlling 'CPU' frequency. But in SoC's there are other devices that
> Contribute to Thermal. For example, GPU, Display, Battery (during charging)
> etc.. In this case, we need a user space to control these devices. So, in a
> way, the user space notification mechanism is a unified solution for
> throttling all devices and keeps the kernel code light weight.
> 
> I am also curious to know why the existing mechanism did not work for you ?
> 
That is one question. 

For me, the main concern is that the proposed implementation creates
duplicate hwmon entries for the same device, which is simply messy. If
both the kernel thermal mechanism and the userspace mechanism are
needed, I think it would make more sense to use a thermal driver and
have that thermal driver generate the necessary userspace events.

Thanks,
Guenter

> Thanks,
> Durga
> 
> > this creates 2 hwmon entries.
> > Adding CC: Donggeun Kim to know his opinion.
> > 
> > Thanks,
> > Amit Daniel
> [snip.]



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
