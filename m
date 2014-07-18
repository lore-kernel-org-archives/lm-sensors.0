From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 18 Jul 2014 05:16:00 +0000
Subject: Re: [lm-sensors] [RFT][PATCH 2/2] hwmon: (thmc50) Convert to devm_hwmon_device_register_with_groups
Message-Id: <53C8AD90.3080902@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1405595168.13586.4.camel@phoenix>
In-Reply-To: <1405595168.13586.4.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/17/2014 04:06 AM, Axel Lin wrote:
> Use devm_hwmon_device_register_with_groups() to simplify the code a bit.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Applied to -next.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
