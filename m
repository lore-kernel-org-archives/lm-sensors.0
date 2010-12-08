From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 08 Dec 2010 14:49:41 +0000
Subject: Re: [lm-sensors] Patch[1/2] Adding Core and Package Thermal
Message-Id: <20101208144941.GB28179@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <D6D887BA8C9DFF48B5233887EF04654105C0E05F4E@bgsmsx502.gar.corp.intel.com>
In-Reply-To: <D6D887BA8C9DFF48B5233887EF04654105C0E05F4E@bgsmsx502.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "lenb@kernel.org" <lenb@kernel.org>

On Wed, Dec 08, 2010 at 04:10:29AM -0500, R, Durgadoss wrote:
> Hi Fenghua,
> 
> This patch adds the core and package thermal threshold support to coretemp.c.
> These thresholds can be read/written using the hwmon sysfs interfaces
> temp1_core_thresh[0/1] and temp1_pkg_thresh[0/1].
> 
I don't think adding attributes to the hwmon sysfs ABI without prior discussion
is a good idea. Besides, there may be other means to accomplish the same,
eg by using the tempX_emergency attribute.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
