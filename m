From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 03 Mar 2012 14:55:38 +0000
Subject: Re: [lm-sensors] [PATCH 3/4] thermal: exynos4: Register the tmu sensor with the thermal interface la
Message-Id: <20120303145538.GB29335@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1330772767-16120-1-git-send-email-amit.kachhap@linaro.org>
 <1330772767-16120-4-git-send-email-amit.kachhap@linaro.org>
In-Reply-To: <1330772767-16120-4-git-send-email-amit.kachhap@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Amit Daniel Kachhap <amit.kachhap@linaro.org>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>, "patches@linaro.org" <patches@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>

On Sat, Mar 03, 2012 at 06:06:06AM -0500, Amit Daniel Kachhap wrote:
> Export and register information from the tmu temperature sensor to the samsung
> exynos kernel thermal framework where different cooling devices and thermal
> zone are binded. The exported information is based according to the data
> structure thermal_sensor_conf present in exynos_thermal.h. HWMON sysfs
> functions are removed as all of them are present in generic linux thermal layer.
> 
> Also the platform data structure is modified to pass frequency cooling
> in percentages for each thermal level.
> 
> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@linaro.org>

Ah, that is what I meant. I don't think it makes sense to have this as separate patch.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
