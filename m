From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 27 Feb 2011 07:54:55 +0000
Subject: Re: [lm-sensors] [PATCH 10/17]drivers:hwmon:sht15.c Remove one to
Message-Id: <20110227085455.701a5665@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1298781250-2718-1-git-send-email-justinmattock@gmail.com>
	<1298781250-2718-11-git-send-email-justinmattock@gmail.com>
In-Reply-To: <1298781250-2718-11-git-send-email-justinmattock@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: trivial@kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <guenter.roeck@ericsson.com>, lm-sensors@lm-sensors.org

On Sat, 26 Feb 2011 20:34:03 -0800, Justin P. Mattock wrote:
> The Patch below removes one to many "n's" in a word..

4 spelling mistakes in the summary of a spelling fix patch. Ah, the
irony ;)


> Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>
> CC: Jean Delvare <khali@linux-fr.org>
> CC: Guenter Roeck <guenter.roeck@ericsson.com>
> CC: lm-sensors@lm-sensors.org
> ---
>  drivers/hwmon/sht15.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
> index a610e78..3ba7dd8 100644
> --- a/drivers/hwmon/sht15.c
> +++ b/drivers/hwmon/sht15.c
> @@ -610,7 +610,7 @@ static int __devexit sht15_remove(struct platform_device *pdev)
>  	struct sht15_data *data = platform_get_drvdata(pdev);
>  
>  	/* Make sure any reads from the device are done and
> -	 * prevent new ones beginnning */
> +	 * prevent new ones from beginning */
>  	mutex_lock(&data->read_lock);
>  	hwmon_device_unregister(data->hwmon_dev);
>  	sysfs_remove_group(&pdev->dev.kobj, &sht15_attr_group);

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
