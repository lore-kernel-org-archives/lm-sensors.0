From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 03 Jan 2011 15:03:28 +0000
Subject: Re: [lm-sensors]
Message-Id: <20110103150328.GB25600@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <D6D887BA8C9DFF48B5233887EF04654105C1251710@bgsmsx502.gar.corp.intel.com>
In-Reply-To: <D6D887BA8C9DFF48B5233887EF04654105C1251710@bgsmsx502.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, "khali@linux-fr.org" <khali@linux-fr.org>, "Brown, Len" <len.brown@intel.com>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Mon, Jan 03, 2011 at 06:52:04AM -0500, R, Durgadoss wrote:
> Hi,
> 
> I am submitting a patch to add core thermal threshold notification
> Support to therm_throt.c. These thresholds are supported by the 
> IA32_THERM_INTERRUPT register. The status/log for the same is monitored
> using the IA32_THERM_STATUS register. The necessary #defines are in
> msr-index.h. A call back is added to mce.h, to further notify the
> thermal stack, about the threshold events.
> 
> This patch is generated against stable Linux-2.6 kernel.
> 
> Kindly review and merge.
> ---------------------------------------------------------------------------------
> From: Durgadoss R <durgadoss.r@intel.com>
> 
> Date: Sun, 19 Dec 2010 22:42:45 +0530
> Subject: [PATCH 1/2] X86:Adding_core_threshold_notification_to_therm_throt.c
> 
> This patch adds code to therm_throt.c to notify core thermal threshold
> events. These thresholds are supported by the IA32_THERM_INTERRUPT register.
> The status/log for the same is monitored using the IA32_THERM_STATUS register.
> The necessary #defines are in msr-index.h. A call back is added to mce.h, to
> further notify the thermal stack, about the threshold events.
> 
> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> 
If this is just a resubmit, you might instead consider trying to figure out
why none of the x86 maintainers replied. Documentation/Submit* might help,
as well as comparing your set of patches with other (accepted) patches.

If you made some changes, it would be expected to see the patch version and
to list the changes made. As it is, the headline and description of your patches
did not change for the last two (or three) submissions, so there is no easy way
to determine if anything has changed, nor is it possible to identify the most recent
version from the mailing list archive.

Guenter 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
