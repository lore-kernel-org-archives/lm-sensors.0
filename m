From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 15 Jan 2015 04:44:36 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (ina2xx) Add ina231 compatible string
Message-Id: <54B745B4.2040807@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1421285699-8469-1-git-send-email-khilman@kernel.org>
In-Reply-To: <1421285699-8469-1-git-send-email-khilman@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kevin Hilman <khilman@kernel.org>, lm-sensors@lm-sensors.org
Cc: linux-samsung-soc@vger.kernel.org, DOCUMENTATION <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, open list <linux-kernel@vger.kernel.org>, linaro-kernel@lists.linaro.org

On 01/14/2015 05:34 PM, Kevin Hilman wrote:
> From: Kevin Hilman <khilman@linaro.org>
>
> Add support for "ina231" as compatible string, and update
> Documentation and Kconfig accordingly.
>
> Tested with the Exynos5422-based odroid-xu3 board which has on-board
> INA231 sensors.
>
> Signed-off-by: Kevin Hilman <khilman@linaro.org>

Applied to -next after minor cleanup (see below).

> ---
>   Documentation/hwmon/ina2xx | 9 +++++++++
>   drivers/hwmon/Kconfig      | 4 ++--
>   drivers/hwmon/ina2xx.c     | 1 +
>   3 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/hwmon/ina2xx b/Documentation/hwmon/ina2xx
> index 4223c2d3b508..c2f838f65ee4 100644
> --- a/Documentation/hwmon/ina2xx
> +++ b/Documentation/hwmon/ina2xx
> @@ -26,6 +26,12 @@ Supported chips:
>       Datasheet: Publicly available at the Texas Instruments website
>                  http://www.ti.com/
>
> +  * Texas Instruments INA231
> +    Prefix: 'ina231'
> +    Addresses: I2C 0x40 - 0x4f
> +    Datasheet: Publicly available at the Texas Instruments website
> +               http://www.ti.com/
> +
>   Author: Lothar Felten <l-felten@ti.com>
>
>   Description
> @@ -44,6 +50,9 @@ The INA226 monitors both a shunt voltage drop and bus supply voltage.
>   The INA230 is a high or low side current shunt and power monitor with an I2C
>   interface. The INA230 monitors both a shunt voltage drop and bus supply voltage.
>
> +The INA231 is a high or low side current shunt and power monitor with an I2C
> +interface. The INA230 monitors both a shunt voltage drop and bus supply voltage.
> +
		The INA231 ...

I fixed this up and merged above two paragraphs into one.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
