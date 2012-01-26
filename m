From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 26 Jan 2012 21:39:00 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (SHT15) fix bad error code
Message-Id: <20120126213900.GA23534@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327611540-21023-1-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1327611540-21023-1-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Cc: "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, Jean Delvare <khali@linux-fr.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Jan 26, 2012 at 03:59:00PM -0500, Vivien Didelot wrote:
> When no platform data was supplied, returned error code was 0.
> 
> Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
> ---
>  drivers/hwmon/sht15.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
> index fe4104c..5357925 100644
> --- a/drivers/hwmon/sht15.c
> +++ b/drivers/hwmon/sht15.c
> @@ -883,7 +883,7 @@ static int sht15_invalidate_voltage(struct notifier_block *nb,
>  
>  static int __devinit sht15_probe(struct platform_device *pdev)
>  {
> -	int ret = 0;
> +	int ret;
>  	struct sht15_data *data = kzalloc(sizeof(*data), GFP_KERNEL);
>  	u8 status = 0;
>  
> @@ -901,6 +901,7 @@ static int __devinit sht15_probe(struct platform_device *pdev)
>  	init_waitqueue_head(&data->wait_queue);
>  
>  	if (pdev->dev.platform_data = NULL) {
> +		ret = -EINVAL;
>  		dev_err(&pdev->dev, "no platform data supplied\n");
>  		goto err_free_data;
>  	}
> -- 
> 1.7.6.5
> 
Good catch. Applied.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
