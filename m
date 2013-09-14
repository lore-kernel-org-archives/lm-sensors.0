From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 14 Sep 2013 18:00:26 +0000
Subject: Re: [lm-sensors] [PATCH 04/12] hwmon: (mc13783-adc) Increase size of name string
Message-Id: <20130914200026.268cee58@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1379147615-7703-5-git-send-email-linux@roeck-us.net>
In-Reply-To: <1379147615-7703-5-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 14 Sep 2013 01:33:27 -0700, Guenter Roeck wrote:
> smatch complains about
> 
> mc13783_adc_probe() error: snprintf() chops off the last chars of
> 'id->name': 20 +vs 10
> 
> Use PLATFORM_NAME_SIZE instead of '10' as size when declaring
> the name variable.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Note that Dan Carpenter had been sending the same patch 19 months ago:

http://lists.lm-sensors.org/pipermail/lm-sensors/2012-February/035178.html

I wasn't sure what to do with it and finally forgot about it, sorry.

> ---
>  drivers/hwmon/mc13783-adc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/mc13783-adc.c b/drivers/hwmon/mc13783-adc.c
> index 982d862..ae00e60 100644
> --- a/drivers/hwmon/mc13783-adc.c
> +++ b/drivers/hwmon/mc13783-adc.c
> @@ -37,7 +37,7 @@
>  struct mc13783_adc_priv {
>  	struct mc13xxx *mc13xxx;
>  	struct device *hwmon_dev;
> -	char name[10];
> +	char name[PLATFORM_NAME_SIZE];
>  };
>  
>  static ssize_t mc13783_adc_show_name(struct device *dev, struct device_attribute

I admit I find it a bit sad to allocate more memory than we need just
to make a static analyzer happy. Static analyzers are supposed to help
developers improve their code, not make it less efficient.

That being said, I tried to rewrite the code in a way which was more
obviously correct (to a static analyzer), but what I came up with was
not very appealing.

So if everybody is OK with the simple buffer size fix above, then so am
I.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
