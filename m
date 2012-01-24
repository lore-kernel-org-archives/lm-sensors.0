From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Date: Tue, 24 Jan 2012 16:16:16 +0000
Subject: Re: [lm-sensors] [PATCH 29/79] hwmon: (ltc4245) Fix multi-line comments
Message-Id: <20120124161616.GB2794@ovro.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327373398-997-30-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1327373398-997-30-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Jan 23, 2012 at 06:49:08PM -0800, Guenter Roeck wrote:
> From: Guenter Roeck <linux@roeck-us.net>
> 
> Cc: Ira W. Snyder <iws@ovro.caltech.edu>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Ira W. Snyder <iws@ovro.caltech.edu>

> ---
>  drivers/hwmon/ltc4245.c |    9 ++++++---
>  1 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/ltc4245.c b/drivers/hwmon/ltc4245.c
> index 693a6bd..b99b45b 100644
> --- a/drivers/hwmon/ltc4245.c
> +++ b/drivers/hwmon/ltc4245.c
> @@ -214,7 +214,8 @@ static unsigned int ltc4245_get_current(struct device *dev, u8 reg)
>  	unsigned int voltage;
>  	unsigned int curr;
>  
> -	/* The strange looking conversions that follow are fixed-point
> +	/*
> +	 * The strange looking conversions that follow are fixed-point
>  	 * math, since we cannot do floating point in the kernel.
>  	 *
>  	 * Step 1: convert sense register to microVolts
> @@ -317,7 +318,8 @@ static ssize_t ltc4245_show_gpio(struct device *dev,
>  	return snprintf(buf, PAGE_SIZE, "%u\n", val * 10);
>  }
>  
> -/* These macros are used below in constructing device attribute objects
> +/*
> + * These macros are used below in constructing device attribute objects
>   * for use with sysfs_create_group() to make a sysfs device file
>   * for each register.
>   */
> @@ -391,7 +393,8 @@ LTC4245_POWER(power2_input,			LTC4245_5VSENSE);
>  LTC4245_POWER(power3_input,			LTC4245_3VSENSE);
>  LTC4245_POWER(power4_input,			LTC4245_VEESENSE);
>  
> -/* Finally, construct an array of pointers to members of the above objects,
> +/*
> + * Finally, construct an array of pointers to members of the above objects,
>   * as required for sysfs_create_group()
>   */
>  static struct attribute *ltc4245_std_attributes[] = {
> -- 
> 1.7.3.1
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
