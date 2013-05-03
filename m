From: "myungjoo.ham" <myungjoo.ham@samsung.com>
Date: Fri, 03 May 2013 10:01:31 +0000
Subject: Re: [lm-sensors] [PATCH 4/5] hwmon: ntc_thermistor: Remove redundant platform_set_drvdata()
Message-Id: <001201ce47e5$2fb29a40$8f17cec0$@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1367574220-15787-4-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1367574220-15787-4-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Commit 0998d06310 (device-core: Ensure drvdata = NULL when no driver is
bound) removes the need to set driver data field to NULL.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

> ---
>  drivers/hwmon/ntc_thermistor.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/hwmon/ntc_thermistor.c
b/drivers/hwmon/ntc_thermistor.c index d6d640a..830a842 100644
> --- a/drivers/hwmon/ntc_thermistor.c
> +++ b/drivers/hwmon/ntc_thermistor.c
> @@ -514,7 +514,6 @@ static int ntc_thermistor_remove(struct
platform_device *pdev)
>  	hwmon_device_unregister(data->hwmon_dev);
>  	sysfs_remove_group(&data->dev->kobj, &ntc_attr_group);
>  	ntc_iio_channel_release(pdata);
> -	platform_set_drvdata(pdev, NULL);
>  
>  	return 0;
>  }
> --
> 1.7.9.5
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
