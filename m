From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Wed, 08 Dec 2010 16:58:45 +0000
Subject: Re: [lm-sensors] Patch[2/2] Adding Interrupt Handling Support to
Message-Id: <D6D887BA8C9DFF48B5233887EF04654105C0E06161@bgsmsx502.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <D6D887BA8C9DFF48B5233887EF04654105C0E05F61@bgsmsx502.gar.corp.intel.com>
 <20101208150650.GA28273@ericsson.com>
In-Reply-To: <20101208150650.GA28273@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "lenb@kernel.org" <lenb@kernel.org>

> > From: Durgadoss R <durgadoss.r@intel.com>
> >
> > Date: Tue, 7 Dec 2010 04:10:41 +0530
> > Subject: [PATCH 2/2] Adding_Threshold_Interrupt_Handling_to_Coretemp
> >
> > This patch adds the interrupt handling for the core/package
> > thermal thresholds in coretemp. The interrupts are routed to coretemp
> > via therm_throt.c. Whenever an interrupt occurs, a notification is sent
> > in the form of a netlink event to the user space.
> >
> > Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> >
> After browsing through this and the previous patch, I think the functionality
> should reside outside and be independent of hwmon. arch/x86/kernel/cpu or
> drivers/platform/x86 might be better places for it, though I am not really
> in a position to make that judgement.

I added the threshold support to hwmon because the existing coretemp
driver provided a nice infrastructure for this. For eg: I do not
have to create functions for reading current temperature, detecting
the CPU model, checking the DTS support etc..

But If you are saying that, the coretemp driver itself(not just
the threshold functionality), should be in a different location,
then, as you said, I am also not in a position to make the judgement.

Thanks,
Durgadoss

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
