From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 05 Mar 2013 06:41:44 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (mc13783-adc.c) use module_platform_driver_probe()
Message-Id: <20130305064144.GA10027@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <005401ce194f$54e8b250$feba16f0$%han@samsung.com>
In-Reply-To: <005401ce194f$54e8b250$feba16f0$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Mar 05, 2013 at 12:12:55PM +0900, Jingoo Han wrote:
> This patch uses module_platform_driver_probe() macro which makes
> the code smaller and simpler.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied to -next.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
