From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 13 Feb 2015 05:13:35 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon: (applesmc) Allow format checking
Message-Id: <54DD87FF.7070803@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1423750517-26439-1-git-send-email-linux@rasmusvillemoes.dk>
In-Reply-To: <1423750517-26439-1-git-send-email-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Henrik Rydberg <rydberg@bitmath.org>, Jean Delvare <jdelvare@suse.de>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On 02/12/2015 06:15 AM, Rasmus Villemoes wrote:
> Currently gcc and other tools can't check the format strings. It's
> easy to fix by letting fan_speed_fmt simply hold what is different
> between the strings (and renaming it appropriately). While at it, we
> can also eliminate some wasted space and an extra level of indirection
> by making it an array of char[4] instead of char*.
>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Saving a few bytes with the added cost of harder to understand code.
Not really sure if that is worth it. I'll need to see a Tested-by:
for this patch.

Also, please fix the checkpatch warnings.

Thanks,
Guenter

> ---
>   drivers/hwmon/applesmc.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
> index 0af63da6b603..0c950e1b03f3 100644
> --- a/drivers/hwmon/applesmc.c
> +++ b/drivers/hwmon/applesmc.c
> @@ -84,12 +84,12 @@
>   #define TEMP_SENSOR_TYPE	"sp78"
>
>   /* List of keys used to read/write fan speeds */
> -static const char *const fan_speed_fmt[] = {
> -	"F%dAc",		/* actual speed */
> -	"F%dMn",		/* minimum speed (rw) */
> -	"F%dMx",		/* maximum speed */
> -	"F%dSf",		/* safe speed - not all models */
> -	"F%dTg",		/* target speed (manual: rw) */
> +static const char fan_speed_suffix[][4] = {
> +	"Ac",		/* actual speed */
> +	"Mn",		/* minimum speed (rw) */
> +	"Mx",		/* maximum speed */
> +	"Sf",		/* safe speed - not all models */
> +	"Tg",		/* target speed (manual: rw) */
>   };
>
>   #define INIT_TIMEOUT_MSECS	5000	/* wait up to 5s for device init ... */
> @@ -811,7 +811,7 @@ static ssize_t applesmc_show_fan_speed(struct device *dev,
>   	char newkey[5];
>   	u8 buffer[2];
>
> -	sprintf(newkey, fan_speed_fmt[to_option(attr)], to_index(attr));
> +	sprintf(newkey, "F%d%s", to_index(attr), fan_speed_suffix[to_option(attr)]);
>
>   	ret = applesmc_read_key(newkey, buffer, 2);
>   	speed = ((buffer[0] << 8 | buffer[1]) >> 2);
> @@ -834,7 +834,7 @@ static ssize_t applesmc_store_fan_speed(struct device *dev,
>   	if (kstrtoul(sysfsbuf, 10, &speed) < 0 || speed >= 0x4000)
>   		return -EINVAL;		/* Bigger than a 14-bit value */
>
> -	sprintf(newkey, fan_speed_fmt[to_option(attr)], to_index(attr));
> +	sprintf(newkey, "F%d%s", to_index(attr), fan_speed_suffix[to_option(attr)]);
>
>   	buffer[0] = (speed >> 6) & 0xff;
>   	buffer[1] = (speed << 2) & 0xff;
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
