From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 10 Jul 2015 17:26:38 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: pmbus: Constify pmbus_regulator_ops
Message-Id: <20150710172638.GA29717@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1436504408.17707.2.camel@ingics.com>
In-Reply-To: <1436504408.17707.2.camel@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Jul 10, 2015 at 01:00:08PM +0800, Axel Lin wrote:
> pmbus_regulator_ops is not modified after initialized, so make it const.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Applied to -next.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
