From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 19 Dec 2010 04:55:20 +0000
Subject: Re: [lm-sensors] Patch[1/2] Adding_threshold_support_to_coretemp
Message-Id: <20101219045520.GA16890@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <D6D887BA8C9DFF48B5233887EF04654105C1173BCD@bgsmsx502.gar.corp.intel.com>
In-Reply-To: <D6D887BA8C9DFF48B5233887EF04654105C1173BCD@bgsmsx502.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, "khali@linux-fr.org" <khali@linux-fr.org>, "Brown, Len" <len.brown@intel.com>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sat, Dec 18, 2010 at 09:09:59AM -0500, R, Durgadoss wrote:
> Hi,
> 
> I am submitting a patch to enable core thermal threshold
> Support to coretemp.c. There are two core thermal thresholds
> available through sysfs interfaces temp1_max and temp1_max_hyst.
> The temp1_max_alarm is set when temperature reaches or crosses
> above temp1_max or drops below temp1_max_hyst.
> 
> This patch is generated against stable Linux-2.6 kernel.
> 
> Kindly review and merge.
> ----------------------------------------------------------------
> From: Durgadoss R <durgadoss.r@intel.com>
> 
> Date: Sat, 18 Dec 2010 06:45:41 +0530
> Subject: PATCH[1/2] Adding_Threshold_Support_to_Coretemp
> 
> This patch adds core thermal threshold support to coretemp.
> These thresholds can be configured via the sysfs interfaces temp1_max
> and temp1_max_hyst. An interrupt is generated when CPU temperature reaches
> or crosses above temp1_max and drops below temp1_max_hyst.
> 
> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> 
Unfortunately, with this headline and description, the x86 folks will probably
not even look at your patch, since they won't suspect that x86 platform code
is affected.

I would suggest to split this patch in two parts, one affecting the x86 code
and the second for the hwmon code. The headline for the x86 patch should show
that it is a x86 patch, ie the text should start with x86: (and the hwmon
patches should really start with hwmon: for hwmon patches).

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
