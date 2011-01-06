From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 06 Jan 2011 05:33:28 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: twl4030: Driver for twl4030 madc
Message-Id: <20110106053328.GA7489@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1294287457-2438-1-git-send-email-j-keerthy@ti.com>
In-Reply-To: <1294287457-2438-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Keerthy <j-keerthy@ti.com>
Cc: "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "khali@linux-fr.org" <khali@linux-fr.org>, "mikko.k.ylinen@nokia.com" <mikko.k.ylinen@nokia.com>, "amit.kucheria@canonical.com" <amit.kucheria@canonical.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "balajitk@ti.com" <balajitk@ti.com>

On Wed, Jan 05, 2011 at 11:17:37PM -0500, Keerthy wrote:
> Introducing a driver for MADC on TWL4030 powerIC. MADC stands for monitoring
> ADC. This driver monitors the real time conversion of analog signals like
> battery temperature, battery type, battery level etc. User can also ask for
> the conversion on a particular channel using the sysfs nodes. Tested the
> conversion through sysfs nodes. Tested with DEBUG_LOCKDEP enabled.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
> 
NACK for:

[...]
> +EXPORT_SYMBOL_GPL(twl4030_madc_conversion);
[...]
> +EXPORT_SYMBOL_GPL(twl4030_get_madc_conversion);

No symbol export from hwmon drivers. Other parts of the kernel
should not depend on HWMON configuration.

I would suggest to check if drivers/staging/iio would be a better fit.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
