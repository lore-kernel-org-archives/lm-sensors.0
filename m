From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 22 Feb 2012 17:11:35 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ads1015) Fix file leak in probe function
Message-Id: <20120222181135.47651bac@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1329927571-31574-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1329927571-31574-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 22 Feb 2012 08:19:31 -0800, Guenter Roeck wrote:
> An error while creating sysfs attribute files in the driver's probe function
> results in an error abort, but already created files are not removed. This patch
> fixes the problem.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> Cc: Dirk Eibach <eibach@gdsys.de>
> ---
>  drivers/hwmon/ads1015.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hwmon/ads1015.c b/drivers/hwmon/ads1015.c
> index eedca3c..1a1f058 100644
> --- a/drivers/hwmon/ads1015.c
> +++ b/drivers/hwmon/ads1015.c
> @@ -271,7 +271,7 @@ static int ads1015_probe(struct i2c_client *client,
>  			continue;
>  		err = device_create_file(&client->dev, &ads1015_in[k].dev_attr);
>  		if (err)
> -			goto exit_free;
> +			goto exit_remove;
>  	}
>  
>  	data->hwmon_dev = hwmon_device_register(&client->dev);

Good catch.

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
