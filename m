From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 25 Aug 2014 11:01:58 +0000
Subject: Re: [lm-sensors] [PATCH] iio:inkern: fix overwritten -EPROBE_DEFER in of_iio_channel_get_by_name
Message-Id: <53FB17A6.5000008@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1472905.aEm3bdqRZp@lenovobook>
In-Reply-To: <1472905.aEm3bdqRZp@lenovobook>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Johannes Pointner <johannes.pointner@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On 08/25/2014 01:04 AM, Johannes Pointner wrote:
> This patch fixes the overwritten -EPROBE_DEFER return value in of_iio_channel_get_by_name.
>
> Signed-off-by: Johannes Pointner <johannes.pointner@br-automation.com>

Fixes: a2c12493ed7e ('iio: of_iio_channel_get_by_name() returns non-null pointers for error legs')

which improperly assumes that of_iio_channel_get_by_name must always
return NULL and thus now hides -EPROBE_DEFER.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
