From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 05 Apr 2013 02:25:22 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ad7314) use spi_get_drvdata() and spi_set_drvdata()
Message-Id: <20130405022522.GA2226@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <000901ce31a0$1798a090$46c9e1b0$%han@samsung.com>
In-Reply-To: <000901ce31a0$1798a090$46c9e1b0$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Apr 05, 2013 at 10:51:29AM +0900, Jingoo Han wrote:
> Use the wrapper functions for getting and setting the driver data using
> spi_device instead of using dev_{get|set}_drvdata with &spi->dev, so we
> can directly pass a struct spi_device.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied to -next.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
