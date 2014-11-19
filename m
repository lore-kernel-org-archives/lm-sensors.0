From: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Date: Wed, 19 Nov 2014 15:41:48 +0000
Subject: Re: [lm-sensors] [PATCHv4 1/1] thermal: of: improve of-thermal sensor registration API
Message-Id: <546CBA3C.9020709@kapsi.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <1416321575-18348-1-git-send-email-edubezval@gmail.com> <1416321575-18348-2-git-send-email-edubezval@gmail.com>
In-Reply-To: <1416321575-18348-2-git-send-email-edubezval@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eduardo Valentin <edubezval@gmail.com>, Linux PM <linux-pm@vger.kernel.org>
Cc: Caesar Wang <caesar.wang@rock-chips.com>, Wei Ni <wni@nvidia.com>, Lukasz Majewski <l.majewski@samsung.com>, Alexandre Courbot <gnurou@gmail.com>, devicetree@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.de>, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, lm-sensors@lm-sensors.org, Rob Herring <robh+dt@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Zhang Rui <rui.zhang@intel.com>

On 11/18/2014 04:39 PM, Eduardo Valentin wrote:
> Different drivers request API extensions in of-thermal. For this reason,
> additional callbacks are required to fit the new drivers needs.
>
> The current API implementation expects the registering sensor driver
> to provide a get_temp and get_trend callbacks as function parameters.
> As the amount of callbacks is growing, this patch changes the existing
> implementation to use a .ops field to hold all the of thermal callbacks
> to sensor drivers.
>
> This patch also changes the existing of-thermal users to fit the new
> API design. No functional change is introduced in this patch.
>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: devicetree@vger.kernel.org
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Jean Delvare <jdelvare@suse.de>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-tegra@vger.kernel.org
> Cc: lm-sensors@lm-sensors.org
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Reviewed-by: Lukasz Majewski <l.majewski@samsung.com>
> Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
> ---
>   drivers/hwmon/lm75.c                               |  9 +++--
>   drivers/hwmon/ntc_thermistor.c                     |  6 +++-
>   drivers/hwmon/tmp102.c                             |  6 +++-
>   drivers/thermal/of-thermal.c                       | 40 ++++++++++------------
>   drivers/thermal/tegra_soctherm.c                   |  7 ++--
>   drivers/thermal/ti-soc-thermal/ti-thermal-common.c |  8 +++--
>   include/linux/thermal.h                            | 24 +++++++++----
>   7 files changed, 63 insertions(+), 37 deletions(-)
> ---
> Difference from V3:
>    - Keep the same behavior regarding callback checks.
>      Change in behavior may be sent in a separate patch.
> Difference from V2:
>    - Fix wrong assignment in tegra driver.
> Difference from V1:
>    - Fix error handling when .get_trend is not provided.
>
> @@ -356,8 +356,8 @@ thermal_zone_of_add_sensor(struct device_node *zone,
>    *             than one sensors
>    * @data: a private pointer (owned by the caller) that will be passed
>    *        back, when a temperature reading is needed.
> - * @get_temp: a pointer to a function that reads the sensor temperature.
> - * @get_trend: a pointer to a function that reads the sensor temperature trend.
> + * @ops: struct thermal_zone_of_device *. Must contain at least .get_trend and
> + *       .get_temp.

This comment seems to be incorrect, as .get_trend is optional.

>    *
>    * This function will search the list of thermal zones described in device
>    * tree and look for the zone that refer to the sensor device pointed by

With that minor one fixed,

Tested-by: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Reviewed-by: Mikko Perttunen <mikko.perttunen@kapsi.fi>

Cheers,
Mikko

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
