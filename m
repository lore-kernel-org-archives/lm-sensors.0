From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 07 May 2014 12:29:38 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] hwmon: (gpio-fan) Make of_device_id array const
Message-Id: <536A2732.7040709@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <020d01cf69ce$3e6b90d0$bb42b270$%han@samsung.com>
In-Reply-To: <020d01cf69ce$3e6b90d0$bb42b270$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 05/07/2014 01:27 AM, Jingoo Han wrote:
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
