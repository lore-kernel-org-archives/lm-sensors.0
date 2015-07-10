From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 10 Jul 2015 17:26:12 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: pmbus: Explicitly set regulator type for pmbus_regulator_ops
Message-Id: <20150710172612.GA18697@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1436504353.17707.1.camel@ingics.com>
In-Reply-To: <1436504353.17707.1.camel@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Jul 10, 2015 at 12:59:13PM +0800, Axel Lin wrote:
> The pmbus_regulator_ops is for voltage regulators, so explicitly set
> regulator type for better readability.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Applied to -next.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
