From: Lars-Peter Clausen <lars@metafoo.de>
Date: Thu, 08 Dec 2011 14:08:39 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: jz4740: fix signedness bug
Message-Id: <4EE0C4E7.4050608@metafoo.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1323349452.2823.1.camel@phoenix>
In-Reply-To: <1323349452.2823.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, lm-sensors@lm-sensors.org

On 12/08/2011 02:04 PM, Axel Lin wrote:
> wait_for_completion_interruptible_timeout() may return negative value.
> In this case, checking if (t > 0)  will return true if t is unsigned.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks

> ---
>  drivers/hwmon/jz4740-hwmon.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hwmon/jz4740-hwmon.c b/drivers/hwmon/jz4740-hwmon.c
> index 7a48b1e..3d7e590 100644
> --- a/drivers/hwmon/jz4740-hwmon.c
> +++ b/drivers/hwmon/jz4740-hwmon.c
> @@ -59,7 +59,7 @@ static ssize_t jz4740_hwmon_read_adcin(struct device *dev,
>  {
>  	struct jz4740_hwmon *hwmon = dev_get_drvdata(dev);
>  	struct completion *completion = &hwmon->read_completion;
> -	unsigned long t;
> +	long t;
>  	unsigned long val;
>  	int ret;
>  


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
