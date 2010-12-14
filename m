From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 14 Dec 2010 18:24:35 +0000
Subject: Re: [lm-sensors] [Patch] Adding threshold support to coretemp
Message-Id: <20101214182435.GA32358@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <D6D887BA8C9DFF48B5233887EF04654105C1109439@bgsmsx502.gar.corp.intel.com>
In-Reply-To: <D6D887BA8C9DFF48B5233887EF04654105C1109439@bgsmsx502.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, Chen Gong <gong.chen@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "khali@linux-fr.org" <khali@linux-fr.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Tue, Dec 14, 2010 at 06:55:35AM -0500, R, Durgadoss wrote:
> Hi Jean/Fenghua,
> 
> I am submitting a patch to enable core thermal threshold
> Support to coretemp.c. There are two core thermal thresholds
> available through sysfs interfaces temp1_core_thresh[0/1].
> 
> The expectation is that thresh0 is lesser than the current temperature
> and thresh1 is higher than the current temperature. Whenever the current
> temperature crosses these limits, an interrupt is generated.
> This interrupt is handles by the user space to do power
> Management via CPU throttling, etc..
> 
> This patch is generated against stable Linux-2.6 kernel.
> 
> Kindly review and merge.
> ------------------------------------------------------------------
> From: Durgadoss R <durgadoss.r@intel.com>
> 
> Date: Tue, 14 Dec 2010 05:10:27 +0530
> Subject: [PATCH] Adding_threshold_support_to_coretemp
> 
> This patch adds the core thermal threshold support to coretemp.c.
> These thresholds can be read/written using the sysfs interface
> temp1_core_thresh[0/1]. These can be used to generate interrupts,
> to do dynamic power management.
> 
> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> 
I am not inclined to look further into this patch until the ABI questions are resolved.
As written, the patch gets my NACK simply because it introduces random driver specific
new ABI attributes.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
