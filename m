From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 10 Jul 2015 17:25:32 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (g762) Drop owner assignment from struct i2c_driver
Message-Id: <20150710172532.GA18655@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Jean Delvare <jdelvare@suse.de>, "open list:HARDWARE MONITORING" <lm-sensors@lm-sensors.org>, open list <linux-kernel@vger.kernel.org>

On Fri, Jul 10, 2015 at 02:51:32PM +0900, Krzysztof Kozlowski wrote:
> i2c_driver does not need to set an owner because i2c_register_driver()
> will set it.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 

Applied to -next.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
