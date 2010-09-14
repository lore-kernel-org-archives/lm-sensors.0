From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 14 Sep 2010 03:22:11 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/emc1403: remove unnecessary
Message-Id: <20100914032211.GA3497@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100914023351.GA27145@ywang-moblin2.bj.intel.com>
In-Reply-To: <20100914023351.GA27145@ywang-moblin2.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yong Wang <yong.y.wang@linux.intel.com>
Cc: Jean Delvare <khali@linux-fr.org>, Alan Cox <alan@linux.intel.com>, Kalhan Trisal <kalhan.trisal@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Mon, Sep 13, 2010 at 10:33:51PM -0400, Yong Wang wrote:
> It is unnecessary to call hwmon_device_unregister in error handling
> before hwmon_device_register is called.
> 
Not only unnecessary but wrong. Good catch.

> Signed-off-by: Yong Wang <yong.y.wang@intel.com>

Reviewed-by: Guenter Roeck <guenter.roeck@ericsson.com>

> ---
>  drivers/hwmon/emc1403.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hwmon/emc1403.c b/drivers/hwmon/emc1403.c
> index 5b58b20..8dee3f3 100644
> --- a/drivers/hwmon/emc1403.c
> +++ b/drivers/hwmon/emc1403.c
> @@ -308,7 +308,6 @@ static int emc1403_probe(struct i2c_client *client,
>  	res = sysfs_create_group(&client->dev.kobj, &m_thermal_gr);
>  	if (res) {
>  		dev_warn(&client->dev, "create group failed\n");
> -		hwmon_device_unregister(data->hwmon_dev);
>  		goto thermal_error1;
>  	}
>  	data->hwmon_dev = hwmon_device_register(&client->dev);
> -- 
> 1.5.5.1
> 
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
