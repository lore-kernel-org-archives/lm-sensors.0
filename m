From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 28 Jun 2009 19:01:58 +0000
Subject: Re: [lm-sensors] [PATCH 18/62] drivers/hwmon/sht15.c: Remove
Message-Id: <20090628210158.7df366ad@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1246173664.git.joe@perches.com>
	<b74f45f84ee741d41ab6938ea07fed85ee79b0a2.1246173681.git.joe@perches.com>
In-Reply-To: <b74f45f84ee741d41ab6938ea07fed85ee79b0a2.1246173681.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, trivial@kernel.org, lm-sensors@lm-sensors.org

Hi Joe,

On Sun, 28 Jun 2009 09:26:23 -0700, Joe Perches wrote:
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/hwmon/sht15.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
> index 56cd600..6290a25 100644
> --- a/drivers/hwmon/sht15.c
> +++ b/drivers/hwmon/sht15.c
> @@ -257,7 +257,7 @@ static inline int sht15_update_single_val(struct sht15_data *data,
>  				 (data->flag = SHT15_READING_NOTHING),
>  				 msecs_to_jiffies(timeout_msecs));
>  	if (ret = 0) {/* timeout occurred */
> -		disable_irq_nosync(gpio_to_irq(data->pdata->gpio_data));;
> +		disable_irq_nosync(gpio_to_irq(data->pdata->gpio_data));
>  		sht15_connection_reset(data);
>  		return -ETIME;
>  	}

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
