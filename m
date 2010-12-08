From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Wed, 08 Dec 2010 16:48:07 +0000
Subject: Re: [lm-sensors] Patch[1/2] Adding Core and Package Thermal
Message-Id: <D6D887BA8C9DFF48B5233887EF04654105C0E06153@bgsmsx502.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <D6D887BA8C9DFF48B5233887EF04654105C0E05F4E@bgsmsx502.gar.corp.intel.com>
 <20101208162214.353e3899@endymion.delvare>
In-Reply-To: <20101208162214.353e3899@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "lenb@kernel.org" <lenb@kernel.org>

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

Ok. I did not know the existence of a pkgtemp driver.
Will look into the pkgtemp driver.

> 
> > Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> 
> Please note also that we will need your full name for kernel
> submissions.

That's my Full name. All my official records as well as
Other patch submissions have this name only.

Thanks,
Durgadoss

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
