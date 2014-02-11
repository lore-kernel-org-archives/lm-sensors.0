From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 11 Feb 2014 20:23:56 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (jz4740) Use devm_ioremap_resource()
Message-Id: <20140211202356.GE11798@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <000701cf2722$4dba9ac0$e92fd040$%han@samsung.com>
In-Reply-To: <000701cf2722$4dba9ac0$e92fd040$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Feb 11, 2014 at 09:10:50PM +0900, Jingoo Han wrote:
> Use devm_ioremap_resource() in order to make the code simpler,
> and move 'struct resource *mem' from 'struct jz4740_hwmon' to
> jz4740_hwmon_probe() because the 'mem' variable is used only in
> jz4740_hwmon_probe(). Also the redundant return value check of
> platform_get_resource() is removed, because the value is checked
> by devm_ioremap_resource().
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied to -next.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
