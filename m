From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 07 May 2014 12:30:04 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon: (iio_hwmon) Make of_device_id array const
Message-Id: <536A274C.4030304@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <020e01cf69ce$66c994a0$345cbde0$%han@samsung.com>
In-Reply-To: <020e01cf69ce$66c994a0$345cbde0$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 05/07/2014 01:29 AM, Jingoo Han wrote:
> Make of_device_id array const, because all OF functions
> handle it as const.
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied to -next.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
