From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 11 Sep 2012 07:01:49 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] hwmon: (twl4030-madc-hwmon) Initialize uninitialized structure elements
Message-Id: <20120911090149.75e4bd4f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1347336566-32662-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1347336566-32662-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 10 Sep 2012 21:09:23 -0700, Guenter Roeck wrote:
> twl4030_madc_conversion uses do_avg and type structure elements of
> twl4030_madc_request. Initialize to avoid random operation.
> 
> Cc: Keerthy <j-keerthy@ti.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/twl4030-madc-hwmon.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hwmon/twl4030-madc-hwmon.c b/drivers/hwmon/twl4030-madc-hwmon.c
> index 0018c7d..f8ba8b0 100644
> --- a/drivers/hwmon/twl4030-madc-hwmon.c
> +++ b/drivers/hwmon/twl4030-madc-hwmon.c
> @@ -50,6 +50,8 @@ static ssize_t madc_read(struct device *dev,
>  	req.channels = (1 << attr->index);
>  	req.method = TWL4030_MADC_SW2;
>  	req.func_cb = NULL;
> +	req.do_avg = 0;
> +	req.type = TWL4030_MADC_WAIT;
>  	val = twl4030_madc_conversion(&req);
>  	if (val < 0)
>  		return val;

What about a structure-wide initialization at declaration time?

	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
	struct twl4030_madc_request req = {
		.channels = 1 << attr->index,
		.method = TWL4030_MADC_SW2,
		.type = TWL4030_MADC_WAIT,
	};

IIRC the compiler will initialize all other fields to 0 in this case,
which is what we want, and this also works if more fields are added in
the future.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
