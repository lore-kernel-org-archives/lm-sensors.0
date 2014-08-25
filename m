From: Jonathan Cameron <jic23@kernel.org>
Date: Mon, 25 Aug 2014 15:57:55 +0000
Subject: Re: [lm-sensors] [PATCH] iio:inkern: fix overwritten -EPROBE_DEFER in of_iio_channel_get_by_name
Message-Id: <53FB5D03.40509@kernel.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1472905.aEm3bdqRZp@lenovobook> <53FB17A6.5000008@roeck-us.net>
In-Reply-To: <53FB17A6.5000008@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>, Johannes Pointner <johannes.pointner@gmail.com>
Cc: linux-iio@vger.kernel.org, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On 25/08/14 12:01, Guenter Roeck wrote:
> On 08/25/2014 01:04 AM, Johannes Pointner wrote:
>> This patch fixes the overwritten -EPROBE_DEFER return value in of_iio_channel_get_by_name.
>>
>> Signed-off-by: Johannes Pointner <johannes.pointner@br-automation.com>
> 
> Fixes: a2c12493ed7e ('iio: of_iio_channel_get_by_name() returns non-null pointers for error legs')
> 
> which improperly assumes that of_iio_channel_get_by_name must always
> return NULL and thus now hides -EPROBE_DEFER.
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Applied to the fixes-togreg branch of iio.git with Guenter's more specific
patch description.  Also marked for stable.

Thanks to both of you for this fix!

J
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
