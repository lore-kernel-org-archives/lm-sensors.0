From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 18 Sep 2007 21:15:48 +0000
Subject: Re: [lm-sensors] [PATCH] adm1021: dynamic sysfs callbacks
Message-Id: <20070918231548.00755501@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070909184151.5abc783a@hyperion.delvare>
In-Reply-To: <20070909184151.5abc783a@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 9 Sep 2007 19:51:14 +0200, Krzysztof Helt wrote:
> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> This is conversion of the driver  to the dynamic sysfs callbacks.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

Looks good to me this time.

Acked-by: Jean Delvare <khali@linux-fr.org>

Could anyone please post a dump of any device supported by the adm1021
driver? This would allow me to test changes made to that driver using
i2c-stub.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
