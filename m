From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 16 Sep 2010 08:48:59 +0000
Subject: Re: [lm-sensors] [PATCH v3 6/7] hwmon: (lm90) Add support for extra
Message-Id: <20100916104859.6c56758b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1284601950-7381-7-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1284601950-7381-7-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 15 Sep 2010 18:52:29 -0700, Guenter Roeck wrote:
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
>  Documentation/hwmon/lm90            |    9 +++--
>  Documentation/hwmon/sysfs-interface |    7 ++++
>  drivers/hwmon/lm90.c                |   65 +++++++++++++++++++++++++++++++---
>  3 files changed, 71 insertions(+), 10 deletions(-)
> (...)
> diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
> index 22843cb..4c73f3d 100644
> --- a/Documentation/hwmon/sysfs-interface
> +++ b/Documentation/hwmon/sysfs-interface
> @@ -317,6 +317,13 @@ temp[1-*]_emergency
>  		Unit: millidegree Celsius
>  		RW
>  
> +temp[1-*]_emergency_hyst
> +		Temperature hysteresis value for emergency limit.
> +		Unit: millidegree Celsius
> +		Must be reported as an absolute temperature, NOT a delta
> +		from the emergency value.
> +		RW
> +
>  temp[1-*]_lcrit	Temperature critical min value, typically lower than
>  		corresponding temp_min values.
>  		Unit: millidegree Celsius

I'll merge this chunk into
hwmon-add-tempx_emergency-attribute-to-sysfs-abi.patch, I think it
makes more sense that way.

Other than that, no objection.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
