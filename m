From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 25 Mar 2013 13:30:05 +0000
Subject: Re: [lm-sensors] [PATCH v5 5/5] hwmon: add ST-Ericsson ABX500 hwmon driver
Message-Id: <20130325133005.GC895@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1364201328-20881-6-git-send-email-hongbo.zhang@linaro.org>
In-Reply-To: <1364201328-20881-6-git-send-email-hongbo.zhang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Mar 25, 2013 at 04:48:48PM +0800, Hongbo Zhang wrote:
> Each of ST-Ericsson X500 chip set series consists of both ABX500 and DBX500
> chips. This is ABX500 hwmon driver, where the abx500.c is a common layer for
> all ABX500s, and the ab8500.c is specific for AB8500 chip. Under this designed
> structure, other chip specific files can be added simply using the same common
> layer abx500.c.
> 
> Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
> ---

[ ... ]

>  
> +config SENSORS_AB8500
> +	tristate "AB8500 thermal monitoring"
> +	depends on AB8500_GPADC

Unless I am missing something, it also depends on AB8500_BM for the temperature
tables.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
