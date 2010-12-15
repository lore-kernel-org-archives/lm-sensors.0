From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Wed, 15 Dec 2010 12:41:15 +0000
Subject: Re: [lm-sensors] [Patch] Adding threshold support to coretemp
Message-Id: <D6D887BA8C9DFF48B5233887EF04654105C1109A9B@bgsmsx502.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <D6D887BA8C9DFF48B5233887EF04654105C1109439@bgsmsx502.gar.corp.intel.com>
 <20101214182435.GA32358@ericsson.com>
In-Reply-To: <20101214182435.GA32358@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, Chen Gong <gong.chen@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "khali@linux-fr.org" <khali@linux-fr.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

Hi Guenter,

> > ------------------------------------------------------------------
> > From: Durgadoss R <durgadoss.r@intel.com>
> >
> > Date: Tue, 14 Dec 2010 05:10:27 +0530
> > Subject: [PATCH] Adding_threshold_support_to_coretemp
> >
> > This patch adds the core thermal threshold support to coretemp.c.
> > These thresholds can be read/written using the sysfs interface
> > temp1_core_thresh[0/1]. These can be used to generate interrupts,
> > to do dynamic power management.
> >
> > Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> >
> I am not inclined to look further into this patch until the ABI questions are
> resolved.
> As written, the patch gets my NACK simply because it introduces random driver
> specific
> new ABI attributes.
> 

Since the Hardware supports the programming of thresholds, I added this support
in the driver. I had to add new attributes, since there are no existing attributes,
that support these thresholds.
Could you please suggest any better way(s) of enabling this support ?
I can add documentation for these attributes in Doc/hwmon/sysfs-interface.

Thanks,
Durga

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
