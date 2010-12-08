From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 08 Dec 2010 17:11:38 +0000
Subject: Re: [lm-sensors] Patch[1/2] Adding Core and Package Thermal
Message-Id: <20101208171138.GA28901@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <D6D887BA8C9DFF48B5233887EF04654105C0E05F4E@bgsmsx502.gar.corp.intel.com>
 <20101208162214.353e3899@endymion.delvare>
In-Reply-To: <20101208162214.353e3899@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: "R, Durgadoss" <durgadoss.r@intel.com>, "Yu, Fenghua" <fenghua.yu@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, Dec 08, 2010 at 10:22:14AM -0500, Jean Delvare wrote:
> On Wed, 8 Dec 2010 14:40:29 +0530, R, Durgadoss wrote:
> > Hi Fenghua,
> > 
> > This patch adds the core and package thermal threshold support to coretemp.c.
> > These thresholds can be read/written using the hwmon sysfs interfaces
> > temp1_core_thresh[0/1] and temp1_pkg_thresh[0/1].
> 
> The package temperature isn't currently supported by the coretemp
> driver but by the pkgtemp driver. It makes no sense to add support for
> package thermal threshold to coretemp as long as the pkgtemp functionality
> hasn't been merged back into coretemp. This was the plan, BTW, I
> objected to the very existence of a separate pkgtemp driver since day
> 1, and I thought we had agreed that pkgtemp would be removed and its
> functionality would be merged into coretemp.
> 
Doesn't seem to be happening. Maybe we should reject further changes (other than
bug fixes) for those drivers until the cleanup has been done.

What is your take on the ABI changes ? For me, there are two questions: Do we need
new attributes ? If we do, what should be the attribute name(s) and semantics ?

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
