From: David Miller <davem@davemloft.net>
Date: Fri, 29 Nov 2013 21:26:45 +0000
Subject: Re: [lm-sensors] [PATCH v2] sfc: Convert to use hwmon_device_register_with_groups
Message-Id: <20131129.162645.721442484846350724.davem@davemloft.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1385607271-11842-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1385607271-11842-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux@roeck-us.net
Cc: netdev@vger.kernel.org, linux-net-drivers@solarflare.com, bhutchings@solarflare.com, lm-sensors@lm-sensors.org

From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 27 Nov 2013 18:54:31 -0800

> Simplify the code. Avoid race conditions caused by attributes
> being created after hwmon device registration. Implicitly
> (through hwmon API) add mandatory 'name' sysfs attribute.
> 
> Reviewed-by: Ben Hutchings <bhutchings@solarflare.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Applied, thanks.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
