From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 14 Oct 2015 01:17:15 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] Bumps limit of maximum core ID from 32 to 128.
Message-Id: <561DAD1B.9010101@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1444650812-17398-1-git-send-email-lukasz.odzioba@intel.com>
In-Reply-To: <1444650812-17398-1-git-send-email-lukasz.odzioba@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lukasz Odzioba <lukasz.odzioba@intel.com>, fenghua.yu@intel.com
Cc: jdelvare@suse.de, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On 10/12/2015 04:53 AM, Lukasz Odzioba wrote:
> A new limit selected arbitrarily as power of two greater than
> required minimum for Xeon Phi processor.
>
> Currently driver is not able to handle cores with core ID greater than 32.
> Such attempt ends up with the following error in dmesg:
> coretemp coretemp.0: Adding Core XXX failed
>
> Signed-off-by: Lukasz Odzioba <lukasz.odzioba@intel.com>

Applied, after fixing up the subject and listing the current required limit
of 72 cores for Xeon Phi (per published information).

Guenter

> ---
>   drivers/hwmon/coretemp.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index 3e03379..6a27eb2 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -52,7 +52,7 @@ module_param_named(tjmax, force_tjmax, int, 0444);
>   MODULE_PARM_DESC(tjmax, "TjMax value in degrees Celsius");
>
>   #define BASE_SYSFS_ATTR_NO	2	/* Sysfs Base attr no for coretemp */
> -#define NUM_REAL_CORES		32	/* Number of Real cores per cpu */
> +#define NUM_REAL_CORES		128	/* Number of Real cores per cpu */
>   #define CORETEMP_NAME_LENGTH	19	/* String Length of attrs */
>   #define MAX_CORE_ATTRS		4	/* Maximum no of basic attrs */
>   #define TOTAL_ATTRS		(MAX_CORE_ATTRS + 1)
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
