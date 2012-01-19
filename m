From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 19 Jan 2012 14:55:28 +0000
Subject: Re: [lm-sensors] [PATCH 04/39] hwmon: (adm1025) Fix checkpatch issues
Message-Id: <20120119155528.024bee86@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1326703781-14272-5-git-send-email-linux@roeck-us.net>
In-Reply-To: <1326703781-14272-5-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 16 Jan 2012 00:49:06 -0800, Guenter Roeck wrote:
> Fixed:
> ERROR: do not use assignment in if condition
> ERROR: space required after that ',' (ctx:VxV)
> ERROR: spaces required around that '<' (ctx:VxV)
> ERROR: spaces required around that '=' (ctx:VxV)
> ERROR: trailing whitespace
> WARNING: simple_strtol is obsolete, use kstrtol instead
> WARNING: simple_strtoul is obsolete, use kstrtoul instead
> 
> Not fixed:
> ERROR: Macros with multiple statements should be enclosed in a do - while loop
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/adm1025.c |   63 ++++++++++++++++++++++++++++++++++------------
>  1 files changed, 46 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/hwmon/adm1025.c b/drivers/hwmon/adm1025.c
> index 60befc0..14d8997 100644
> --- a/drivers/hwmon/adm1025.c
> +++ b/drivers/hwmon/adm1025.c
> (...)
> @@ -343,7 +364,14 @@ static ssize_t set_vrm(struct device *dev, struct device_attribute *attr,
>  		       const char *buf, size_t count)
>  {
>  	struct adm1025_data *data = dev_get_drvdata(dev);
> -	data->vrm = simple_strtoul(buf, NULL, 10);
> +	unsigned long val;
> +	int err;
> +
> +	err = kstrtoul(buf, 10, &val);
> +	if (err)
> +		return err;
> +
> +	data->vrm = SENSORS_LIMIT(val, 0, 255);
>  	return count;
>  }

This is a behavioral change, not a mere checkpatch clean-up. The change
itself is correct but it should be separated.

The rest looks good, so:

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
