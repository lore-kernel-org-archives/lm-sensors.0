From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 12 May 2012 15:38:05 +0000
Subject: Re: [lm-sensors] [PATCH v4 2/5] hwmon: exynos4: Move thermal sensor driver to driver/thermal directo
Message-Id: <20120512153805.GB5769@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1336815645-29625-1-git-send-email-amit.kachhap@linaro.org>
 <1336815645-29625-3-git-send-email-amit.kachhap@linaro.org>
In-Reply-To: <1336815645-29625-3-git-send-email-amit.kachhap@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Amit Daniel Kachhap <amit.kachhap@linaro.org>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "durgadoss.r@intel.com" <durgadoss.r@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "khali@linux-fr.org" <khali@linux-fr.org>, "patches@linaro.org" <patches@linaro.org>

On Sat, May 12, 2012 at 05:40:42AM -0400, Amit Daniel Kachhap wrote:
> This movement is needed because the hwmon entries and corresponding
> sysfs interface is a duplicate of utilities already provided by
> driver/thermal/thermal_sys.c. The goal is to place it in thermal folder
> and add necessary functions to use the in-kernel thermal interfaces.
> 
> CC: Guenter Roeck <guenter.roeck@ericsson.com>
> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@linaro.org>
> Signed-off-by: Donggeun Kim <dg77.kim@samsung.com>

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

Some suggestions, possibly for later cleanup.

> -
> -       data = kzalloc(sizeof(struct exynos4_tmu_data), GFP_KERNEL);

If you use devm_kzalloc, you won't have to free it.

[ ...]

> -       data->mem = request_mem_region(data->mem->start,
> -                       resource_size(data->mem), pdev->name);

Same here, with devm_request_mem_region.

[ ... ]

> -       data->base = ioremap(data->mem->start, resource_size(data->mem));

and devm_ioremap

[ ... ]

> -       ret = request_irq(data->irq, exynos4_tmu_irq,

and devm_request_irq

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
