From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 13 Oct 2015 20:31:34 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] Bumps limit of maximum core ID from 32 to 128.
Message-Id: <20151013203134.GA28106@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1444650812-17398-1-git-send-email-lukasz.odzioba@intel.com>
In-Reply-To: <1444650812-17398-1-git-send-email-lukasz.odzioba@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lukasz Odzioba <lukasz.odzioba@intel.com>
Cc: fenghua.yu@intel.com, jdelvare@suse.de, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Mon, Oct 12, 2015 at 01:53:32PM +0200, Lukasz Odzioba wrote:
> A new limit selected arbitrarily as power of two greater than
> required minimum for Xeon Phi processor.
> 
> Currently driver is not able to handle cores with core ID greater than 32.
> Such attempt ends up with the following error in dmesg:
> coretemp coretemp.0: Adding Core XXX failed
> 

Why 128 instead of a more reasonable 64 ? What is the required minimum
for Xeon Phi ?

Also, please consider using the subject line commonly used in hwmon,
or at least point to the driver you are changing.

Thanks,
Guenter

> Signed-off-by: Lukasz Odzioba <lukasz.odzioba@intel.com>
> ---
>  drivers/hwmon/coretemp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index 3e03379..6a27eb2 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -52,7 +52,7 @@ module_param_named(tjmax, force_tjmax, int, 0444);
>  MODULE_PARM_DESC(tjmax, "TjMax value in degrees Celsius");
>  
>  #define BASE_SYSFS_ATTR_NO	2	/* Sysfs Base attr no for coretemp */
> -#define NUM_REAL_CORES		32	/* Number of Real cores per cpu */
> +#define NUM_REAL_CORES		128	/* Number of Real cores per cpu */
>  #define CORETEMP_NAME_LENGTH	19	/* String Length of attrs */
>  #define MAX_CORE_ATTRS		4	/* Maximum no of basic attrs */
>  #define TOTAL_ATTRS		(MAX_CORE_ATTRS + 1)
> -- 
> 1.7.1
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
